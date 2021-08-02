import 'dart:async';
import 'dart:convert';
import 'package:dictionary_fschmatz/classes/word.dart';
import 'package:dictionary_fschmatz/configs/settingsPage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with AutomaticKeepAliveClientMixin {

  //API PAGE
  //https://dictionaryapi.dev/

  bool loading = false;

  // PALAVRA DE TESTE 'HELLO' EM INGLES
  String urlApi = 'https://api.dictionaryapi.dev/api/v2/entries/en_US/hello';


  @override
  void initState() {
    searchWord();
    super.initState();
  }

  @override
  bool get wantKeepAlive => true;

  Future<void> searchWord() async {
    final response = await http.get(Uri.parse(urlApi));
    if (response.statusCode == 200) {

      Word w = Word.fromJSON(jsonDecode(response.body));
      print(w.toString());
      setState(() {
        //loading = false;
     //   eventsList = listaEvents;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            title: Text('Dictionary'),
          ),
          body: AnimatedSwitcher(
            duration: Duration(milliseconds: 600),
            child: loading
                ? Center(
                    child: CircularProgressIndicator(
                      color: Theme.of(context).accentColor,
                    ),
                  )
                : ListView(
                    physics: AlwaysScrollableScrollPhysics(),
                    children: [
                      ListTile(
                          leading: Icon(Icons.history_outlined),
                          title: Text("History".toUpperCase(),
                              style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700,
                                  color: Theme.of(context).accentTextTheme.headline1!.color))),
                        ListView.separated(
                          separatorBuilder: (BuildContext context, int index) =>
                              const Divider(
                            height: 0,
                          ),
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: 12, //12 ou 15?
                          itemBuilder: (context, index) {
                            return ListTile(title: Text('oi -> '+index.toString() )
                            );
                          },
                        ),
                        const SizedBox(
                          height: 50,
                        )
                      ]),
          ),
          floatingActionButton: FloatingActionButton(
            elevation: 0.0,
            onPressed: () {
             // chooseDate();
            },
           child: Icon(
             Icons.search_outlined,
           ),

          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
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
