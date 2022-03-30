import 'package:flutter/material.dart';
import 'inherited_data.dart';
import 'wordle_model.dart';

class KeyBoardWidget extends StatelessWidget {
  static const List<String> firstRow = [
    'q',
    'w',
    'e',
    'r',
    't',
    'y',
    'u',
    'i',
    'o',
    'p'
  ];
  static const List<String> secondRow = [
    'a',
    's',
    'd',
    'f',
    'g',
    'h',
    'j',
    'k',
    'l'
  ];
  static const List<String> thirdRow = ['z', 'x', 'c', 'v', 'b', 'n', 'm'];

  static const double maxWidth = 500;
  static const double minHeight = 240;
  static const double keyHeight = 57;

  static const Color bgColor = Colors.black;

  @override
  Widget build(BuildContext context) {
    final HoldDataState data = HoldData.of(context);
    final Size size = MediaQuery.of(context).size;
    final double keyWidth = size.width < maxWidth
        ? (size.width ~/ (firstRow.length + 1)).toDouble()
        : (maxWidth ~/ (firstRow.length + 1)).toDouble();
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: maxWidth, minHeight: minHeight),
      child: Container(
        alignment: Alignment.bottomCenter,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (var char in firstRow) ...{
                  _buildInputKey(context, char, keyWidth),
                }
              ],
            ),
            SizedBox(height: 2),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (var char in secondRow) ...{
                  _buildInputKey(context, char, keyWidth),
                },
              ],
            ),
            SizedBox(height: 2),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (var char in thirdRow) ...{
                  _buildInputKey(context, char, keyWidth),
                },
                _buildBackSpaceKey(context),
              ],
            ),
            SizedBox(height: 4),
            data.getIsPlaying()
                ? _buildEnterKey(context, keyWidth)
                : _buildNextKey(context, keyWidth),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  Widget _buildInputKey(BuildContext context, String char, double width) {
    final HoldDataState data = HoldData.of(context);
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: bgColor),
      ),
      child: SizedBox(
        width: width,
        height: keyHeight,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: colorOfStatus[data.getKeyBoardStatus().getStatus(char)],
            padding: EdgeInsets.zero,
          ),
          onPressed: () => data.input(char),
          child: Text(char),
        ),
      ),
    );
  }

  Widget _buildEnterKey(BuildContext context, double keyWidth) {
    final HoldDataState data = HoldData.of(context);

    return Container(
      child: SizedBox(
        width: keyWidth * 7,
        height: keyHeight * 0.8,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: data.isValid() ? Colors.green : Colors.red,
            onSurface: !data.isFilled()
                ? Colors.green
                : data.isValid()
                    ? Colors.green
                    : Colors.red,
            padding: EdgeInsets.zero,
          ),
          onPressed: data.isValid() && !data.getIsEvaluating()
              ? () => data.enter()
              : null,
          child: !data.isFilled()
              ? Text('ENTER')
              : data.isValid()
                  ? Text('ENTER')
                  : Text('Not in word list'),
        ),
      ),
    );

    /*
    return !data.isFilled()
        ? Container(
            child: SizedBox(
              width: 150,
              height: keyHeight,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.green,
                  padding: EdgeInsets.zero,
                ),
                onPressed: null,
                child: Text('ENTER'),
              ),
            ),
          )
        : data.isValid()
            ? Container(
                child: SizedBox(
                  width: 150,
                  height: keyHeight,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.green,
                      padding: EdgeInsets.zero,
                    ),
                    onPressed: () => data.enter(),
                    child: Text('ENTER'),
                  ),
                ),
              )
            : Container(
                child: SizedBox(
                  width: 150,
                  height: keyHeight,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.red,
                      padding: EdgeInsets.zero,
                    ),
                    onPressed: () => data.clearLine(),
                    child: Text('Not in word list'),
                  ),
                ),
              );
              */
  }

  Widget _buildNextKey(BuildContext context, double keyWidth) {
    final HoldDataState data = HoldData.of(context);

    return Container(
      child: SizedBox(
        width: keyWidth * 7,
        height: keyHeight * 0.8,
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Colors.blue,
              padding: EdgeInsets.zero,
            ),
            onPressed: () => data.reset(),
            child: Text('Next Game')),
      ),
    );
  }

  Widget _buildBackSpaceKey(BuildContext context) {
    final HoldDataState data = HoldData.of(context);
    return Container(
      child: SizedBox(
        width: 53,
        height: keyHeight,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Colors.grey[600],
            padding: EdgeInsets.zero,
          ),
          onPressed: () => data.backSpace(),
          child: Text('Back'),
        ),
      ),
    );
  }

  static Map<int, Color?> colorOfStatus = {
    WordleModel.notEvaluated: Colors.grey[500],
    WordleModel.blow: Colors.orange[400],
    WordleModel.hit: Colors.green,
    WordleModel.miss: Colors.grey[850]
  };
}
