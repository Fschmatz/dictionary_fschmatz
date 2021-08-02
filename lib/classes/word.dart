import 'package:dynamic_value/dynamic_value.dart';

class Word {
  final String word;
  final String phoneticsText;
  final String meaningsPartOfSpeech;
  final String meaningsDefinitions;
  final String meaningsDefinitionsExample;

  Word({required this.word,required this.phoneticsText,required this.meaningsPartOfSpeech,required this.meaningsDefinitions,required this.meaningsDefinitionsExample });

  factory Word.fromJSON(dynamic json) {

    final value = DynamicValue(json);

    return Word(
      word: value[0]['word'].toString(),
      phoneticsText: value[0]['phonetics'][0]['text'].toString(),
      meaningsPartOfSpeech: value[0]['meanings'][0]['partOfSpeech'].toString(),
      meaningsDefinitions:  value[0]['meanings'][0]['definitions'][0]['definition'].toString(),
      meaningsDefinitionsExample: value[0]['meanings'][0]['definitions'][0]['example'].toString(),
    );
  }

  @override
  String toString() {
    return 'Word\n{\nword: $word,\n\n phoneticsText: $phoneticsText,\n\n meaningsPartOfSpeech: $meaningsPartOfSpeech,\n\n meaningsDefinitions: $meaningsDefinitions,\n\n meaningsDefinitionsExample: $meaningsDefinitionsExample \n}';
  }
}
