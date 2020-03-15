import 'package:flutter/material.dart';
import 'package:swasthyapala_flutter/constants.dart';
import 'package:swasthyapala_flutter/required_icons_.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: "No Title", home: LoginScreen());
  }
}

class LoginScreen extends StatelessWidget {
  //key to recognize our form
  final _formKey = GlobalKey<FormState>();

  TextEditingController myname_Controller;
  TextEditingController mypassword_Controller;

  static const theme_color = Color(0xff388e3c);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: <Widget>[
            InkWell(
              child: Container(
                decoration: BoxDecoration(
                    color: theme_color,
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
                        style: TextStyle(fontSize: Constants.small_font_size, color: Colors.white,fontFamily: "OpenSans"),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top:20.0),
              child: Container(
                //todo: for input feild button and other message
                child: Form(
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
                              hintStyle:
                                  TextStyle(fontSize: 15, color: Colors.black12),
                            ),
                            validator: (value) {
                              if (value.isEmpty) {
                                return "Please Enter some text";
                              } else
                                return null;
                            },
                            //this onChanged method is called whenever something changes in the feild
                            //we have made textediting controller optional here
                            onChanged: (values) {},
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
                              hintStyle:
                                  TextStyle(fontSize: Constants.medium_font_size, color: Colors.black12),
                            ),
                            validator: (value) {
                              if (value.isEmpty) {
                                return "Please Enter some text";
                              } else
                                return null;
                            },
                            //this onChanged method is called whenever something changes in the feild
                            //we have made textediting controller optional here
                            onChanged: (values) {},
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top:20.0),
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.9,
                            height: 50,
                            child: RaisedButton(
                              color: theme_color,
                              shape: RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(24),
                                  side: BorderSide(color: Colors.blue)),
                              onPressed: () {},
                              child: Text(
                                "Login",
                                style: TextStyle( fontSize: Constants.medium_font_size,color: Colors.white),
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
                                style: TextStyle( fontSize:Constants.small_font_size),
                              ),
                              InkWell(
                                child: Text(
                                  "register",
                                  style: TextStyle(color: Colors.redAccent),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    )),
              ),
            )
          ],
        ),
      ),
    );
  }
}
