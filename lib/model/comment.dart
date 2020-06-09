import 'package:flutter/foundation.dart';
import 'package:swasthyapala_flutter/model/replies.dart';

class Comment {
  int likes;
  int commentsId;

  String commentMessage;

  String userName;
  int userId;

  Replies replies;

  Comment(
      {this.likes = 0,
      this.commentMessage,
      this.replies,
      this.userName,
      this.commentsId,
      this.userId});

  addLikes(Comment comment) {
    comment.likes++;
  }

  removeLikes(Comment comment) {
    comment.likes--;
  }

  getLikes(Comment comment) {
    return comment.likes;
  }
}
