import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swasthyapala_flutter/util/constants.dart';
import 'package:swasthyapala_flutter/uis/home_screen.dart';
import 'package:swasthyapala_flutter/uis/login_screen.dart';
import 'package:swasthyapala_flutter/uis/signup_screen.dart';
import 'package:swasthyapala_flutter/uis/splash_screen.dart';
import 'package:swasthyapala_flutter/stmgmt/user.dart';

void main() {
  runApp(MyApp());
//  final alphanumeric = RegExp(r'^([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,3})$');
//  print(alphanumeric.hasMatch('moahdndkl52@gmail.com'));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers:[
        ChangeNotifierProvider(create: (_) => User())
      ],
      child: MaterialApp(
        initialRoute: SignUpScreen.routeName,
        routes: {
          SplashScreen.routeName: (context) => SplashScreen(),
          HomeScreen.routeName: (context) => HomeScreen(),
          LoginScreen.routeName: (context) => LoginScreen(),
          SignUpScreen.routeName: (context) => SignUpScreen(),
        },
      ),
    );
  }
}
