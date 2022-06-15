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
      String text,String sectionName, TextStyle textWithColor) {
    return Visibility(
      visible: text.isNotEmpty && text != 'null',
      child: Column(
        children: [
          ListTile(title: Text(sectionName, style: textWithColor)),
          ListTile(title: Text(text)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Color? textAccent = Theme.of(context).colorScheme.primary;
    TextStyle styleTextWithColor =
        TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: textAccent);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Search Results"),
        elevation: 0,
      ),
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 600),
        child: ListView(
          children: [
            showTextFromJson(searchedWordData!.word,'Word', styleTextWithColor ),
            showTextFromJson(
                searchedWordData!.phoneticsText,'Phonetics', styleTextWithColor),
            showTextFromJson(
                searchedWordData!.meaningsPartOfSpeech,'Part of Speech', styleTextWithColor),
            showTextFromJson(
                searchedWordData!.meaningsDefinitions,'Definitions', styleTextWithColor),
            showTextFromJson(searchedWordData!.meaningsDefinitionsExample,'Definition Example',
                styleTextWithColor),//synonyms
            showTextFromJson(searchedWordData!.formattedSynonymsList().toString(),'Synonyms',
                styleTextWithColor),
            const SizedBox(height: 50,)
          ],
        ),
      ),
    );
  }
}
