import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wordlelike/keyboard.dart';
import 'inherited_data.dart';
import 'wordle_model.dart';

class InputBoxes extends StatelessWidget {
  static const double maxheight = 381;
  static const double maxwidth = 315;

  @override
  Widget build(BuildContext context) {
    final Size displaySize = MediaQuery.of(context).size;
    final double surplusHeight = (displaySize.height -
            KeyBoardWidget.minHeight -
            AppBar().preferredSize.height) *
        0.9;
    final double height = surplusHeight > maxheight ? maxheight : surplusHeight;
    final double boxHeight = ((height - 3 * 7) ~/ 6).toDouble();
    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: maxheight, maxWidth: maxwidth),
      child: Container(
          height: height,
          width: displaySize.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 3),
              for (var i = 0; i < 6; i++) ...{
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    for (var j = 0; j < 5; j++) ...{
                      _buildBox(context, i, j, boxHeight),
                      SizedBox(width: 3)
                    }
                  ],
                ),
                SizedBox(height: 3)
              }
            ],
          )),
    );
  }

  Widget _buildBox(
      BuildContext context, int row, int column, double boxHeight) {
    HoldDataState data = HoldData.of(context);
    return Container(
      width: boxHeight,
      height: boxHeight,
      child: Text(
        data.getChar(row, column).toUpperCase(),
        style: GoogleFonts.ptSans(
          fontWeight: FontWeight.bold,
          fontSize: 30,
          color: Colors.white,
        ),
      ),
      decoration: BoxDecoration(
        color: colorOfStatus[data.getCharStatus(row, column)],
        border: data.getCharStatus(row, column) == WordleModel.notEvaluated
            ? Border.all(width: 2, color: (Colors.grey[800])!)
            : null,
        borderRadius: BorderRadius.circular(12.0),
      ),
      alignment: Alignment.center,
    );
  }

  static Map<int, Color?> colorOfStatus = {
    WordleModel.notEvaluated: Colors.transparent,
    WordleModel.blow: Colors.orange[400],
    WordleModel.hit: Colors.green,
    WordleModel.miss: Colors.grey[850]
  };
}
