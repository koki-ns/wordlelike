import 'package:flutter/material.dart';
import 'inherited_data.dart';
import 'input_boxes.dart';
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
          child: Container(
            color: KeyBoardWidget.bgColor,
            child: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
              Expanded(
                child: Container(
                  alignment: Alignment.center,
                  child: InputBoxes(),
                ),
              ),
              KeyBoardWidget()
            ]),
          ),
        )),
      ),
    );
  }
}
