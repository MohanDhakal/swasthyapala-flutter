import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swasthyapala_flutter/stmgmt/user.dart';

class Util {
  Future<String> getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String user = prefs.getString("user") ?? null;
    return user;
  }

  Future<String> getPassword() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String user = prefs.getString("pass") ?? null;
    return user;
  }

  void putUser(User args) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("user", args.getUserName());
    prefs.setString("pass", args.getPassword());
  }

  List<BoxShadow> showShadow() {
    return [
      BoxShadow(
        blurRadius: 15,
        offset: -Offset(5, 5),
        color: Colors.white,
      ),
      BoxShadow(
        blurRadius: 15,
        offset: Offset(4.5, 4.5),
        color: kDarkShadow,
      )
    ];
  }

  List<BoxShadow> showInnerShadow() {
    return [
      BoxShadow(
        blurRadius: 15,
        offset: Offset(5, 5),
        color: Colors.white,
      ),
      BoxShadow(
        blurRadius: 15,
        offset: -Offset(4.5, 4.5),
        color: kDarkShadow,
      ),
    ];
  }

  final kOrange = Color.fromRGBO(238, 134, 48, 1); // rgb(238, 134, 48)
  final kDarkShadow = Color.fromRGBO(216, 213, 208, 1); // rgb(216, 213, 208)
}
