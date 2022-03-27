import 'package:flutter/material.dart';
import 'inputContainer.dart';
import 'inputBoxes.dart';
import 'keyboard.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  /*2*/
  @override
  Widget build(BuildContext context) {
    /*3*/
    return MaterialApp(
      /*4*/
      title: 'Wordle(imitation)',
      home: Scaffold(
        appBar: AppBar(
          title: Text('ImitateWordle'),
        ),
        body: Center(
            child: HoldData(
          child: Column(children: [InputBoxes(), KeyBoardWidget()]),
        )),
      ),
    );
  }
}
