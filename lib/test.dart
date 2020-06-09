import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:swasthyapala_flutter/model/user.dart';

class Test extends StatefulWidget {
  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {
  List<NewUser> userList = [];
  Map<String, dynamic> jsonResponse;

  @override
  void initState() {
    super.initState();
    fetchUserList("https://swasthyapala.com/swasthyapala/user/get_users.php")
        .then((value) {
      setState(() {
        jsonResponse = json.decode(value.body);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: FlatButton(
            child: Text("Get Data"),
            onPressed: () => printResult(),
          ),
        ),
      ),
    );
  }

  Future<Response> fetchUserList(String uri) {
    return get(uri);
  }

  printResult() {
    NewUser user = NewUser();
    user.userName = "mohan";
    user.password = "pass";
    user.email = "email";
    user.phone = "phone";

    /* if (jsonResponse != null) {
      for (Map i in jsonResponse['users']) {
        userList.add(NewUser.fromJson(i));
      }
      print(userList[0].userName);
    } else {
      print("null userList");
    }*/
  }
}
