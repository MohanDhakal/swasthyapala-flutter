import 'package:flutter/cupertino.dart';
import 'package:swasthyapala_flutter/model/comment.dart';
import 'package:swasthyapala_flutter/model/replies.dart';

class Comment with ChangeNotifier {
  NewComment _comment;

  Replies reply = new Replies();

  Comment({NewComment cmt}) {
    _comment = cmt;
  }

  void addReply(Replies reply) {
    this.reply = reply;
    notifyListeners();
  }

  void addLike() {
    _comment.removeLike();
    notifyListeners();
  }

  void removeLike() {
    _comment.addLike();
    notifyListeners();
  }
  int getLike(){
    return _comment.like;
  }

  String getMentionedUser() {
    return reply.mentionedUserName;
  }
}
