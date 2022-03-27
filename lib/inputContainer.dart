import 'package:flutter/material.dart';

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
  final empty = 'empty';
  List<List<String>> charsLists =
      List.generate(6, (index) => List.generate(5, ((index) => 'empty')));
  //現在入力する行を指し示す
  int rowNumber = 0;
  //次に入力するポイントを指し示す
  int columnNumber = 0;

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
    String str = charsLists[row][column];
    if (str == empty) {
      return ' ';
    } else {
      return str;
    }
  }

  void input(char) {
    setState(() {
      if (columnNumber < 5) {
        charsLists[rowNumber][columnNumber] = char;
        ++columnNumber;
      }
    });
  }

  void backSpace() {
    if (columnNumber >= 1) {
      --columnNumber;
      charsLists[rowNumber][columnNumber] = empty;
    }
  }

  void reset() {
    for (var list in charsLists) {
      for (var i = 0; i < 5; i++) {
        list.add(empty);
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
