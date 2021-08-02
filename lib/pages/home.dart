import 'dart:async';
import 'dart:convert';
import 'package:dictionary_fschmatz/classes/word.dart';
import 'package:dictionary_fschmatz/configs/settingsPage.dart';
import 'package:dictionary_fschmatz/pages/searchResult.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //API PAGE
  //https://dictionaryapi.dev/

  TextEditingController controllerTextWordSearch = TextEditingController();

  // PALAVRA DE TESTE 'HELLO' EM INGLES
  String urlApi = 'https://api.dictionaryapi.dev/api/v2/entries/en_US/hello';

  //---- TESTES DELETAR DEPOIS
  @override
  void initState() {
    //searchWord();
    super.initState();
  }

/*  Future<void> searchWord() async {
    final response = await http.get(Uri.parse(urlApi));
    if (response.statusCode == 200) {
      Word w = Word.fromJSON(jsonDecode(response.body));
      print(w.toString());
      setState(() {
        //loading = false;
        //   eventsList = listaEvents;
      });
    }
  }*/

  //---- TESTES DELETAR DEPOIS

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
                          Navigator.of(context).pop();
                          Navigator.push(
                              context,
                              MaterialPageRoute<void>(
                                builder: (BuildContext context) => SearchResult(
                                    searchedWord:
                                        controllerTextWordSearch.text),
                                fullscreenDialog: true,
                              ));
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
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            title: Text('Dictionary'),
          ),
          body: ListView(physics: AlwaysScrollableScrollPhysics(), children: [
            ListTile(
                leading: Icon(Icons.history_outlined),
                title: Text("History".toUpperCase(),
                    style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: Theme.of(context)
                            .accentTextTheme
                            .headline1!
                            .color))),
            ListView.separated(
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(),
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: 12,
              itemBuilder: (context, index) {
                return ListTile(title: Text('Word ' + (index + 1).toString()));
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
