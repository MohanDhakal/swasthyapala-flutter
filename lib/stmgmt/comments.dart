import 'package:flutter/cupertino.dart';
import 'package:swasthyapala_flutter/model/comment.dart';

class CommentsList with ChangeNotifier {
  List<Comment> comments;
  dynamic _mentionedUser;


  void addMentionedUser(value){
    _mentionedUser=value;
  }

  void setUser(dynamic  text) {
    this._mentionedUser = text;
    notifyListeners();
  }

  dynamic getUser(){
    return _mentionedUser;
  }

  CommentsList() {
    comments = new List();
  }

  addComment(Comment comment) {
    comments.add(comment);
    notifyListeners();
  }

  removeComment(index) {
    comments.removeAt(index);
    notifyListeners();
  }

  List<Comment> getAllComments() {
    return this.comments;
  }

  getAllLikes(Comment comment) {
    return comment.getLikes(comment);
  }

  addLikes(Comment comment) {
    comment.addLikes(comment);
    notifyListeners();
  }

  removeLikes(Comment comment) {
    comment.removeLikes(comment);
    notifyListeners();
  }
}
