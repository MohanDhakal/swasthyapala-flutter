import 'dart:async';
import 'dart:convert';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:swasthyapala_flutter/required_icons_.dart';
import 'package:swasthyapala_flutter/stmgmt/user.dart';
import 'package:swasthyapala_flutter/uis/home_screen.dart';
import 'package:swasthyapala_flutter/uis/signup_screen.dart';
import 'package:swasthyapala_flutter/util/constants.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/Login';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  //key to recognize our form
  final _formKey = GlobalKey<FormState>();

  TextEditingController myNameController;
  TextEditingController myPasswordController;
  String errorText = Constants.logging;

  bool connectionStatus = false;
  StreamSubscription subscription;

  @override
  void initState() {
    super.initState();
    //checks network connectivity
    checkConnectivity();
    //polling the network connection in the background
    subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      if (result == ConnectivityResult.mobile ||
          result == ConnectivityResult.wifi) {
        setState(() {
          connectionStatus = true;
        });
      }
    });
  }

  @override
  dispose() {
    super.dispose();
    subscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
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
                              controller: myNameController,
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
                                hintText: " enter your user name",
                                hintStyle: TextStyle(
                                    fontSize: 15, color: Colors.black12),
                              ),
                              validator: (value) {
                                user.setUserName(value);
                                if (user.getUserName().length < 6) {
                                  return "invalid format";
                                } else
                                  return null;
                              },
                              //this onChanged method is called whenever something changes in the feild
                              //we have made textediting controller optional here
                              onChanged: (values) {
                                user.setUserName(values);
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              keyboardType: TextInputType.multiline,
                              controller: myNameController,
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
                                user.setPassword(value);
                                if (user.getPassword().length < 6) {
                                  return "invalid format";
                                } else
                                  return null;
                              },
                              //this onChanged method is called whenever something changes in the feild
                              //we have made textediting controller optional here
                              onChanged: (values) {
                                user.setPassword(values);
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
                                  checkConnectivity();
                                  if (_formKey.currentState.validate()) {
                                    //if internet is connected
                                    if (connectionStatus == true) {
                                      showStatusDialog(Constants.logging);
                                      handleLogin(user);
                                    } else {
                                      showStatusDialog(
                                          Constants.connectionErrorMessage);
                                    }
                                  }
                                  //if form validation is not correct
                                  else {
                                    Scaffold.of(_formKey.currentContext)
                                        .showSnackBar(SnackBar(
                                      content: Text("form validation error"),
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

  checkConnectivity() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      setState(() {
        connectionStatus = true;
      });
    } else if (connectivityResult == ConnectivityResult.wifi) {
      setState(() {
        connectionStatus = true;
      });
    } else {
      connectionStatus = false;
    }
  }

  Widget getLoadingWidget() {
    return (this.errorText == Constants.logging)
        ? SpinKitFadingCube(
            color: Colors.blue,
            size: 50,
          )
        : SizedBox(
            height: 10,
          );
  }

  void showStatusDialog(placeHolderText) {
    showDialog(
      context: context,
      barrierDismissible: false,
      child: ConstrainedBox(
        constraints: BoxConstraints(maxHeight: 100),
        child: new AlertDialog(
          title: Text(placeHolderText),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              getLoadingWidget(),
            ],
          ),
          actions: [
            (placeHolderText == Constants.failedSignup ||
                    placeHolderText == Constants.connectionErrorMessage)
                ? FlatButton(
                    onPressed: () {
                      //goes to login page again
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ChangeNotifierProvider(
                                  create: (_) => User(),
                                  child: LoginScreen())));
                    },
                    child: Text("try again"))
                : Container(),
          ],
        ),
      ),
    );
  }

  void handleLogin(user) {
    //client validation of the form
    //prepare json to send
    final body = {
      "userName": user.getUserName(),
      "password": user.getPassword()
    };

    handleValidationRequest(jsonEncode(body)).then((value) {
      print(value.statusCode);
      final response = jsonDecode(value.body);
      if (response['validated'] == true) {
        //takes out from the Dialog
        Navigator.pop(context);
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomeScreen()));
      } else {
        Navigator.pop(context);
        Scaffold.of(_formKey.currentState.context).showSnackBar(SnackBar(
          content: Text("username or password not valid"),
        ));
      }
    });
  }

  Future<Response> handleValidationRequest(String encodedString) async {
    return await post(
        "http://swasthyapala.com/swasthyapala/user/validate_user.php",
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: encodedString);
  }
}
