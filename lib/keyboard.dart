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

  @override
  Widget build(BuildContext context) {
    final HoldDataState data = HoldData.of(context);
    return Row(
      children: [
        SizedBox(width: 3),
        for (var char in firstRow) ...{
          _buildInputKey(context, char),
          SizedBox(width: 3)
        }
      ],
    );
  }

  Widget _buildInputKey(BuildContext context, String char) {
    final HoldDataState data = HoldData.of(context);
    return Container(
      child: SizedBox(
        width: 34,
        height: 60,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.zero,
          ),
          onPressed: () => data.input(char),
          child: Text(char),
        ),
      ),
    );
  }
}
