import 'package:flutter/material.dart';
import 'package:swasthyapala_flutter/uis/homescreen.dart';
import 'package:swasthyapala_flutter/uis/login_screen.dart';
import 'package:swasthyapala_flutter/uis/signup_screen.dart';
import 'package:swasthyapala_flutter/uis/splash_screen.dart';

void main() {
  runApp(MyApp());
//  final alphanumeric = RegExp(r'^([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,3})$');
//  print(alphanumeric.hasMatch('moahdndkl52@gmail.com'));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: SignUpScreen.routeName,
      routes: {
        SplashScreen.routeName: (context) => SplashScreen(),
        HomeScreen.routeName: (context) => HomeScreen(),
        LoginScreen.routeName: (context) => LoginScreen(),
        SignUpScreen.routeName: (context) => SignUpScreen(),
      },
    );
  }
}
