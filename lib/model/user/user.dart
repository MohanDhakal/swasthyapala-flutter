import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  int _userId;
  String _phone;
  String _email, _userName, _password;

  User.name(
       this._phone, this._email, this._userName, this._password);

  User();

  factory User.fromJson(Map<String, dynamic> json) =>
      _$UserFromJson(json);


  Map<String, dynamic> toJson() => _$UserToJson(this);

  int get userId => _userId;

  set userId(int value) {
    _userId = value;
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
