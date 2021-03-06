
import 'package:flutter/material.dart';

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    createSliderLine(path, size);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }

  createSliderLine(path, size) {
    path.lineTo(0.0, size.height * 0.75);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0.0);
  }
}
