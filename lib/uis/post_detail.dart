import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:swasthyapala_flutter/model/comment.dart';
import 'package:swasthyapala_flutter/model/messages.dart';
import 'package:swasthyapala_flutter/stmgmt/comments.dart';
import 'package:swasthyapala_flutter/uis/comments.dart';
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
    return ChangeNotifierProvider<CommentsList>(
      create: (_) => CommentsList(),
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
                          Constants.articleAbstract,
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
            getCommentsList()
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
                    color: Colors.black, fontSize: Constants.small_font_size),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /*adds tag to your post*/
  Widget getTags(List<String> tags) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          hashTag("health"),
          hashTag("health and food"),
          hashTag("availablity"),
          hashTag("accessibility")
        ],
      ),
    );
  }

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
                userId: list.elementAt(index).userId,
                userName: list.elementAt(index).userName,
                commentMessage: list.elementAt(index).commentMessage??list.elementAt(index).replies.replyMessage,
                object: list.elementAt(index),
                mentionedUser: comments.getUser()??" ",
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
  }

  Widget hashTag(name) {
    return UnconstrainedBox(
      child: Container(
          height: 30,
          decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey,
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(
                  12,
                ),
              )),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text(
                name,
                style: TextStyle(fontSize: Constants.small_font_size),
              ),
            ),
          )),
    );
  }

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
  final Comment object;
  final String mentionedUser;

  //with this check if image has been already used in a row

  static bool isImgTouched = false;

  MyComment(
      {this.userId,
      this.userName,
      this.commentMessage,
      this.object,
      this.mentionedUser});

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
                    fontSize: Constants.medium_font_size,
                    fontWeight: FontWeight.bold)),
            Text.rich(TextSpan(
                text: mentionedUser ?? " ",
                style: TextStyle(backgroundColor: Colors.lightBlueAccent),
                children: [TextSpan(text: commentMessage)])),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, top: 10.0),
                  child: InkWell(
                    onTap: () {
                      Provider.of<CommentsList>(context, listen: false)
                          .addLikes(this.object);
                    },
                    splashColor: Constants.them_color_1,
                    child: Icon(
                      Icons.thumb_up,
                      size: 15,
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Provider.of<CommentsList>(context, listen: false)
                        .setUser(this.userName);
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
              child: Text(
                  Provider.of<CommentsList>(context).getAllLikes(this.object) ==
                          0
                      ? " "
                      : Provider.of<CommentsList>(context)
                          .getAllLikes(this.object)
                          .toString()),
            ),
          ],
        ),
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
