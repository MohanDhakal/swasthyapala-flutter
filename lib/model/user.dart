import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class NewUser {
  int _id;
  String _phone;
  String _email, _userName, _password;

  NewUser.name(
       this._phone, this._email, this._userName, this._password);

  NewUser();

  factory NewUser.fromJson(Map<String, dynamic> json) =>
      _$NewUserFromJson(json);


  Map<String, dynamic> toJson() => _$NewUserToJson(this);

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
