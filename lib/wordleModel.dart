void main() {
  //List<String> guess = ['l', 'o', 'l', 'l', 'o'];
  // ignore: avoid_print
  //print(judge(guess));
  List<List<String>> lists =
      List.generate(6, (index) => List.generate(5, ((index) => 'a')));
  print(lists);
}

class WordleModel {
  static const empty = 'Empty';
  static const hit = 'hit';
  static const blow = 'blow';
  static const miss = 'miss';

  List<String> key = ['h', 'e', 'l', 'l', 'o'];

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
