import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:swasthyapala_flutter/model/comment.dart';
import 'package:swasthyapala_flutter/model/messages.dart';
import 'package:swasthyapala_flutter/model/replies.dart';
import 'package:swasthyapala_flutter/stmgmt/comment.dart';
import 'package:swasthyapala_flutter/stmgmt/comments.dart';
import 'package:swasthyapala_flutter/uis/views/post/widgets/comments.dart';
import 'package:swasthyapala_flutter/util/constants.dart';

class PostDetail extends StatefulWidget {
  static const routeName = "/postDetail";

  @override
  _PostDetailState createState() => _PostDetailState();
}

class _PostDetailState extends State<PostDetail> {
  MessageList messageList;
  CommentsList commentsList;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<CommentsList>(
          create: (_) => CommentsList(),
        ),
        ChangeNotifierProvider<Comment>(
          create: (_) => Comment(),
        ),
      ],
      child: Scaffold(
        body: ListView(
          children: <Widget>[
            getWriterInfo("Mohan Kumar Dhakal", "Engineer,Nutrition Enthusiast",
                "Engineer with a motive and a self motivated developer"),
            Container(
              margin: EdgeInsets.only(top: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Image.asset(
                        "images/cover.jpeg",
                      ),
                      Container(
                        margin: EdgeInsets.all(12),
                        child: Text(
                          Constants.ARTICLE_ABSTRACT,
                          textAlign: TextAlign.justify,
                          maxLines: 50,
                          style: TextStyle(
                            letterSpacing: 0.5,
                            fontStyle: FontStyle.normal,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            PostCommentBox(),
            Consumer<CommentsList>(builder: (context, comments, child) {
              return ListView.builder(
                  shrinkWrap: true,
                  itemCount: comments.getAllComments().length,
                  physics: ClampingScrollPhysics(),
                  itemBuilder: (context, index) {
                    var myComment = comments.getAllComments().elementAt(index);
                    return MyComment(
                      commentMessage: myComment.commentMessage,
                      userName: myComment.userName,
                      userId: myComment.userId,
                      object: myComment,
                    );
                  });
            })
          ],
        ),
      ),
    );
  }

  Widget getWriterInfo(String name, String post, String description) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 5),
            child: ClipRRect(
              child: Image.asset(
                "images/cover.jpeg",
                fit: BoxFit.cover,
                height: 50,
                width: 50,
              ),
              borderRadius: BorderRadius.circular(24),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                name,
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
              Text(
                post,
                style: TextStyle(
                    color: Colors.black, fontSize: Constants.SMALL_FONT_SIZE),
              ),
            ],
          ),
        ],
      ),
    );
  }


/*
  Widget getCommentsList() {
    List<Comment> list;

    return Consumer<CommentsList>(
      builder: (context, comments, child) {
        list = comments.getAllComments();

        if (list != null) {
          return ListView.builder(
            shrinkWrap: true,
            physics: ClampingScrollPhysics(),
            itemBuilder: (context, index) {
              return MyComment(
                userId: list
                    .elementAt(index)
                    .userId,
                userName: list
                    .elementAt(index)
                    .userName,
                commentMessage: list
                    .elementAt(index)
                    .commentMessage ??
                    list.elementAt(index),
                object: list.elementAt(index),
                mentionedUser: comments.getUser() ?? " ",
              );
            },
            itemCount: list.length,
          );
        } else {
          return Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text("No comments added"),
          );
        }
      },
    );
  }*/



  Future<MessageList> _fetchJsonData() async {
    String jsonString = await _loadJsonFromAsset();
    final jsonResponse = json.decode(jsonString);
    messageList = MessageList.fromJson(jsonResponse);
    return messageList;
  }

  Future<String> _loadJsonFromAsset() async {
    return await rootBundle.loadString('json/comments.json');
  }
}

class MyComment extends StatelessWidget {
  @required
  final int userId;
  @required
  final String userName;
  @required
  final String commentMessage;
  @required
  final NewComment object;

  //with this check if image has been already used in a row

  static bool isImgTouched = false;

  MyComment({
    this.userId,
    this.userName,
    this.commentMessage,
    this.object,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        getImageAsset(context),
        getNameAndComments(context),
      ],
    );
  }

  Widget getImageAsset(context) {
    isImgTouched = true;

    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: ClipRRect(
        child: Image.asset(
          "images/cover.jpeg",
          fit: BoxFit.cover,
          height: 50,
          width: 50,
        ),
        borderRadius: BorderRadius.circular(24),
      ),
    );
  }

  Widget getNameAndComments(context) {
    isImgTouched = false;
    return Flexible(
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(this.userName,
                  style: TextStyle(
                      fontSize: Constants.MEDIUM_FONT_SIZE,
                      fontWeight: FontWeight.bold)),
              Consumer<Comment>(builder: (context, comment, child) {
                return comment.getMentionedUser() != null
                    ? Text.rich(TextSpan(children: [
                        TextSpan(
                          text: '@ ${comment.getMentionedUser()}',
                          style: TextStyle(
                              backgroundColor: Colors.lightBlueAccent),
                        ),
                        TextSpan(text: commentMessage),
                      ]))
                    : Text(commentMessage);
              }),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, top: 10.0),
                    child: InkWell(
                      onTap: () {
                        Provider.of<Comment>(context, listen: false).addLike();
                      },
                      splashColor: Constants.THEME_COLOR_1,
                      child: Icon(
                        Icons.thumb_up,
                        size: 15,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      var rep = Replies(mentionedUserName: userName);
                      Provider.of<Comment>(context, listen: false)
                          .addReply(rep);
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0, top: 10),
                      child: Text(
                        "reply",
                        style: TextStyle(color: Colors.lightBlue),
                      ),
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8.0,
                ),
                child: Consumer<Comment>(builder: (context, comment, child) {
                  return Text(comment.getLike() as String);
                }),
              )
            ]),
      ),
    );
  }

  bool isEven(int a) {
    if (a % 2 == 0)
      return true;
    else
      return false;
  }
}
