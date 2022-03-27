import 'package:flutter/material.dart';
import 'inputContainer.dart';

class InputBoxes extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Size displaySize = MediaQuery.of(context).size;
    return Container(
        width: displaySize.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            for (var i = 0; i < 6; i++) ...{
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  for (var j = 0; j < 5; j++) ...{
                    _buildBox(context, i, j),
                    SizedBox(width: 3)
                  }
                ],
              ),
              SizedBox(height: 3)
            }
          ],
        ));
  }

  Widget _buildBox(BuildContext context, int row, int column) {
    HoldDataState data = HoldData.of(context);
    return Container(
      color: Colors.blueGrey[300],
      width: 60,
      height: 60,
      child: Text(data.getChar(row, column)),
    );
  }
}
