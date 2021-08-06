import 'dart:convert';
import 'package:dictionary_fschmatz/classes/word.dart';
import 'package:dictionary_fschmatz/db/historyDao.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class SearchResult extends StatefulWidget {
  String searchedWord;
  String language;

  SearchResult({Key? key, required this.searchedWord,required this.language}) : super(key: key);

  @override
  _SearchResultState createState() => _SearchResultState();
}

class _SearchResultState extends State<SearchResult> {
  String urlApiSearch = 'https://api.dictionaryapi.dev/api/v2/entries/';
  bool loading = true;
  Word? searchedWordData;

  @override
  void initState() {
    urlApiSearch += widget.language + '/' + widget.searchedWord;
    _searchWord();
    super.initState();
  }

  Future<void> _searchWord() async {
    final response = await http.get(Uri.parse(urlApiSearch));
    if (response.statusCode == 200) {
      Word w = Word.fromJSON(jsonDecode(response.body));
      setState(() {
        searchedWordData = w;
        _saveWordToHistory();
        loading = false;
      });
    }else{
      Navigator.of(context).pop();
      Fluttertoast.showToast(
          msg: "Word Not Found",
          toastLength: Toast.LENGTH_SHORT,
      );
    }
  }

  void _saveWordToHistory() async {
    final dbHistory = HistoryDao.instance;
    Map<String, dynamic> row = {
      HistoryDao.columnWord: widget.searchedWord,
      HistoryDao.columnLanguage: widget.language,
    };
    final id = await dbHistory.insert(row);
  }

  @override
  Widget build(BuildContext context) {
    Color? textAccent = Theme.of(context).accentTextTheme.headline1!.color;
    TextStyle textWithColor =
        TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: textAccent);

    return Scaffold(
      appBar: AppBar(
        title: Text("Results"),
        elevation: 0,
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
                children: [
                  Visibility(
                    visible: searchedWordData!.word != 'null',
                    child: Column(
                      children: [
                        ListTile(
                            title: Text("Word".toUpperCase(),
                                style: textWithColor)),
                        ListTile(title: Text(searchedWordData!.word)),
                      ],
                    ),
                  ),
                  Visibility(
                    visible: searchedWordData!.phoneticsText != 'null',
                    child: Column(
                      children: [
                        const Divider(),
                        ListTile(
                            title: Text("Phonetics".toUpperCase(),
                                style: textWithColor)),
                        ListTile(title: Text(searchedWordData!.phoneticsText)),
                      ],
                    ),
                  ),
                  Visibility(
                    visible: searchedWordData!.meaningsPartOfSpeech != 'null',
                    child: Column(
                      children: [
                        const Divider(),
                        ListTile(
                            title: Text("Part of Speech".toUpperCase(),
                                style: textWithColor)),
                        ListTile(
                            title:
                                Text(searchedWordData!.meaningsPartOfSpeech)),
                      ],
                    ),
                  ),
                  Visibility(
                    visible: searchedWordData!.meaningsDefinitions != 'null',
                    child: Column(
                      children: [
                        const Divider(),
                        ListTile(
                            title: Text("Definitions".toUpperCase(),
                                style: textWithColor)),
                        ListTile(
                            title: Text(searchedWordData!.meaningsDefinitions)),
                      ],
                    ),
                  ),
                  Visibility(
                    visible:
                        searchedWordData!.meaningsDefinitionsExample != 'null',
                    child: Column(
                      children: [
                        const Divider(),
                        ListTile(
                            title: Text("Definition Example".toUpperCase(),
                                style: textWithColor)),
                        ListTile(
                            title: Text(
                                searchedWordData!.meaningsDefinitionsExample)),
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
