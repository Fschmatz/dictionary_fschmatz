import 'dart:async';
import 'dart:convert';
import 'package:animated_button_bar/animated_button_bar.dart';
import 'package:dictionary_fschmatz/classes/word.dart';
import 'package:dictionary_fschmatz/configs/settingsPage.dart';
import 'package:dictionary_fschmatz/db/historyDao.dart';
import 'package:dictionary_fschmatz/pages/searchResult.dart';
import 'package:dictionary_fschmatz/widgets/tileHistory.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //API PAGE
  //https://dictionaryapi.dev/

  String selectedLanguage = 'en_US'; //Always Start with English
  List<Map<String, dynamic>> history = [];
  TextEditingController controllerTextWordSearch = TextEditingController();
  String urlApi = 'https://api.dictionaryapi.dev/api/v2/entries/';
  bool loadingSearch = false;
  bool loadingHistory = true;
  Word? searchedWordData;
  TextStyle styleButtonsLang =
      TextStyle(fontSize: 13);

  @override
  void initState() {
    _getWordHistory();
    super.initState();
  }

  Future<void> _searchWord(String lang, String word,bool fromHistory) async {
    setState(() {
      loadingSearch = true;
    });

    final response = await http.get(Uri.parse(urlApi  + lang + '/' + word));
    if (response.statusCode == 200) {
      Word wordData = Word.fromJSON(jsonDecode(response.body));
      if(!fromHistory){_saveWordToHistory();}
      setState(() {
        searchedWordData = wordData;
        loadingSearch = false;
      });
      //OPEN SEARCH RESULTS
      Navigator.push(
              context,
              MaterialPageRoute<void>(
                builder: (BuildContext context) =>
                    SearchResult(searchedWord: searchedWordData!),
                fullscreenDialog: true,
              ))
          .then((value) =>
              {_getWordHistory(), controllerTextWordSearch.text = ''});
    } else {
      setState(() {
        loadingSearch = false;
      });
      Fluttertoast.showToast(
        msg: "Word Not Found",
        toastLength: Toast.LENGTH_SHORT,
      );
    }
  }

  void _saveWordToHistory() async {
    final dbHistory = HistoryDao.instance;
    Map<String, dynamic> row = {
      HistoryDao.columnWord: controllerTextWordSearch.text,
      HistoryDao.columnLanguage: selectedLanguage,
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

  void _loseFocus() {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    Color? textAccent = Theme.of(context).accentTextTheme.headline1!.color;

    return GestureDetector(
      onTap: () {
        _loseFocus();
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text('Dictionary Fschmatz'),
          bottom: PreferredSize(
              preferredSize: Size(double.infinity, 3),
              child: loadingSearch
                  ? LinearProgressIndicator(
                      minHeight: 3,
                      valueColor: new AlwaysStoppedAnimation<Color>(
                          Theme.of(context).accentColor.withOpacity(0.8)),
                      backgroundColor:
                          Theme.of(context).accentColor.withOpacity(0.3),
                    )
                  : SizedBox(height: 3,)),
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
        body: ListView(physics: AlwaysScrollableScrollPhysics(), children: [
          ListTile(
              leading: Icon(Icons.language_outlined, color: textAccent),
              title: Text("Language".toUpperCase(),
                  style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: textAccent))),
          AnimatedButtonBar(
            radius: 25,
            padding: const EdgeInsets.fromLTRB(16, 5, 16, 10),
            backgroundColor: Theme.of(context).cardTheme.color,
            foregroundColor: Theme.of(context).accentColor.withOpacity(0.8),
            elevation: 0,
            borderWidth: 1,
            borderColor: Colors.transparent,
            innerVerticalPadding: 18.1,
            children: [
              ButtonBarEntry(
                  onTap: () => selectedLanguage = 'en_US',
                  child: Text('EN-US', style: styleButtonsLang)),
              ButtonBarEntry(
                  onTap: () => selectedLanguage = 'pt-BR',
                  child: Text('PT-BR', style: styleButtonsLang)),
              ButtonBarEntry(
                  onTap: () => selectedLanguage = 'es',
                  child: Text('ES', style: styleButtonsLang)),
              ButtonBarEntry(
                  onTap: () => selectedLanguage = 'fr',
                  child: Text('FR', style: styleButtonsLang)),
            ],
          ),
          ListTile(
              leading: Icon(Icons.search_outlined, color: textAccent),
              title: Text("Search Word".toUpperCase(),
                  style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: textAccent))),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 5, 16, 10),
            child: TextField(
                minLines: 1,
                textCapitalization: TextCapitalization.sentences,
                controller: controllerTextWordSearch,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 17,
                ),
                decoration: InputDecoration(
                  filled: true,
                ),
                onEditingComplete: () {
                  if (controllerTextWordSearch.text.isNotEmpty) {
                    _loseFocus();
                    _searchWord(
                        selectedLanguage, controllerTextWordSearch.text,false);
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
              : Column(
                  children: [
                    ListView.separated(
                      separatorBuilder: (BuildContext context, int index) =>
                          Visibility(
                        visible: history[index]['word'] != ' ',
                        child: const Divider(
                          height: 0,
                        ),
                      ),
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: history.length,
                      itemBuilder: (context, index) {
                        return Visibility(
                          visible: history[index]['word'] != ' ',
                          child: TileHistory(
                            key: UniqueKey(),
                            word: history[index]['word'],
                            language: history[index]['language'],
                            loseFocus: _loseFocus,
                            search: _searchWord,
                          ),
                        );
                      },
                    ),
                  ],
                ),
          const SizedBox(
            height: 50,
          )
        ]),
      ),
    );
  }
}
