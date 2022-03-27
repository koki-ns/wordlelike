void main() {
  //List<String> guess = ['l', 'o', 'l', 'l', 'o'];
  // ignore: avoid_print
  //print(judge(guess));
  List<List<String>> lists =
      List.generate(6, (index) => List.generate(5, ((index) => 'a')));
  print(lists);
}

final empty = 'Empty';
final hit = 'hit';
final blow = 'blow';
final miss = 'miss';

List<List<String>> charsLists = [[], [], [], [], [], []];
List<String> key = ['h', 'e', 'l', 'l', 'o'];
//現在入力する行を指し示す
int rowNumber = 0;
//次に入力するポイントを指し示す
int columnNumber = 0;

void input(char) {
  if (columnNumber < 6) {
    charsLists[rowNumber][columnNumber] = char;
    ++columnNumber;
  }
}

void backSpace() {
  if (columnNumber >= 1) {
    --columnNumber;
    charsLists[rowNumber][columnNumber] = empty;
  }
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

void reset() {
  for (var list in charsLists) {
    for (var i = 0; i < 5; i++) {
      list.add(empty);
    }
  }
}
