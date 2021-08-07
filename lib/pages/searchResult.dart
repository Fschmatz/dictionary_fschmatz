import 'package:dictionary_fschmatz/classes/word.dart';
import 'package:flutter/material.dart';

class SearchResult extends StatefulWidget {
  Word searchedWord;

  SearchResult({Key? key, required this.searchedWord}) : super(key: key);

  @override
  _SearchResultState createState() => _SearchResultState();
}

class _SearchResultState extends State<SearchResult> {
  Word? searchedWordData;

  @override
  void initState() {
    searchedWordData = widget.searchedWord;
    super.initState();
  }

  Widget showTextFromJson(
      String text,String sectionName, TextStyle textWithColor, bool showDivider) {
    return Visibility(
      visible: text != 'null',
      child: Column(
        children: [
          Visibility(visible: showDivider, child: const Divider()),
          ListTile(title: Text(sectionName.toUpperCase(), style: textWithColor)),
          ListTile(title: Text(text)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Color? textAccent = Theme.of(context).accentTextTheme.headline1!.color;
    TextStyle textWithColor =
        TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: textAccent);

    return Scaffold(
      appBar: AppBar(
        title: Text("Search Results"),
        elevation: 0,
      ),
      body: AnimatedSwitcher(
        duration: Duration(milliseconds: 600),
        child: ListView(
          children: [
            showTextFromJson(searchedWordData!.word,'Word', textWithColor, false),
            showTextFromJson(
                searchedWordData!.phoneticsText,'Phonetics', textWithColor, true),
            showTextFromJson(
                searchedWordData!.meaningsPartOfSpeech,'Part of Speech', textWithColor, true),
            showTextFromJson(
                searchedWordData!.meaningsDefinitions,'Definitions', textWithColor, true),
            showTextFromJson(searchedWordData!.meaningsDefinitionsExample,'Definition Example',
                textWithColor, true),
          ],
        ),
      ),
    );
  }
}
