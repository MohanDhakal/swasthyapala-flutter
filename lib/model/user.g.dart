// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NewUser _$NewUserFromJson(Map<String, dynamic> json) {
  return NewUser()
    ..id = json['id'] as int
    ..password = json['password']
    ..userName = json['userName']
    ..email = json['email'] as String
    ..phone = json['phone'] as String;
}

Map<String, dynamic> _$NewUserToJson(NewUser instance) => <String, dynamic>{
      'id': instance.id,
      'password': instance.password,
      'userName': instance.userName,
      'email': instance.email,
      'phone': instance.phone,
    };
