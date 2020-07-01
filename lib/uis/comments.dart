import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swasthyapala_flutter/model/comment.dart';
import 'package:swasthyapala_flutter/model/replies.dart';
import 'package:swasthyapala_flutter/stmgmt/comments.dart';
import 'package:swasthyapala_flutter/util/constants.dart';

import '../stmgmt/comments.dart';

class PostCommentBox extends StatefulWidget {
  static const String routeName = "post_comment";

  final double verticalContentPadding,
      horizantalContentPadding,
      borderRadius,
      hintSize,
      textSize;
  final String hintText;

  final Color textColor, hintColor;

  PostCommentBox({
    this.verticalContentPadding = 10,
    this.horizantalContentPadding = 10,
    this.borderRadius = 10,
    this.hintSize = 15,
    this.hintColor = Colors.black38,
    this.hintText = "leave  a comment...",
    this.textSize = 15,
    this.textColor,
  });

  @override
  _PostCommentBoxState createState() => _PostCommentBoxState();
}

class _PostCommentBoxState extends State<PostCommentBox> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _commentController = TextEditingController();
  bool isTyping = false;
  FocusNode myFocusNode;

  @override
  void initState() {
    super.initState();
    _commentController.addListener(_changeSendWidget);
    myFocusNode = FocusNode();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SingleChildScrollView(
        child: Consumer<CommentsList>(
          builder: (context, commentDetail, child) {
            return Form(
              child: Container(
                height: 80,
                margin: EdgeInsets.all(5),
                child: TextFormField(
                  style: TextStyle(fontSize: Constants.medium_font_size),
                  maxLength: 200,
                  enableSuggestions: true,
                  autocorrect: true,
                  focusNode: myFocusNode,
                  autofocus: false,
                  onTap: () => myFocusNode.requestFocus(),
                  onEditingComplete: () {
                    setState(() {
                      this.isTyping = false;
                    });
                  },
                  decoration: InputDecoration(
                      errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                          borderSide: BorderSide(
                            color: Colors.red,
                            width: 1.0,
                          )),
                      hintText: widget.hintText,
                      prefix: Text(
                        '@ ${commentDetail.getUser()}' ?? " ",
                        style:
                            TextStyle(backgroundColor: Colors.lightBlueAccent),
                      ),
                      hintStyle: TextStyle(
                          fontSize: widget.hintSize, color: widget.hintColor),
                      suffixIcon: this.isTyping
                          ? InkWell(
                              onTap: () {
                                var mentionedUser = commentDetail.getUser();
                                commentDetail.setUser("");
                                //new comment
                                Comment _myComment;
                                if (mentionedUser == "") {
                                  _myComment = Comment(
                                      commentMessage: _commentController.text,
                                      userId: 5,
                                      userName: "Mohan Kumar Dhakal",
                                      commentsId: 2);
                                } else {
                                  Replies reply = Replies(
                                      repId: 2,
                                      mentionedUserId: 1,
                                      mentionedUserName: mentionedUser,
                                      replyMessage: _commentController.text);
                                  _myComment = Comment(
                                      commentsId: 2,
                                      commentMessage: '@ $mentionedUser ${_commentController.text}',
                                      userId: 5,
                                      userName: 'Ram Kumar Basyal',
                                      replies: reply);
                                }
                                commentDetail.addComment(_myComment);
                                _commentController.text = "";
                              },
                              splashColor: Colors.lightBlue,
                              child: Icon(
                                Icons.send,
                                size: Constants.icon_size,
                              ),
                            )
                          : Icon(
                              Icons.ondemand_video,
                              size: Constants.icon_size,
                            ),
                      focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.redAccent,
                          ),
                          borderRadius:
                              BorderRadius.circular(widget.borderRadius)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.green,
                          ),
                          borderRadius:
                              BorderRadius.circular(widget.borderRadius)),
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: widget.horizantalContentPadding,
                          vertical: widget.verticalContentPadding),
                      border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(widget.borderRadius),
                          borderSide: BorderSide(
                            color: Colors.black26,
                            width: 1.0,
                          ))),
                  maxLines: null,
                  textAlign: TextAlign.justify,
                  scrollPadding: EdgeInsets.all(5),
                  validator: (value) {
                    return null;
                  },
                  controller: _commentController,
                ),
              ),
              key: _formKey,
            );
          },
        ),
      ),
    );
  }

  _changeSendWidget() {
    if (_commentController.text.isEmpty) {
      setState(() {
        this.isTyping = false;
      });
    } else {
      setState(() {
        this.isTyping = true;
      });
    }
  }

  @override
  void dispose() {
    _commentController.dispose();
    myFocusNode.dispose();
    super.dispose();
  }
}
