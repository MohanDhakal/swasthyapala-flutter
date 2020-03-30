import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swasthyapala_flutter/util/constants.dart';
import 'package:swasthyapala_flutter/required_icons_.dart';
import 'package:swasthyapala_flutter/stmgmt/signup_state.dart';
import 'package:swasthyapala_flutter/uis/home_screen.dart';
import 'package:swasthyapala_flutter/uis/signup_screen.dart';
import 'package:swasthyapala_flutter/stmgmt/user.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/Login';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  //key to recognize our form
  final _formKey = GlobalKey<FormState>();

  String savedUser = "";
  String savedPass = "";

  TextEditingController myname_Controller;
  TextEditingController mypassword_Controller;

  Util savedData = new Util();

  @override
  Widget build(BuildContext context) {

    savedData.getUser().then((value) {
      setState(() {
        savedUser = value;
      });
    });

    savedData.getPassword().then((value) {
      setState(() {});
      this.savedPass = value;
    });

    return Scaffold(
      body: Container(
        child: ListView(
          children: <Widget>[
            InkWell(
              child: Container(
                decoration: BoxDecoration(
                    color: Constants.theme_color,
                    borderRadius:
                        BorderRadius.only(bottomLeft: Radius.circular(80))),
                height: MediaQuery.of(context).size.height * 0.4,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 50.0),
                      child: Image.asset(
                        "images/logo.png",
                        height: 80,
                        width: 80,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 250.0, bottom: 20),
                      child: Text(
                        "Login",
                        style: TextStyle(
                            fontSize: Constants.small_font_size,
                            color: Colors.white,
                            fontFamily: "OpenSans"),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Consumer<User>(
                builder: (context, user, child) {
                  return Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              keyboardType: TextInputType.multiline,
                              controller: myname_Controller,
                              maxLines: null,
                              textDirection: TextDirection.ltr,
                              decoration: InputDecoration(
                                prefixIcon: Icon(RequiredIcons.user),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    gapPadding: 4),
                                labelText: "username",
                                labelStyle: TextStyle(
                                  fontSize: Constants.medium_font_size,
                                ),
                                errorMaxLines: 2,
                                hintText: "Please enter your user name",
                                hintStyle: TextStyle(
                                    fontSize: 15, color: Colors.black12),
                              ),
                              validator: (value) {
                                user.userName = value;
                                if (user.userName != savedUser) {
                                  return "incorrect username";
                                } else
                                  return null;
                              },
                              //this onChanged method is called whenever something changes in the feild
                              //we have made textediting controller optional here
                              onChanged: (values) {
                                user.userName = values;
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              keyboardType: TextInputType.multiline,
                              controller: myname_Controller,
                              maxLines: null,
                              textDirection: TextDirection.ltr,
                              decoration: InputDecoration(
                                prefixIcon: Icon(RequiredIcons.vpn_key),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    gapPadding: 4),
                                labelText: "password",
                                labelStyle: TextStyle(
                                  fontSize: Constants.medium_font_size,
                                ),
                                errorMaxLines: 2,
                                hintText: "Enter your password",
                                hintStyle: TextStyle(
                                    fontSize: Constants.medium_font_size,
                                    color: Colors.black12),
                              ),
                              validator: (value) {
                                user.password = value;
                                if (user.password != savedPass) {
                                  return "password doesn't match";
                                } else
                                  return null;
                              },
                              //this onChanged method is called whenever something changes in the feild
                              //we have made textediting controller optional here
                              onChanged: (values) {
                                user.password = values;
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 20.0),
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.9,
                              height: 50,
                              child: RaisedButton(
                                color: Constants.theme_color,
                                shape: RoundedRectangleBorder(
                                    borderRadius: new BorderRadius.circular(24),
                                    side: BorderSide(color: Colors.blue)),
                                onPressed: () {
                                  if (_formKey.currentState.validate()) {
                                    print(savedPass);
                                    if (user.userName == savedUser &&
                                        user.password == savedPass) {
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  HomeScreen()));
                                    } else {
                                      Scaffold.of(context)
                                          .showSnackBar(SnackBar(
                                        content: Text(
                                            "username or password not valid"),
                                      ));
                                    }
                                  } else {
                                    Scaffold.of(context).showSnackBar(SnackBar(
                                      content: Text("Validation Error"),
                                    ));
                                  }
                                },
                                child: Text(
                                  "Login",
                                  style: TextStyle(
                                      fontSize: Constants.medium_font_size,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(18.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                Text(
                                  "Not registered already?",
                                  style: TextStyle(
                                      fontSize: Constants.small_font_size),
                                ),
                                InkWell(
                                  child: Text(
                                    "register",
                                    style: TextStyle(color: Colors.redAccent),
                                  ),
                                  onTap: () {
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) {
                                      return SignUpScreen();
                                    }));
                                  },
                                  splashColor: Colors.redAccent,
                                )
                              ],
                            ),
                          )
                        ],
                      ));
                },
                child: Container(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
