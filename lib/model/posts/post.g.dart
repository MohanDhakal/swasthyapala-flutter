// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Post _$PostFromJson(Map<String, dynamic> json) {
  return Post()
    ..userId = json['userId'] as int
    ..tags = json['tags'] as String
    ..imageId = json['imageId'] as int
    ..title = json['title'] as String
    ..content = json['content'] as String
    ..dateTime = json['dateTime'] as String;
}

Map<String, dynamic> _$PostToJson(Post instance) => <String, dynamic>{
      'userId': instance.userId,
      'tags': instance.tags,
      'imageId': instance.imageId,
      'title': instance.title,
      'content': instance.content,
      'dateTime': instance.dateTime,
    };
