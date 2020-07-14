import 'package:swasthyapala_flutter/model/replies.dart';

class NewComment {
  int like;
  int commentsId;

  String commentMessage;

  String userName;
  int userId;

  Replies replies;

  NewComment(
      {this.like = 0,
      this.commentMessage,
      this.replies,
      this.userName,
      this.commentsId,
      this.userId});

  addLike() {
    ++like;
  }

  removeLike() {
    --like;
  }
}
