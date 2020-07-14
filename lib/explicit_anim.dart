//explict animations

import 'package:flutter/material.dart';

//explicit animation that scales the flutter logo
//from nothing to it's full size.
//animation value changes everytime the setstate is called
//inside addlistener methond with the tween

class LogoApp extends StatefulWidget {
  @override
  _LogoAppState createState() => _LogoAppState();
}

class _LogoAppState extends State<LogoApp> with SingleTickerProviderStateMixin {
  Animation<double> _animation;
  AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(duration: Duration(seconds: 2), vsync: this);
    _animation = Tween<double>(begin: 0, end: 300).animate(_animationController)
      ..addListener(() {
        setState(() {});
      });
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      height: _animation.value,
      width: _animation.value,
      child: FlutterLogo(),
    ));
  }
}

//AnimatedWidget helper class to create
//widget that animates without using addListener and setState like in previous
//example
/*
* AnimatedWidget can be used to create a reusable animation . TO separate
* the trasition fromthe widget we user TweenAnimationBuilder
* diff. animated widgets are:
* AnimatedBuilder,AnimatedModalBarrier,DecoratedBoxTransition,FadeTransition DefaultTabController
* */
//AnimatedWidget base class allows to separate out the core widget code from the
//animation code

//AnimatedLogo uses the current value of the animation
//when drawing itself
//LogoApp1 manages the animation controller and the tween
//it passes the animation object to animation logo

//class AnimatedLogo extends AnimatedWidget {
//  AnimatedLogo({Key key, Animation<double> animation})
//      : super(key: key, listenable: animation);
//
//  @override
//  Widget build(BuildContext context) {
//    final animation = listenable as Animation<double>;
//    return Center(
//      child: Container(
//        margin: EdgeInsets.symmetric(vertical: 10),
//        height: animation.value,
//        width: animation.value,
//        child: FlutterLogo(),
//      ),
//    );
//  }
//}
//
////for the animation with animated widget
//class LogoApp1 extends StatefulWidget {
//  @override
//  _LogoApp1State createState() => _LogoApp1State();
//}
//
//class _LogoApp1State extends State<LogoApp1>
//    with SingleTickerProviderStateMixin {
//  Animation<double> _animation;
//  AnimationController _animationController;
//
//  @override
//  void initState() {
//    super.initState();
//    _animationController =
//        AnimationController(duration: Duration(seconds: 2), vsync: this);
//    //to listen to the changes of the notification to the animation
//    //whether it has stopped or reverse statuslistener is used
//    _animation = Tween<double>(begin: 0, end: 300).animate(_animationController)
//      ..addStatusListener((status) {
//        print('$status');
//        if (status == AnimationStatus.completed) {
//          _animationController.reverse();
//        } else if (status == AnimationStatus.dismissed) {
//          _animationController.forward();
//        }
//      });
//    _animationController.forward();
//  }
//
//  @override
//  Widget build(BuildContext context) => AnimatedLogo(
//        animation: _animation,
//      );
//
//  @override
//  void dispose() {
//    _animationController.dispose();
//    super.dispose();
//  }
//}

// example of AnimatedBuilder starts from here

//this creates and controls the animation
class LogoApp2 extends StatefulWidget {
  @override
  _LogoApp2State createState() => _LogoApp2State();
}

class _LogoApp2State extends State<LogoApp2>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation _animation;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 2));
    _animation = Tween<double>(begin: 0, end: 300).animate(_controller);
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return GrowTransition(
      child: LogoWidget(),
      animation: _animation,
    );
  }
}

//this is separate widget that holds the image to animate
class LogoWidget extends StatelessWidget {
  // Leave out the height and width so it fills the animating parent
  Widget build(BuildContext context) => Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        child: FlutterLogo(),
      );
}

//it wraps the AnimationBuilder,AnonymousBuilder
class GrowTransition extends StatelessWidget {
  final Widget child;
  final Animation<double> animation;

  GrowTransition({this.child, this.animation});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        return Container(
          height: animation.value,
          width: animation.value,
          child: child,
        );
      },
      child: child,
    );
  }
}

//simaltaneous animation example
//The Curves class defines an aray of commonly used cureves that
//we can use with a CurvedAnimation
//this exaples shows how to use multiple tweeens on the same
//animation controller with size and opacity tween

class AnimatedLogo extends AnimatedWidget {
   final _opacityTween = Tween<double>(begin: 0.2, end: 1);
   final _sizeTween = Tween<double>(begin: 0, end: 300);


  AnimatedLogo({Key key, Animation<double> animation})
      : super(key: key, listenable: animation);

  @override
  Widget build(BuildContext context) {
    final animation = listenable as Animation<double>;
    return Center(
      child: Opacity(
        opacity: _opacityTween.evaluate(animation),
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 10),
          height: _sizeTween.evaluate(animation),
          width: _sizeTween.evaluate(animation),
          child: FlutterLogo(),
        ),
      ),
    );
  }
}

//for the animation with animated widget
class LogoApp1 extends StatefulWidget {
  @override
  _LogoApp1State createState() => _LogoApp1State();
}

class _LogoApp1State extends State<LogoApp1>
    with SingleTickerProviderStateMixin {
  Animation<double> _animation;
  AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(duration: Duration(seconds: 2), vsync: this);

    _animation = CurvedAnimation(
        parent: _animationController, curve: Curves.easeInOutBack)
      ..addStatusListener((status) {
        print('$status');
//        if (status == AnimationStatus.completed) {
//          _animationController.reverse();
//        } else if (status == AnimationStatus.dismissed) {
//          _animationController.forward();
//        }
      });
    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) => AnimatedLogo(
        animation: _animation,
      );

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
