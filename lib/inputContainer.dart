import 'package:flutter/material.dart';
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
  List<List<Character>> charsLists =
      List.generate(6, (index) => List.generate(5, ((index) => Character())));
  //現在入力する行を指し示す
  int rowNumber = 0;
  //次に入力するポイントを指し示す
  int columnNumber = 0;

  WordleModel model = WordleModel();

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

  void input(char) {
    if (columnNumber < 5) {
      setState(() {
        charsLists[rowNumber][columnNumber].setChar(char);
        ++columnNumber;
      });
    }
  }

  void backSpace() {
    if (columnNumber >= 1) {
      setState(() {
        --columnNumber;
        charsLists[rowNumber][columnNumber].setChar(Character.empty);
      });
    }
  }

  void enter() {
    List<String> guess;
    List<String> result;

    if (columnNumber < 5) {
      //入力終わってないエラー処理
      return;
    } else {
      guess =
          List.generate(5, (index) => charsLists[rowNumber][index].getChar());
      if (!WordleModel.isValid(guess)) {
        //not in Word List
        return;
      }
      result = model.judge(guess);
    }
  }

  void reset() {
    for (var list in charsLists) {
      for (var i = 0; i < 5; i++) {
        list.add(Character());
      }
    }
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
