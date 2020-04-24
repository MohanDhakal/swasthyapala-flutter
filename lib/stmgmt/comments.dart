import 'package:flutter/cupertino.dart';
import 'package:swasthyapala_flutter/model/comment.dart';

class CommentsList with ChangeNotifier {
  List<Comment> comments;

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

  Future<List<Comment>> getAllComments() async {
    return await this.comments;
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
