// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User()
    ..userId = json['userId'] as int
    ..password = json['password']
    ..userName = json['userName']
    ..email = json['email'] as String
    ..phone = json['phone'] as String;
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'userId': instance.userId,
      'password': instance.password,
      'userName': instance.userName,
      'email': instance.email,
      'phone': instance.phone,
    };
