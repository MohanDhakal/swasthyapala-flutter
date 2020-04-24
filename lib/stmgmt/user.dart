import 'package:flutter/cupertino.dart';
import 'package:swasthyapala_flutter/model/user.dart';

class User with ChangeNotifier {
  NewUser _newUser = NewUser();


  setUserName(String userName) {
    _newUser.userName = userName;
    notifyListeners();
  }

  setPhoneNumber(String phone) {
    _newUser.phone = phone;
    notifyListeners();
  }

  setEmail(String email) {
    _newUser.email = email;
    notifyListeners();
  }

  setId(int id) {
    _newUser.id = id;
    notifyListeners();
  }

  setPassword(String password) {
    _newUser.password = password;
    notifyListeners();
  }

//gettters


  String getPhone() {
    return _newUser.phone;
  }

  String getEmail() {
    return _newUser.email;
  }

  int getId() {
    return _newUser.id;
  }

  String getUserName() {
    return _newUser.userName;
  }

  String getPassword() {
    return _newUser.password;
  }
}
