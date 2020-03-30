
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swasthyapala_flutter/stmgmt/user.dart';

class Util {
  Future<String> getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String user = prefs.getString("user") ?? "null";
    return user;
  }
  Future<String> getPassword() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String user = prefs.getString("pass") ?? "null";
    return user;
  }


  void putUser(User args) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("user", args.userName);
    prefs.setString("pass", args.password);
  }
}
