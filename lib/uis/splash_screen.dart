import 'package:flutter/material.dart';
import 'dart:async';
import 'package:shimmer/shimmer.dart';
import 'package:swasthyapala_flutter/util/constants.dart';
import 'package:swasthyapala_flutter/util/utilmethods.dart';
import 'home_screen.dart';
import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  static const String routeName = "/splash";

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    _mockCheckForSession().then((status) {
      if (status) {
        _navigateToHome();
      } else {
        _navigateToLogin();
      }
    });
  }

  Future<bool> _mockCheckForSession() async {
    String user;
    Util().getUser().then((value) {
      user = value;
    });

    await Future.delayed(Duration(milliseconds: 3000), () {

    });

    if (user != null) {
      print(user);
      return true;
    } else
      return false;
  }

  void _navigateToHome() {
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (BuildContext context) => HomeScreen()));
  }

  void _navigateToLogin() {
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (BuildContext context) => LoginScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Opacity(opacity: 0.5, child: Image.asset("images/bg.png")),
              Shimmer.fromColors(
                period: Duration(milliseconds: 1000),
                baseColor: Constants.them_color_1,
                highlightColor: Constants.theme_color,
                child: Container(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    "swasthyapala",
                    style: TextStyle(
                        fontSize: 30.0,
                        fontFamily: 'Pacifico',
                        shadows: <Shadow>[
                          Shadow(
                              blurRadius: 18.0,
                              color: Colors.black87,
                              offset: Offset.fromDirection(120, 12))
                        ]),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
