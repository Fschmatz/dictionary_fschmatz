import 'package:dictionary_fschmatz/pages/searchResult.dart';
import 'package:flutter/material.dart';

class TileHistory extends StatefulWidget {
  String word;
  String language;
  Function() loseFocus;

  TileHistory(
      {Key? key,
      required this.word,
      required this.language,
      required this.loseFocus})
      : super(key: key);

  @override
  _TileHistoryState createState() => _TileHistoryState();
}

class _TileHistoryState extends State<TileHistory> {
  String? getLanguagueFormatted() {
    if (widget.language == 'en_US') {
      return 'EN-US';
    } else if (widget.language == 'pt-BR') {
      return 'PT-BR';
    } else if (widget.language == 'es') {
      return 'ES';
    } else {
      return 'FR';
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute<void>(
              builder: (BuildContext context) => SearchResult(
                  searchedWord: widget.word, language: widget.language),
              fullscreenDialog: true,
            ));
      },
      contentPadding: const EdgeInsets.fromLTRB(16, 3, 16, 3),
      title: Text(widget.word),
      trailing: Text(
        getLanguagueFormatted()!,
        style: TextStyle(
          color: Theme.of(context).textTheme.headline6!.color!.withOpacity(0.6),
        ),
      ),
    );
  }
}
