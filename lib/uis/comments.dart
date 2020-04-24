import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swasthyapala_flutter/model/comment.dart';
import 'package:swasthyapala_flutter/stmgmt/comments.dart';
import 'package:swasthyapala_flutter/util/constants.dart';

class PostCommentBox extends StatefulWidget {
  static const String routeName = "post_comment";

  final double verticalContentPadding,
      horizantalContentPadding,
      borderRadius,
      hintSize,
      textSize;
  final String hintText;

  final Color textColor, hintColor;
  bool isTyping;

  PostCommentBox(
      {this.verticalContentPadding = 10,
      this.horizantalContentPadding = 10,
      this.borderRadius = 24,
      this.hintSize = 15,
      this.hintColor = Colors.black38,
      this.hintText = "give some hint",
      this.textSize = 15,
      this.textColor,
      this.isTyping = false});

  @override
  _PostCommentBoxState createState() => _PostCommentBoxState();
}

class _PostCommentBoxState extends State<PostCommentBox> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _commentController = TextEditingController();

  @override
  void initState() {
    _commentController.addListener(_changeSendWidget);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Form(
        child: Container(
          margin: EdgeInsets.all(10),
          child: TextFormField(
            style: TextStyle(fontSize: Constants.medium_font_size),
            maxLength: 200,
            enableSuggestions: true,
            autocorrect: true,
            onEditingComplete: () {
              setState(() {
                widget.isTyping = false;
              });
            },
            decoration: InputDecoration(
                errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                    borderSide: BorderSide(
                      color: Colors.red,
                      width: 1.0,
                    )),
                hintText: widget.hintText,
                hintStyle: TextStyle(
                    fontSize: widget.hintSize, color: widget.hintColor),
                suffixIcon: widget.isTyping
                    ? InkWell(
                        onTap: () {
                          //new comment
                          Comment newComment = Comment(
                              commentMessage: _commentController.text,
                              userId: 4,
                              userName: "mohan kumar",
                              commentsId: 2);

                          Provider.of<CommentsList>(context, listen: false)
                              .addComment(newComment);
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
                    borderRadius: BorderRadius.circular(widget.borderRadius)),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.green,
                    ),
                    borderRadius: BorderRadius.circular(widget.borderRadius)),
                contentPadding: EdgeInsets.symmetric(
                    horizontal: widget.horizantalContentPadding,
                    vertical: widget.verticalContentPadding),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(widget.borderRadius),
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
      ),
    );
  }

  _changeSendWidget() {
    if (_commentController.text.isEmpty) {
      setState(() {
        widget.isTyping = false;
      });
    } else {
      setState(() {
        widget.isTyping = true;
      });
    }
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }



}
