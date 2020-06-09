import 'dart:async';
import 'dart:convert';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:swasthyapala_flutter/model/user.dart';
import 'package:swasthyapala_flutter/stmgmt/user.dart';
import 'package:swasthyapala_flutter/uis/login_screen.dart';
import 'package:swasthyapala_flutter/util/validators.dart';

import '../required_icons_.dart';
import '../util/constants.dart';

class SignUpScreen extends StatefulWidget {
  static const routeName = "/Signup";

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController myNameController;
  TextEditingController myPasswordController;

  IconData myIcons;
  String currentUser;
  bool showPassword;
  bool isPressed = false;
  NewUser newUser;
  String errorText = Constants.signing;
  bool connectionStatus = false;
  StreamSubscription subscription;

  @override
  void initState() {
    super.initState();
    showPassword = false;
    //checks network connectivity
    checkConnectivity();
    //polling the network connection in the background
    startConnectionSubscription();
  }

  void startConnectionSubscription() {
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
  Widget build(BuildContext context) {
    if (showPassword == false) {
      myIcons = RequiredIcons.eye_off;
    } else
      myIcons = RequiredIcons.eye;

    return Scaffold(
      body: Container(
        child: ListView(
          children: <Widget>[
            getBanner(context),
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Container(
                child: Consumer<User>(
                  builder: (context, user, child) {
                    return Form(
                        key: _formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            getUserNameFeild(user),
                            getEmailFeild(user),
                            getPhoneFeild(user),
                            getPasswordFeild(user),
                            //signup button
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.9,
                                height: 50,
                                child: RaisedButton(
                                  color: Constants.theme_color,
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          new BorderRadius.circular(24),
                                      side: BorderSide(color: Colors.blue)),
                                  onPressed: () {
                                    handleSignUp(user, context);
                                  },
                                  child: Text(
                                    "sign up",
                                    style: TextStyle(
                                        fontSize: Constants.medium_font_size,
                                        color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                            //already user?widgets
                            bottomWidgetList(context)
                          ],
                        ));
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }





  InkWell getBanner(BuildContext context) {
    return InkWell(
            child: Container(
              decoration: BoxDecoration(
                  color: Constants.theme_color,
                  borderRadius:
                      BorderRadius.only(bottomLeft: Radius.circular(80))),
              height: MediaQuery.of(context).size.height * 0.35,
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
                      "sign up",
                      style: TextStyle(
                          fontSize: Constants.small_font_size,
                          color: Colors.white,
                          fontFamily: "OpenSans"),
                    ),
                  ),
                ],
              ),
            ),
          );
  }

  Padding bottomWidgetList(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Text(
            "Already a user?",
            style: TextStyle(fontSize: Constants.small_font_size),
          ),
          InkWell(
            child: Text(
              " login",
              style: TextStyle(color: Colors.redAccent),
            ),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ChangeNotifierProvider<User>(
                          create: (_) => User(), child: LoginScreen())));
            },
            splashColor: Colors.redAccent,
          )
        ],
      ),
    );
  }

  void handleSignUp(User user, BuildContext context) {
    //check network connectivity once button is clicked
    checkConnectivity();
    //validate the form
    if (_formKey.currentState.validate()) {
      //if the form is validated and network is availbale
      if (connectionStatus == true) {
        //show dialog with the message sigining in
        showStatusDialog(errorText);

        NewUser newUser = NewUser.name(user.getPhone(), user.getEmail(),
            user.getUserName(), user.getPassword());

        String encodedString = jsonEncode(newUser);

        addNewUser(encodedString).then((value) {
          final response = jsonDecode(value.body);

          //response status 1 means response code 200

          if (response['status'] == 1) {
            //popping the context of dialog before going to another page
            Navigator.pop(context);

            //goto another page
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => LoginScreen()));
          } else {
            //if the response code is not 200
            setState(() {
              errorText = Constants.failedSignup;
            });

            //pop the context of the previous dialog

            Navigator.pop(context);
            //show new dialog with new signupfailed error
            showStatusDialog(errorText);
          }
        });
      } else {
        setState(() {
          errorText = Constants.connectionErrorMessage;
        });
      }
    } else {
      //if validation is not passed show this snackbar
      Scaffold.of(_formKey.currentState.context)
          .showSnackBar(SnackBar(content: Text("validation error")));
    }
  }

  Padding getPasswordFeild(User user) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        keyboardType: TextInputType.multiline,
        controller: myNameController,
        obscureText: !showPassword,
        textDirection: TextDirection.ltr,
        decoration: InputDecoration(
          prefixIcon: Icon(RequiredIcons.vpn_key),
          suffixIcon: InkWell(
            child: Icon(myIcons),
            onTap: () {
              setState(() {
                showPassword = !showPassword;
              });
            },
            splashColor: Constants.theme_color,
          ),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10), gapPadding: 4),
          labelText: "password",
          labelStyle: TextStyle(
            fontSize: Constants.medium_font_size,
          ),
          errorMaxLines: 2,
          hintText: "sample pass:abcDEF*@40",
          hintStyle: TextStyle(
              fontSize: Constants.medium_font_size, color: Colors.black12),
        ),
        validator: (value) {
          user.setPassword(value);
          if (Validator.validatePasswored(user.getPassword()) == false) {
            return "enter the valid email";
          } else
            return null;
        },
        //this onChanged method is called whenever something changes in the feild
        //we have made textediting controller optional here
        onChanged: (values) {
          user.setPassword(values);
        },
      ),
    );
  }

  Padding getPhoneFeild(User user) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        keyboardType: TextInputType.multiline,
        controller: myNameController,
        maxLines: null,
        textDirection: TextDirection.ltr,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.phone),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10), gapPadding: 4),
          labelText: "phone",
          labelStyle: TextStyle(
            fontSize: Constants.medium_font_size,
          ),
          errorMaxLines: 2,
          hintText: "9865898432",
          hintStyle: TextStyle(fontSize: 15, color: Colors.black12),
        ),
        validator: (value) {
          user.setPhoneNumber(value);

          if (Validator.validatePhone((user.getPhone() ?? "12")) == false) {
            return "typed number is incorrect";
          } else
            return null;
        },
        //this onChanged method is called whenever something changes in the feild
        //we have made textediting controller optional here
        onChanged: (values) {
          user.setPhoneNumber(values);
        },
      ),
    );
  }

  Padding getEmailFeild(User user) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        keyboardType: TextInputType.multiline,
        controller: myNameController,
        maxLines: null,
        textDirection: TextDirection.ltr,
        decoration: InputDecoration(
          prefixIcon: Icon(RequiredIcons.email),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10), gapPadding: 4),
          labelText: "e-mail",
          labelStyle: TextStyle(
            fontSize: Constants.medium_font_size,
          ),
          errorMaxLines: 2,
          hintText: "johnetr12@gmail.com",
          hintStyle: TextStyle(fontSize: 15, color: Colors.black12),
        ),
        validator: (value) {
          user.setEmail(value);

          if (Validator.validateEmail(user.getEmail()) == false) {
            return "incorrect email format";
          } else
            return null;
        },
        //this onChanged method is called whenever something changes in the feild
        //we have made textediting controller optional here
        onChanged: (values) {
          user.setEmail(values);
        },
      ),
    );
  }

  Padding getUserNameFeild(User user) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        keyboardType: TextInputType.multiline,
        controller: myNameController,
        maxLines: null,
        textDirection: TextDirection.ltr,
        decoration: InputDecoration(
          prefixIcon: Icon(RequiredIcons.user),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10), gapPadding: 4),
          labelText: "username",
          labelStyle: TextStyle(
            fontSize: Constants.medium_font_size,
          ),
          errorMaxLines: 2,
          hintText: "johnvan@512",
          hintStyle: TextStyle(fontSize: 15, color: Colors.black12),
        ),
        validator: (value) {
          user.setUserName(value);

          if (Validator.validateUsername((user.getUserName())) == false) {
            return "enter the valid username";
          } else
            return null;
        },
        //this onChanged method is called whenever something changes in the feild
        //we have made textediting controller optional here
        onChanged: (value) {
          user.setUserName(value);
        },
      ),
    );
  }

  Future<Response> addNewUser(String encodedString) async {
    return await post(
        "http://swasthyapala.com/swasthyapala/user/insert_user.php",
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: encodedString);
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

  @override
  dispose() {
    super.dispose();
    subscription.cancel();
  }

  Widget getLoadingWidget() {
    return (this.errorText == Constants.signing)
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
                                  child: SignUpScreen())));
                    },
                    child: Text("try again"))
                : Container(),
          ],
        ),
      ),
    );
  }
}
