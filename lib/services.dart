import 'dart:convert';
import 'package:wordsapp/words_model.dart';
import 'package:http/http.dart' as http;

class Services {
  Future<List<WordsModel>> getData(String word) async {
    var url = 'https://api.dictionaryapi.dev/api/v2/entries/en/$word';
    List<WordsModel> wordsListem = [];
    var res = await http.get(Uri.parse(url));
    if (res.statusCode == 200) {
      for (var item in jsonDecode(res.body)) {
        var result = WordsModel.fromJson(item);
        wordsListem.add(result);
      }
    }
    return wordsListem;
  }
}
