import 'words_model.dart';

void main() {
  //List<String> guess = ['l', 'o', 'l', 'l', 'o'];
  // ignore: avoid_print
  //print(judge(guess));
  List<String> guess = ['l', 'o', 'l', 'l', 'o'];
  print(guess.join(''));
}

class WordleModel {
  static const notEvaluated = 'notEvaluated';
  static const hit = 'hit';
  static const blow = 'blow';
  static const miss = 'miss';

  List<String> key = WordsModel.chooseKey().split('');

  static bool isValid(List<String> guess) {
    return WordsModel.searchWord(guess.join(''));
  }

  void reselectKey() {
    key = WordsModel.chooseKey().split('');
  }

  List<String> judge(List<String> guess) {
    List<String> result = [miss, miss, miss, miss, miss];
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
