import 'package:flutter/material.dart';
import 'package:swasthyapala_flutter/util/constants.dart';
import 'package:swasthyapala_flutter/util/utilmethods.dart';

// ignore: must_be_immutable
class Tag extends StatelessWidget {
  final tag;
  final index;
  Color color;
  Function(int selectedIndex) onPressed;

  Tag({this.tag, this.onPressed, this.index, this.color});

  @override
  Widget build(BuildContext context) {
    return UnconstrainedBox(
      child: GestureDetector(
        onTap: () => onPressed(this.index),
        child: Container(
            height: 30,
            margin: EdgeInsets.all(5),
            decoration: BoxDecoration(
                border: Border.all(
                  color: this.color ?? Colors.grey,
                ),
                boxShadow: (this.color==Colors.blue)?Util().showCustomShadow():null,
                borderRadius: BorderRadius.all(
                  Radius.circular(
                    12,
                  ),
                )),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text(
                  this.tag,
                  style: TextStyle(fontSize: Constants.SMALL_FONT_SIZE),
                ),
              ),
            )),
      ),
    );
  }
}
