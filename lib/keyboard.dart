import 'package:flutter/material.dart';
import 'inputContainer.dart';

class KeyBoardWidget extends StatelessWidget {
  final List<String> firstRow = [
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
  final List<String> secondRow = ['a', 's', 'd', 'f', 'g', 'h', 'j', 'k', 'l'];
  final List<String> thirdRow = ['z', 'x', 'c', 'v', 'b', 'n', 'm'];

  final double keyHeight = 60;

  @override
  Widget build(BuildContext context) {
    final HoldDataState data = HoldData.of(context);
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(width: 3),
            for (var char in firstRow) ...{
              _buildInputKey(context, char),
              SizedBox(width: 3)
            }
          ],
        ),
        SizedBox(height: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(width: 10),
            for (var char in secondRow) ...{
              _buildInputKey(context, char),
              if (char != 'l') SizedBox(width: 3)
            },
            SizedBox(width: 10),
          ],
        ),
        SizedBox(height: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildEnterKey(context),
            SizedBox(width: 3),
            for (var char in thirdRow) ...{
              _buildInputKey(context, char),
              SizedBox(width: 3)
            },
            _buildBackSpaceKey(context),
          ],
        ),
      ],
    );
  }

  Widget _buildInputKey(BuildContext context, String char) {
    final HoldDataState data = HoldData.of(context);
    return Container(
      child: SizedBox(
        width: 34,
        height: keyHeight,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Colors.grey[600],
            padding: EdgeInsets.zero,
          ),
          onPressed: () => data.input(char),
          child: Text(char),
        ),
      ),
    );
  }

  Widget _buildEnterKey(BuildContext context) {
    final HoldDataState data = HoldData.of(context);
    return Container(
      child: SizedBox(
        width: 55,
        height: keyHeight,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Colors.grey[600],
            padding: EdgeInsets.zero,
          ),
          onPressed: () => data.enter(),
          child: Text('Enter'),
        ),
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
}
