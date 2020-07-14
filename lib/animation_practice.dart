import 'dart:math';
import 'package:flutter/material.dart';


//implict animation examples(AnimatedContainer and AnimatedOpcity)

//this animation uses AnimatedContainer implicit widget which changes
//value of radius,margin and color between randomly generated
//numbers on the button press
class AnimatedContainerDemo extends StatefulWidget {
  @override
  _AnimatedContainerDemoState createState() => _AnimatedContainerDemoState();
}


class _AnimatedContainerDemoState extends State<AnimatedContainerDemo> {
  Color _color;
  double _borderRadius;
  double _margin;
  final _duration=Duration(milliseconds: 500);

  @override
  void initState() {
    super.initState();
    _color = randomColor();
    _borderRadius = randomBorderRadius();
    _margin = randomMargin();
  }

  void change() {
    setState(() {
      _color = randomColor();
      _borderRadius = randomBorderRadius();
      _margin = randomMargin();
    });
  }

  @override
  Widget build(BuildContext context) {

    return Column(
        children: <Widget>[
          SizedBox(
            width: 128,
            height: 128,
            child: AnimatedContainer(
              duration:_duration,
              curve: Curves.bounceInOut,
              margin: EdgeInsets.all(_margin),
              decoration: BoxDecoration(
                color: _color,
                borderRadius: BorderRadius.circular(_borderRadius),
              ),
            ),
          ),
          MaterialButton(
            onPressed: () => change(),
            color: Theme.of(context).primaryColor,
            child: Text(
              'change',
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      );

  }
}

class FadeInAnim extends StatefulWidget {
  @override
  _FadeInAnimState createState() => _FadeInAnimState();
}

//on see more button clicked it fades in the detail of the image,
// with AnimatedOpacity implicit widget

class _FadeInAnimState extends State<FadeInAnim> {
  var opacity = 0.0;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            'images/mohan.jpg',
            height: 100,
            width: 100,
          ),
          MaterialButton(
            onPressed: () => setState(() => opacity = 1.0),
            child: Text(
              'see detail',
              style: TextStyle(color: Colors.blueAccent),
            ),
          ),
          AnimatedOpacity(
            opacity: opacity,
            duration: Duration(seconds: 2),
            child: Column(
              children: <Widget>[
                Text('Mohan Kumar Dhakal'),
                Text('isActive : true'),
                Text('college: NCIT')
              ],
            ),
          )
        ],
      ),
    );
  }
}
double randomBorderRadius() {
  return Random().nextDouble() * 64;
}

double randomMargin() {
  return Random().nextDouble() * 64;
}

Color randomColor() {
  return Color(0xFFFFFFFF & Random().nextInt(0xFFFFFFFF));
}

