import 'package:json_annotation/json_annotation.dart';

part 'post.g.dart';

@JsonSerializable()
class Post {
  String _title, _content;
  String _tags;
  int _postId;
  int _imageId;
  int _userId;
  String _dateTime;

  int get userId => _userId;

  set userId(int value) {
    _userId = value;
  }

  Post();

  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);

  Map<String, dynamic> toJson() => _$PostToJson(this);

  set tags(tags) {
    _tags = tags;
  }

  set dateTime(String value) {
    _dateTime = value;
  }

  set title(title) {
    _title = title;
  }

  set content(content) {
    _content = content;
  }

  set imageId(image) {
    _imageId = image;
  }

  String get tags => _tags;

  int get imageId => _imageId;

  int get postId => _postId;

  String get title => _title;

  String get content => _content;

  String get dateTime => _dateTime;
}
