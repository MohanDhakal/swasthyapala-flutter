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
    return Scaffold(
      body: ListView(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 50),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Text(
                          "Mohan Dhakal",
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "AUTHOR",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: Constants.small_font_size),
                        ),
                      ],
                    ),
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
                  ],
                ),
                Padding(
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
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Image.asset(
                      "images/cover.jpeg",
                    ),
                    Container(
                      margin: EdgeInsets.all(12),
                      child: Text(
                        "This is the test status for the sample app with flutter ,it can be extended"
                        "as you wish because it's height is unbounded as you wish because it's height is unbounded"
                        "as you wish because it's height is unbounded as you wish because it's height is unbounded"
                        "as you wish because it's height is unbounded as you wish because it's height is unbounded",
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
          getCommentsList(),
        ],
      ),
    );
  }

  Widget getCommentsList() {
    List<Comment> list;

    return Consumer<CommentsList>(
      builder: (context, comments, child) {
        print("into the builder function with ");

        comments.getAllComments().then((value) {
          print(value.length);
          list = value;
        });

        if (list != null) {
          return ListView.builder(
            shrinkWrap: true,
            physics: ClampingScrollPhysics(),
            itemBuilder: (context, index) {
              return MyComment(
                userId: list.elementAt(index).userId,
                userName: list.elementAt(index).userName,
                commentMessage: list.elementAt(index).commentMessage,
                object: list.elementAt(index),
              );
            },
            itemCount: list.length,
          );
        } else {
          return Text("No comments added");
        }
      },
    );
  }

  Widget getComments() {
    if (messageList == null) {
      return Text("data is on the way");
    } else {
      return Expanded(
        child: ListView.builder(
          itemCount: messageList.msgList.length,
          itemBuilder: (context, index) {
            return Container(
              child: Text(messageList.msgList.elementAt(index).name),
            );
          },
        ),
      );
    }
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
  Comment object;

  static bool isImgTouched = false;

  MyComment({this.userId, this.userName, this.commentMessage, this.object});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
          isEven(this.userId) ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: <Widget>[
        isEven(this.userId)
            ? getNameAndComments(context)
            : getImageAsset(context),
        isImgTouched ? getNameAndComments(context) : getImageAsset(context)
      ],
    );
  }

  Widget getImageAsset(context) {
    isImgTouched = true;

    return ClipRRect(
      child: Image.asset(
        "images/cover.jpeg",
        fit: BoxFit.cover,
        height: 50,
        width: 50,
      ),
      borderRadius: BorderRadius.circular(24),
    );
  }

  Widget getNameAndComments(context) {
    isImgTouched = false;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(this.userName,
            style: TextStyle(
                fontSize: Constants.medium_font_size,
                fontWeight: FontWeight.bold)),
        Text(this.commentMessage,
            style: TextStyle(
              fontSize: Constants.small_font_size,
            )),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5.0),
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2),
              child: Text(
                "reply",
                style: TextStyle(color: Colors.lightBlue),
              ),
            )
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal:8.0,vertical:5.0 ),
          child: Text(
              Provider.of<CommentsList>(context).getAllLikes(this.object) == 0
                  ? " "
                  : Provider.of<CommentsList>(context)
                      .getAllLikes(this.object)
                      .toString()),
        ),
      ],
    );
  }

  bool isEven(int a) {
    if (a % 2 == 0)
      return true;
    else
      return false;
  }
}
