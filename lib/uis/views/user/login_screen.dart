import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:swasthyapala_flutter/enum/view_state.dart';
import 'package:swasthyapala_flutter/main.dart';
import 'package:swasthyapala_flutter/required_icons_.dart';
import 'package:swasthyapala_flutter/stmgmt/user.dart';
import 'package:swasthyapala_flutter/uis/views/user/signup_screen.dart';
import 'package:swasthyapala_flutter/util/constants.dart';
import 'package:swasthyapala_flutter/util/services/connection.dart';

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
  String errorText = Constants.LOGGING;
  var connectedToInternet;

  @override
  void initState() {
    super.initState();
    myNameController = TextEditingController();
    myPasswordController = TextEditingController();
    //checks network connectivity
    Connection.isConnected().then((value) {
      connectedToInternet = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child: ListView(
        children: <Widget>[
          getBanner(context),
          Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      getUserNameFeild(),
                      getPasswordFeild(),
                      getLoginButton(context),
                      getBottomWidgetList(context)
                    ],
                  )))
        ],
      )),
    );
  }

  Padding getBottomWidgetList(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Text(
            "Not registered already?",
            style: TextStyle(fontSize: Constants.SMALL_FONT_SIZE),
          ),
          InkWell(
            child: Text(
              "register",
              style: TextStyle(color: Colors.redAccent),
            ),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return ChangeNotifierProvider<UserBloc>(
                  create: (_) => UserBloc(),
                  child: SignUpScreen(),
                );
              }));
            },
            splashColor: Colors.redAccent,
          )
        ],
      ),
    );
  }

  Padding getLoginButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        height: 50,
        child: RaisedButton(
          color: Constants.THEME_COLOR,
          shape: RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(24),
              side: BorderSide(color: Colors.blue)),
          onPressed: () async {
            if (connectedToInternet) {
              if (_formKey.currentState.validate()) {
                showStatusDialog(Constants.LOGGING);
                handleLogin();
              }
              //if form validation is not correct
              else {
                Scaffold.of(_formKey.currentContext).showSnackBar(SnackBar(
                  content: Text("form validation error"),
                ));
              }
            } else {
              Scaffold.of(_formKey.currentContext).showSnackBar(SnackBar(
                content: Text("no internet connection"),
              ));
            }
          },
          child: Text(
            "Login",
            style: TextStyle(
                fontSize: Constants.MEDIUM_FONT_SIZE, color: Colors.white),
          ),
        ),
      ),
    );
  }

  Padding getPasswordFeild() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        keyboardType: TextInputType.multiline,
        controller: myPasswordController,
        maxLines: null,
        textDirection: TextDirection.ltr,
        decoration: InputDecoration(
          prefixIcon: Icon(RequiredIcons.vpn_key),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10), gapPadding: 4),
          labelText: "password",
          labelStyle: TextStyle(
            fontSize: Constants.MEDIUM_FONT_SIZE,
          ),
          errorMaxLines: 2,
          hintText: "Enter your password",
          hintStyle: TextStyle(
              fontSize: Constants.MEDIUM_FONT_SIZE, color: Colors.black12),
        ),
        validator: (value) {
          if (value.length < 6) {
            return "invalid format";
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
          hintText: " enter your user name",
          hintStyle: TextStyle(fontSize: 15, color: Colors.black12),
        ),
        validator: (value) {
          if (value.length < 6) {
            return "invalid format";
          } else
            return null;
        },
      ),
    );
  }

  InkWell getBanner(BuildContext context) {
    return InkWell(
      child: Container(
        decoration: BoxDecoration(
            color: Constants.THEME_COLOR,
            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(80))),
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

  @override
  dispose() {
    super.dispose();
  }

  Widget getLoadingWidget() {
    return (this.errorText == Constants.LOGGING)
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
                              builder: (context) => LoginScreen()));
                    },
                    child: Text("try again"))
                : Container(),
          ],
        ),
      ),
    );
  }

  //client validation of the form

  void handleLogin() async {
    final user = Provider.of<UserBloc>(context, listen: false);
    bool validated = await user.validateUser(
        myNameController.text, myPasswordController.text);
    print(validated);
    if (user.state == ViewState.active) {
      showStatusDialog(Constants.LOGGING);
    } else if (user.state == ViewState.idle) {
      if (validated) {
        Navigator.pop(context);
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomeScreen()));
      } else {
        Scaffold.of(_formKey.currentContext).showSnackBar(SnackBar(
          content: Text("username of password didn't match"),
        ));
      }
    }
  }
}
