import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swasthyapala_flutter/stmgmt/signup_state.dart';
import 'package:swasthyapala_flutter/uis/home_screen.dart';
import 'package:swasthyapala_flutter/uis/login_screen.dart';
import 'package:swasthyapala_flutter/stmgmt/user.dart';
import '../util/constants.dart';
import '../required_icons_.dart';
import 'package:swasthyapala_flutter/util/validators.dart';

class SignUpScreen extends StatefulWidget {
  static const routeName = "/Signup";

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController myname_Controller;
  TextEditingController mypassword_Controller;
  IconData myIcons;
  String currentUser;
  bool showPassword;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    showPassword = false;
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
            InkWell(
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
                        Provider.of<User>(context, ).userName??"sign up",
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
              child: Container(
                child: Consumer<User>(
                  builder: (context, user, child) {
                    print(user.password);
//                    user=new User();
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
                                  hintText: "mohandkl@_50",
                                  hintStyle: TextStyle(
                                      fontSize: 15, color: Colors.black12),
                                ),
                                validator: (value) {
                                  user.userName = value;
                                  print(Validator.validateUsername(
                                      user.userName));
                                  if (Validator.validateUsername(
                                          (user.userName)) ==
                                      false) {
                                    return "enter the valid username";
                                  } else
                                    return null;
                                },
                                //this onChanged method is called whenever something changes in the feild
                                //we have made textediting controller optional here
                                onChanged: (value) {
                                  user.userName = value;
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
                                  prefixIcon: Icon(RequiredIcons.email),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      gapPadding: 4),
                                  labelText: "e-mail",
                                  labelStyle: TextStyle(
                                    fontSize: Constants.medium_font_size,
                                  ),
                                  errorMaxLines: 2,
                                  hintText: "useurstrength@gmail.com",
                                  hintStyle: TextStyle(
                                      fontSize: 15, color: Colors.black12),
                                ),
                                validator: (value) {
                                  user.email = value;

                                  if (Validator.validateEmail((user.email)) ==
                                      false) {
                                    return "incorrect email format";
                                  } else
                                    return null;
                                },
                                //this onChanged method is called whenever something changes in the feild
                                //we have made textediting controller optional here
                                onChanged: (values) {
                                  user.email = values;
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
                                  prefixIcon: Icon(Icons.phone),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      gapPadding: 4),
                                  labelText: "phone",
                                  labelStyle: TextStyle(
                                    fontSize: Constants.medium_font_size,
                                  ),
                                  errorMaxLines: 2,
                                  hintText: "9846132456",
                                  hintStyle: TextStyle(
                                      fontSize: 15, color: Colors.black12),
                                ),
                                validator: (value) {
                                  user.phone = value;
                                  if (Validator.validatePhone((user.phone)) ==
                                      false) {
                                    return "number can't be empty";
                                  } else
                                    return null;
                                },
                                //this onChanged method is called whenever something changes in the feild
                                //we have made textediting controller optional here
                                onChanged: (values) {
                                  user.phone = values;
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                keyboardType: TextInputType.multiline,
                                controller: myname_Controller,
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
                                      borderRadius: BorderRadius.circular(10),
                                      gapPadding: 4),
                                  labelText: "password",
                                  labelStyle: TextStyle(
                                    fontSize: Constants.medium_font_size,
                                  ),
                                  errorMaxLines: 2,
                                  hintText: "sample pass:abcDEF*@40",
                                  hintStyle: TextStyle(
                                      fontSize: Constants.medium_font_size,
                                      color: Colors.black12),
                                ),
                                validator: (value) {
                                  user.password = value;
                                  if (Validator.validatePasswored(
                                          user.password) ==
                                      false) {
                                    return "enter the valid email";
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
                                    if (_formKey.currentState.validate()) {
                                      Util().getUser().then((value) {
                                        if (user.userName == value) {
                                          Scaffold.of(
                                                  _formKey.currentState.context)
                                              .showSnackBar(SnackBar(
                                            content:
                                                Text("username already taken"),
                                          ));
                                        } else {
                                          Navigator.pushReplacementNamed(
                                              context, HomeScreen.routeName,
                                              arguments: user);
                                        }
                                      });
                                    }
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
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  Text(
                                    "Already a user?",
                                    style: TextStyle(
                                        fontSize: Constants.small_font_size),
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
                                              builder: (context) =>
                                                  LoginScreen()));
                                    },
                                    splashColor: Colors.redAccent,
                                  )
                                ],
                              ),
                            )
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
}
