import 'dart:async';
import 'dart:convert';
import 'package:dictionary_fschmatz/classes/word.dart';
import 'package:dictionary_fschmatz/configs/settingsPage.dart';
import 'package:dictionary_fschmatz/db/historyDao.dart';
import 'package:dictionary_fschmatz/pages/searchResult.dart';
import 'package:dictionary_fschmatz/widgets/tileHistory.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //API PAGE
  //https://dictionaryapi.dev/

  List<Map<String, dynamic>> history = [];

  TextEditingController controllerTextWordSearch = TextEditingController();
  bool loadingHistory = true;
  String selectedLanguage = 'en_US';

  @override
  void initState() {
    _getWordHistory();
    super.initState();
  }

  void _saveWordHistory() async {
    final dbHistory = HistoryDao.instance;
    Map<String, dynamic> row = {
      HistoryDao.columnWord: controllerTextWordSearch.text,
      HistoryDao.columnLanguage: 'en_US',
    };
    final id = await dbHistory.insert(row);
  }

  Future<void> _getWordHistory() async {
    final dbHistory = HistoryDao.instance;
    var resp = await dbHistory.queryAllRowsDesc();
    setState(() {
      history = resp;
      loadingHistory = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    Color? textAccent = Theme.of(context).accentTextTheme.headline1!.color;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('Dictionary'),
        actions: [
          IconButton(
              color: Theme.of(context)
                  .textTheme
                  .headline6!
                  .color!
                  .withOpacity(0.8),
              icon: Icon(
                Icons.settings_outlined,
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute<void>(
                      builder: (BuildContext context) => SettingsPage(),
                      fullscreenDialog: true,
                    ));
              }),
        ],
      ),
      body: ListView(physics: NeverScrollableScrollPhysics(), children: [
        ListTile(
          contentPadding: const EdgeInsets.fromLTRB(16, 20, 16, 20),
          title: TextField(
              minLines: 1,
              textCapitalization: TextCapitalization.sentences,
              keyboardType: TextInputType.name,
              controller: controllerTextWordSearch,
              style: TextStyle(
                fontSize: 16,
              ),
              decoration: InputDecoration(
                  filled: true,
                  hintText: 'Search Word',
                  prefixIcon: Icon(Icons.notes_outlined)),
              onEditingComplete: () {
                if (controllerTextWordSearch.text.isNotEmpty) {
                  _saveWordHistory();
                  Navigator.push(
                          context,
                          MaterialPageRoute<void>(
                            builder: (BuildContext context) => SearchResult(
                                searchedWord: controllerTextWordSearch.text,
                                language: selectedLanguage),
                            fullscreenDialog: true,
                          ))
                      .then((value) => {
                            _getWordHistory(),
                            controllerTextWordSearch.text = ''
                          });
                }
              }),
        ),
        ListTile(
            leading: Icon(Icons.history_outlined, color: textAccent),
            title: Text("History".toUpperCase(),
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: textAccent))),
        loadingHistory
            ? SizedBox.shrink()
            : ListView.separated(
                separatorBuilder: (BuildContext context, int index) =>
                    Visibility(
                  visible: history[index]['word'] != ' ',
                  child: const Divider(
                    height: 0,
                  ),
                ),
                physics: AlwaysScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: history.length,
                itemBuilder: (context, index) {
                  return Visibility(
                    visible: history[index]['word'] != ' ',
                    child: TileHistory(
                      key: UniqueKey(),
                      word: history[index]['word'],
                      language: history[index]['language'],
                    ),
                  );
                },
              ),
        const SizedBox(
          height: 50,
        )
      ]),
    );
  }
}
