import 'package:flutter/cupertino.dart';

class NewUser {

  int _id;
  String _phone;
  String _email, _userName, _password;

  NewUser.name(this._id, this._phone, this._email, this._userName, this._password);

  NewUser();

  int get id => _id;

  set id(int value) {
    _id = value;
  }

  get password => _password;

  set password(value) {
    _password = value;

  }

  get userName => _userName;

  set userName(value) {
    _userName = value;
  }

  String get email => _email;

  set email(String value) {
    _email = value;
  }

  String get phone => _phone;

  set phone(String value) {
    _phone = value;
  }
}
