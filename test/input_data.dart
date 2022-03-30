import 'wordle_model.dart';

class InputData {
  List<List<Character>> charsLists =
      List.generate(6, (index) => List.generate(5, ((index) => Character())));

  //現在入力する行を指し示す
  int rowNumber = 0;
  //次に入力するポイントを指し示す
  int columnNumber = 0;

  WordleModel model = WordleModel();

  String getChar(int row, int column) {
    String str = charsLists[row][column].getChar();
    if (str == Character.empty) {
      return ' ';
    } else {
      return str;
    }
  }

  void input(char) {
    if (columnNumber < 5) {
      charsLists[rowNumber][columnNumber].setChar(char);
      ++columnNumber;
    }
  }

  void backSpace() {
    if (columnNumber >= 1) {
      --columnNumber;
      charsLists[rowNumber][columnNumber].setChar(Character.empty);
    }
  }

  Message canEnter() {
    List<String> guess;
    List<String> result;

    if (columnNumber < 5) {
      //入力終わってないエラー処理
      return Message(success: false, message: 'Not enough letters');
    } else {
      guess =
          List.generate(5, (index) => charsLists[rowNumber][index].getChar());
      if (!WordleModel.isValid(guess)) {
        //not in Word List
        return Message(success: false, message: 'Not in word list');
      }
      result = model.judge(guess);
    }
  }
}

class Character {
  static const String empty = 'empty';

  String char;
  String status;

  Character([this.char = empty, this.status = WordleModel.notEvaluated]);

  bool isEmpty() {
    if (char == empty) {
      return true;
    } else {
      return false;
    }
  }

  String getChar() {
    if (char == empty) {
      return ' ';
    } else {
      return char;
    }
  }

  String getStatus() {
    return status;
  }

  void setChar(String char) {
    this.char = char;
  }

  void setStatus(String status) {
    this.status = status;
  }
}

class Message {
  bool success;
  String message;

  Message({required this.success, required this.message});

  bool isSuccess() {
    return success;
  }

  String getMessage() {
    return message;
  }
}
