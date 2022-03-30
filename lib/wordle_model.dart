import 'package:flutter/foundation.dart';
import 'words_model.dart';

void main() {
  //List<String> guess = ['l', 'o', 'l', 'l', 'o'];
  // ignore: avoid_print
  //print(judge(guess));
  List<String> guess = ['l', 'o', 'l', 'l', 'o'];
  print(guess.join(''));
}

class WordleModel {
  static const int notEvaluated = 0;
  static const int hit = 3;
  static const int blow = 2;
  static const int miss = 1;

  List<String> key = WordsModel.chooseKey().split('');

  static bool isValid(List<String> guess) {
    return WordsModel.searchWord(guess.join(''));
  }

  static bool isWin(List<int> result) {
    return listEquals(result, List.generate(5, (index) => hit));
  }

  void reselectKey() {
    key = WordsModel.chooseKey().split('');
  }

  List<int> judge(List<String> guess) {
    List<int> result = [miss, miss, miss, miss, miss];
    List<String> surplus = [];

    for (var i = 0; i < 5; i++) {
      if (guess[i] == key[i]) {
        result[i] = hit;
      } else {
        surplus.add(key[i]);
      }
    }
    for (var i = 0; i < 5; i++) {
      if (result[i] == miss && surplus.contains(guess[i])) {
        surplus.remove(guess[i]);
        result[i] = blow;
      }
    }
    return result;
  }
}
