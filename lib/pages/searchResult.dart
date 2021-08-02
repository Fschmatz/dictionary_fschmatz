import 'dart:convert';

import 'package:dictionary_fschmatz/classes/word.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SearchResult extends StatefulWidget {
  String searchedWord;

  SearchResult({Key? key, required this.searchedWord}) : super(key: key);

  @override
  _SearchResultState createState() => _SearchResultState();
}

class _SearchResultState extends State<SearchResult> {
  String urlApi = '';
  bool loading = true;
  Word? searchedWordData;

  @override
  void initState() {
    urlApi = 'https://api.dictionaryapi.dev/api/v2/entries/en_US/' +
        widget.searchedWord;
    searchWord();
    super.initState();
  }

  Future<void> searchWord() async {
    final response = await http.get(Uri.parse(urlApi));
    if (response.statusCode == 200) {
      Word w = Word.fromJSON(jsonDecode(response.body));

      setState(() {
        searchedWordData = w;
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
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
                ListTile(title: Text(searchedWordData.toString())),
              ],
            ),
      ),
    );
  }
}
