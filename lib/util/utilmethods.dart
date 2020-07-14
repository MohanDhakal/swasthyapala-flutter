import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swasthyapala_flutter/model/messages.dart';
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

  void removeUser(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
  }
//
//  void putUser(User args) async {
//    SharedPreferences prefs = await SharedPreferences.getInstance();
//    prefs.setString("user", args.getUserName());
//    prefs.setString("pass", args.getPassword());
//  }

  Future<MessageList> fetchJsonData() async {
    String jsonString = await _loadJsonFromAsset();
    final jsonResponse = json.decode(jsonString);
    return MessageList.fromJson(jsonResponse);
  }

  Future<String> _loadJsonFromAsset() async {
    return await rootBundle.loadString('json/directs.json');
  }

  List<BoxShadow>showCustomShadow(){
    return[
      BoxShadow(
        spreadRadius: 1,
        blurRadius: 0,
        color: Colors.blue.withOpacity(0.5),
      ),

    ];
  }


  //rounds the double value to the given decimal place and  return double itself

  static double roundThisNum(double num, int roundTo) {
    return double.parse(num.toStringAsFixed(3));

  }

  //get storage permission on android
  static Future<bool> storagePermissionAvailable(context) async {
    var storagePermissionStatus = await Permission.storage.status;
    if (storagePermissionStatus.isGranted) {
      print('Permission: granted already');
      return true;
    } else if (storagePermissionStatus.isUndetermined) {
      storagePermissionStatus = await Permission.storage.request();
      if (storagePermissionStatus.isGranted) {
        print('Permission: granted');
        return true;
      }
    } else if (storagePermissionStatus.isDenied) {
      print('Permission: denied');

      return false;
    } else if (storagePermissionStatus.isRestricted) {
      print('Permission: restricted');
      return false;
    }
    return false;
  }

}
