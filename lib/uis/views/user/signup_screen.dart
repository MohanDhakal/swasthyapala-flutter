import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:swasthyapala_flutter/enum/view_state.dart';
import 'package:swasthyapala_flutter/model/user/user.dart';
import 'package:swasthyapala_flutter/stmgmt/user.dart';
import 'package:swasthyapala_flutter/uis/home_screen.dart';
import 'package:swasthyapala_flutter/uis/views/user/login_screen.dart';
import 'package:swasthyapala_flutter/util/services/connection.dart';
import 'package:swasthyapala_flutter/util/validators.dart';

import '../../../required_icons_.dart';
import '../../../util/constants.dart';

class SignUpScreen extends StatefulWidget {
  static const routeName = "/Signup";

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController myNameController;
  TextEditingController myPasswordController;
  TextEditingController myEmailController;
  TextEditingController myPhoneController;

  IconData myIcons;
  String currentUser;
  bool showPassword;
  bool isPressed = false;
  String errorText = Constants.SIGNING;
  var connectedToInternet;

  @override
  void initState() {
    super.initState();
    myNameController = TextEditingController();
    myPasswordController = TextEditingController();
    myEmailController = TextEditingController();
    myPhoneController = TextEditingController();
    showPassword = false;
    Connection.isConnected().then((value) {
      connectedToInternet = value;
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
                  child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          getUserNameFeild(),
                          getEmailFeild(),
                          getPhoneFeild(),
                          getPasswordFeild(),
                          //signup button
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.9,
                              height: 50,
                              child: RaisedButton(
                                color: Constants.THEME_COLOR,
                                shape: RoundedRectangleBorder(
                                    borderRadius: new BorderRadius.circular(24),
                                    side: BorderSide(color: Colors.blue)),
                                onPressed: () {
                                  handleSignUp(context);
                                },
                                child: Text(
                                  "sign up",
                                  style: TextStyle(
                                      fontSize: Constants.MEDIUM_FONT_SIZE,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                          //already user?widgets
                          bottomWidgetList(context)
                        ],
                      ))),
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
            color: Constants.THEME_COLOR,
            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(80))),
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
                    fontSize: Constants.SMALL_FONT_SIZE,
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
            style: TextStyle(fontSize: Constants.SMALL_FONT_SIZE),
          ),
          InkWell(
            child: Text(
              " login",
              style: TextStyle(color: Colors.redAccent),
            ),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => LoginScreen()));
            },
            splashColor: Colors.redAccent,
          )
        ],
      ),
    );
  }

  void handleSignUp(BuildContext context) {
    final userBloc = Provider.of<UserBloc>(context);
    if (connectedToInternet) {
      if (_formKey.currentState.validate()) {
        User newUser = User.name(myPhoneController.text, myEmailController.text,
            myNameController.text, myPasswordController.text);
        userBloc.addNewUser(newUser);
        if (userBloc.state == ViewState.idle) {
          Navigator.pop(context);
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => HomeScreen()));
        } else {
          showStatusDialog(Constants.SIGNING);
        }
      } else {
        //if validation is not passed show this snackbar
        Scaffold.of(_formKey.currentState.context)
            .showSnackBar(SnackBar(content: Text("validation error")));
      }
    } else {
      Scaffold.of(_formKey.currentState.context)
          .showSnackBar(SnackBar(content: Text("internet connection error")));
    }
  }

  Padding getPasswordFeild() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        keyboardType: TextInputType.multiline,
        controller: myPasswordController,
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
            splashColor: Constants.THEME_COLOR,
          ),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10), gapPadding: 4),
          labelText: "password",
          labelStyle: TextStyle(
            fontSize: Constants.MEDIUM_FONT_SIZE,
          ),
          errorMaxLines: 2,
          hintText: "sample pass:abcDEF*@40",
          hintStyle: TextStyle(
              fontSize: Constants.MEDIUM_FONT_SIZE, color: Colors.black12),
        ),
        validator: (value) {
          if (Validator.validatePasswored(myPasswordController.text) == false) {
            return "enter the valid email";
          } else
            return null;
        },
      ),
    );
  }

  Padding getPhoneFeild() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        keyboardType: TextInputType.multiline,
        controller: myPhoneController,
        maxLines: null,
        textDirection: TextDirection.ltr,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.phone),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10), gapPadding: 4),
          labelText: "phone",
          labelStyle: TextStyle(
            fontSize: Constants.MEDIUM_FONT_SIZE,
          ),
          errorMaxLines: 2,
          hintText: "9865898432",
          hintStyle: TextStyle(fontSize: 15, color: Colors.black12),
        ),
        validator: (value) {
          if (Validator.validatePhone((myPhoneController.text ?? "12")) ==
              false) {
            return "typed number is incorrect";
          } else
            return null;
        },
      ),
    );
  }

  Padding getEmailFeild() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        keyboardType: TextInputType.multiline,
        controller: myEmailController,
        maxLines: null,
        textDirection: TextDirection.ltr,
        decoration: InputDecoration(
          prefixIcon: Icon(RequiredIcons.email),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10), gapPadding: 4),
          labelText: "e-mail",
          labelStyle: TextStyle(
            fontSize: Constants.MEDIUM_FONT_SIZE,
          ),
          errorMaxLines: 2,
          hintText: "johnetr12@gmail.com",
          hintStyle: TextStyle(fontSize: 15, color: Colors.black12),
        ),
        validator: (value) {
          if (Validator.validateEmail(myEmailController.text) == false) {
            return "incorrect email format";
          } else
            return null;
        },
      ),
    );
  }

  Padding getUserNameFeild() {
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
            fontSize: Constants.MEDIUM_FONT_SIZE,
          ),
          errorMaxLines: 2,
          hintText: "johnvan@512",
          hintStyle: TextStyle(fontSize: 15, color: Colors.black12),
        ),
        validator: (value) {
          if (Validator.validateUsername(myNameController.text) == false) {
            return "enter the valid username";
          } else
            return null;
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

  @override
  dispose() {
    super.dispose();
  }

  Widget getLoadingWidget() {
    return (this.errorText == Constants.SIGNING)
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
            (placeHolderText == Constants.FAILED_SIGNUP ||
                    placeHolderText == Constants.CONNECTION_ERROR_MSG)
                ? FlatButton(
                    onPressed: () {
                      //goes to login page again
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SignUpScreen()));
                    },
                    child: Text("try again"))
                : Container(),
          ],
        ),
      ),
    );
  }
}
