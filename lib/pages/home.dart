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

  List<String> history = [];
  TextEditingController controllerTextWordSearch = TextEditingController();
  bool loadingHistory = true;

  @override
  void initState() {
    _getWordHistory(false);
    super.initState();
  }

  void _saveWordHistory() async {
    final dbHistory = HistoryDao.instance;
    Map<String, dynamic> row = {
      HistoryDao.columnWord: controllerTextWordSearch.text,
    };
    final id = await dbHistory.insert(row);
  }

  Future<void> _getWordHistory(bool refresh) async {
    final dbHistory = HistoryDao.instance;
    var resp = await dbHistory.queryAllRowsDesc();

    //CLEAR LIST
    if (refresh) {
      history.removeRange(0, history.length);
    }

    for (int i = 0; i < resp.length; i++) {
      history.add(resp[i]['word']);
    }
    setState(() {
      loadingHistory = false;
    });
  }

  void openBottomMenuSearch() {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(30.0),
              topRight: const Radius.circular(30.0)),
        ),
        isScrollControlled: true,
        context: context,
        builder: (BuildContext bc) {
          return Container(
            child: Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Wrap(
                children: <Widget>[
                  ListTile(
                      contentPadding: const EdgeInsets.fromLTRB(16, 5, 16, 0),
                      title: Center(
                          child: Text('Search Word',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              )))),
                  Divider(
                    height: 0,
                  ),
                  ListTile(
                    contentPadding: const EdgeInsets.fromLTRB(16, 20, 16, 20),
                    title: TextField(
                        minLines: 1,
                        maxLines: 2,
                        autofocus: true,
                        textCapitalization: TextCapitalization.sentences,
                        keyboardType: TextInputType.name,
                        controller: controllerTextWordSearch,
                        style: TextStyle(
                          fontSize: 16,
                        ),
                        onEditingComplete: () {
                          if (controllerTextWordSearch.text.isNotEmpty) {
                            _saveWordHistory();
                            Navigator.of(context).pop();
                            Navigator.push(
                                    context,
                                    MaterialPageRoute<void>(
                                      builder: (BuildContext context) =>
                                          SearchResult(
                                              searchedWord:
                                                  controllerTextWordSearch
                                                      .text),
                                      fullscreenDialog: true,
                                    ))
                                .then((value) => {
                                      _getWordHistory(true),
                                      controllerTextWordSearch.text = ''
                                    });
                          } else {
                            Navigator.of(context).pop();
                          }
                        }),
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    Color? textAccent = Theme.of(context).accentTextTheme.headline1!.color;

    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            title: Text('Dictionary'),
          ),
          body: ListView(physics: AlwaysScrollableScrollPhysics(), children: [
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
                      visible: history[index] != ' ',
                      child: const Divider(
                        height: 0,
                      ),
                    ),
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: history.length,
                    itemBuilder: (context, index) {
                      return Visibility(
                        visible: history[index] != ' ',
                        child: TileHistory(
                          key: UniqueKey(),
                          word: history[index],
                        ),
                      );
                    },
                  ),
            const SizedBox(
              height: 50,
            )
          ]),
          floatingActionButton: FloatingActionButton(
            elevation: 0.0,
            onPressed: () {
              openBottomMenuSearch();
            },
            child: Icon(
              Icons.search_outlined,
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: BottomAppBar(
            child: Container(
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
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
                ])),
          )),
    );
  }
}
