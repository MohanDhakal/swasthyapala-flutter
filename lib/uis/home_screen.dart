import 'package:flutter/material.dart';
import 'package:swasthyapala_flutter/stmgmt/signup_state.dart';
import 'package:swasthyapala_flutter/uis/signup_screen.dart';
import 'package:swasthyapala_flutter/stmgmt/user.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = "/Home";

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Util savedDetail = Util();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    User args = ModalRoute.of(context).settings.arguments;
    if (args != null) {
      savedDetail.putUser(args);
      print(args.userName);
    } else
      print("from other activity");

    return Scaffold(
      appBar: AppBar(
        title: Text("Home Screen"),
      ),
      body: Center(
        child: Container(
          child: Text("Welcome to SwasthyaPala!!"),
        ),
      ),
    );
  }
}
