import 'package:flutter/cupertino.dart';
import 'package:swasthyapala_flutter/model/comment.dart';

class CommentsList with ChangeNotifier {
  List<NewComment> comments;

  CommentsList() {
    comments = new List();
  }

  addComment(NewComment comment) {
    comments.add(comment);
    notifyListeners();
  }

  removeComment(index) {
    comments.removeAt(index);
    notifyListeners();
  }

  List<NewComment> getAllComments() {
    return this.comments;
  }

}
