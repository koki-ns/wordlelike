import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'wordle_model.dart';

class InheritedData extends InheritedWidget {
  final HoldDataState data;

  const InheritedData({
    Key? key,
    required this.data,
    required Widget child,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return true;
  }
}

class HoldDataState extends State<HoldData> {
  late FToast fToast;

  bool isEvaluating = false;
  bool isPlaying = true;

  //判定、キー単語選出に使うクラス
  WordleModel model = WordleModel();
  List<List<Character>> charsLists =
      List.generate(6, (index) => List.generate(5, ((index) => Character())));
  int rowNumber = 0; //現在入力する行を指し示す
  int columnNumber = 0; //次に入力するポイントを指し示す

  KeyBoardStatus keyBoardStatus = KeyBoardStatus();

  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast.init(context);
  }

  @override
  Widget build(BuildContext context) {
    final Size displaySize = MediaQuery.of(context).size;
    return InheritedData(data: this, child: widget.child);
  }

  /*
  Widget _buildBox(row, column) {
    return Container(
      color: Colors.blueGrey[300],
      width: 60,
      height: 60,
      child: Text(getChar(row, column)),
    );
  }
  */

  String getChar(int row, int column) {
    String str = charsLists[row][column].getChar();
    if (str == Character.empty) {
      return ' ';
    } else {
      return str;
    }
  }

  int getCharStatus(int row, int column) {
    return charsLists[row][column].getStatus();
  }

  KeyBoardStatus getKeyBoardStatus() {
    return keyBoardStatus;
  }

  bool isFilled() {
    if (columnNumber < 5) {
      return false;
    } else {
      return true;
    }
  }

  bool isValid() {
    return WordleModel.isValid(
        List.generate(5, (index) => charsLists[rowNumber][index].getChar()));
  }

  bool getIsEvaluating() {
    return isEvaluating;
  }

  bool getIsPlaying() {
    return isPlaying;
  }

  void input(char) {
    if (columnNumber < 5 && !isEvaluating && isPlaying) {
      setState(() {
        charsLists[rowNumber][columnNumber].setChar(char);
        ++columnNumber;
      });
    }
  }

  void backSpace() {
    if (columnNumber >= 1 && !isEvaluating && isPlaying) {
      setState(() {
        --columnNumber;
        charsLists[rowNumber][columnNumber].setChar(Character.empty);
      });
    }
  }

  void enter() async {
    List<String> guess;
    List<int> result;

    setState(() {
      isEvaluating = true;
    });
    guess = List.generate(5, (index) => charsLists[rowNumber][index].getChar());
    result = model.judge(guess);
    for (var i = 0; i < 5; i++) {
      setState(() {
        charsLists[rowNumber][i].setStatus(result[i]);
      });
      //asyncとawaitについて調べてタイマーを置け enterを非同期処理にしろ
      await new Future.delayed(new Duration(milliseconds: 300));
    }

    if (WordleModel.isWin(result)) {
      setState(() {
        isPlaying = false;
        //勝ちを伝える処理
        isEvaluating = false;
      });
    } else if (rowNumber == 5) {
      setState(() {
        isPlaying = false;
        //負けを伝える処理
        isEvaluating = false;
      });
    } else {
      setState(() {
        for (var i = 0; i < 5; i++) {
          keyBoardStatus.setStatus(guess[i], result[i]);
        }
        rowNumber++;
        columnNumber = 0;
        isEvaluating = false;
      });
    }
  }

  void reset() {
    setState(() {
      isPlaying = true;
      charsLists = List.generate(
          6, (index) => List.generate(5, ((index) => Character())));
      rowNumber = 0; //現在入力する行を指し示す
      columnNumber = 0; //次に入力するポイントを指し示す
      keyBoardStatus.reset();
      model.reselectKey();
    });
  }

  showCustomToast(String text) {
    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25.0),
      ),
      child: Text(text),
    );

    fToast.showToast(
      child: toast,
      gravity: ToastGravity.TOP,
      toastDuration: Duration(seconds: 1),
    );
  }
}

class HoldData extends StatefulWidget {
  final Widget child;

  const HoldData({Key? key, required this.child}) : super(key: key);

  static HoldDataState of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<InheritedData>()!.data;
  }

  @override
  HoldDataState createState() => new HoldDataState();
}

class Character {
  static const String empty = 'empty';

  String char;
  int status;

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

  int getStatus() {
    return status;
  }

  void setChar(String char) {
    this.char = char;
  }

  void setStatus(int status) {
    this.status = status;
  }
}

class KeyBoardStatus {
  late Map<String, int> keyBoardStatus;

  KeyBoardStatus() {
    reset();
  }

  void setStatus(String char, int status) {
    if (keyBoardStatus[char]! < status) {
      keyBoardStatus[char] = status;
    }
  }

  int? getStatus(String char) {
    return keyBoardStatus[char];
  }

  void reset() {
    keyBoardStatus = {
      'a': WordleModel.notEvaluated,
      'b': WordleModel.notEvaluated,
      'c': WordleModel.notEvaluated,
      'd': WordleModel.notEvaluated,
      'e': WordleModel.notEvaluated,
      'f': WordleModel.notEvaluated,
      'g': WordleModel.notEvaluated,
      'h': WordleModel.notEvaluated,
      'i': WordleModel.notEvaluated,
      'j': WordleModel.notEvaluated,
      'k': WordleModel.notEvaluated,
      'l': WordleModel.notEvaluated,
      'm': WordleModel.notEvaluated,
      'n': WordleModel.notEvaluated,
      'o': WordleModel.notEvaluated,
      'p': WordleModel.notEvaluated,
      'q': WordleModel.notEvaluated,
      'r': WordleModel.notEvaluated,
      's': WordleModel.notEvaluated,
      't': WordleModel.notEvaluated,
      'u': WordleModel.notEvaluated,
      'v': WordleModel.notEvaluated,
      'w': WordleModel.notEvaluated,
      'x': WordleModel.notEvaluated,
      'y': WordleModel.notEvaluated,
      'z': WordleModel.notEvaluated,
    };
  }
}
