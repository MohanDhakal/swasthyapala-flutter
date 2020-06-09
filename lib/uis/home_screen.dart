import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = "/Home";

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
//  Util savedDetail = Util();

  @override
  Widget build(BuildContext context) {
//    User args = ModalRoute.of(context).settings.arguments;
//    if (args != null) {
//      savedDetail.putUser(args);
//      print(args.getUserName());
//    } else
//      print("from other activity");

    return Scaffold(
        appBar: AppBar(
          title: Text("Home Screen"),
        ),
        body: Container());
  }
}
