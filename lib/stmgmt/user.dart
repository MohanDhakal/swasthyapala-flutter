import 'package:flutter/cupertino.dart';

class User extends ChangeNotifier{

  int _id;
  String _phone;
  String _email, _userName, _password;

  User.name(this._id, this._phone, this._email, this._userName, this._password);

  User();

  int get id => _id;

  set id(int value) {
    _id = value;
    notifyListeners();
  }

  get password => _password;

  set password(value) {
    _password = value;
    notifyListeners();
  }

  get userName => _userName;

  set userName(value) {
    _userName = value;
    notifyListeners();
  }

  String get email => _email;

  set email(String value) {
    _email = value;
    notifyListeners();
  }

  String get phone => _phone;

  set phone(String value) {
    _phone = value;
    notifyListeners();
  }


}
