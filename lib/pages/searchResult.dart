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
      visible: text.isNotEmpty && text != 'null',
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
    TextStyle styleTextWithColor =
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
            showTextFromJson(searchedWordData!.word,'Word', styleTextWithColor, false),
            showTextFromJson(
                searchedWordData!.phoneticsText,'Phonetics', styleTextWithColor, true),
            showTextFromJson(
                searchedWordData!.meaningsPartOfSpeech,'Part of Speech', styleTextWithColor, true),
            showTextFromJson(
                searchedWordData!.meaningsDefinitions,'Definitions', styleTextWithColor, true),
            showTextFromJson(searchedWordData!.meaningsDefinitionsExample,'Definition Example',
                styleTextWithColor, true),//synonyms
            showTextFromJson(searchedWordData!.formattedSynonymsList().toString(),'Synonyms',
                styleTextWithColor, true),
            const SizedBox(height: 50,)
          ],
        ),
      ),
    );
  }
}
