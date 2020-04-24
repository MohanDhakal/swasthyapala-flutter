import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swasthyapala_flutter/model/comment.dart';
import 'package:swasthyapala_flutter/stmgmt/comments.dart';
import 'package:swasthyapala_flutter/util/constants.dart';
import 'package:swasthyapala_flutter/util/utility_widget.dart';


class PostList extends StatefulWidget {
  static const routeName = "/postlist";

  @override
  _PostListState createState() => _PostListState();
}

class _PostListState extends State<PostList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[Post(), Post()],
      ),
    );
  }
}

class Post extends StatefulWidget {
  static const routeName = "/post";

  @override
  _PostState createState() => _PostState();
}

class _PostState extends State<Post> {
  Color bkmark_selected = Colors.black38;
  Color share_selected = Colors.black38;
  Color like_selected = Colors.black38;

  @override
  Widget build(BuildContext context) {

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    //upper container ko width and height

    double upperContainerWidth = width;
    double upperContainerHeight = 250;

    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        margin: EdgeInsets.all(10),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(14),
          child: Container(
            width: width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                upperPart(upperContainerHeight, upperContainerWidth),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "My Favourite Color",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                          ),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.timer,
                            color: Colors.black38,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                            "9:30 pm",
                            style: TextStyle(color: Colors.black38),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 15.0),
                          child: Text(
                            "#drink",
                            style: TextStyle(color: Colors.black38),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 5.0),
                          child: Text(
                            "#coffee",
                            style: TextStyle(color: Colors.black38),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.all(10),
                  child: Text(
                    "this is the sample text to fill up the space"
                    "this is the sample text to fill up the space."
                    "this is the sample text to fill up the space "
                    "this is the sample text to fill up the space."
                    "this is the sample text to fill up the space"
                    "this is the sample text to fill up the space"
                    "this is the sample text to fill up the space.",
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.black54,
                      fontStyle: FontStyle.normal,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                ),
                Center(
                  widthFactor: 3,
                  heightFactor: 1,
                  child: FlatButton(
                    color: Colors.lightGreen,
                    splashColor: Colors.green,
                    autofocus: false,
                    child: Text("Tap to view more"),
                    onPressed: () {},
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget upperPart(upperContainerHeight, upperContainerWidth) {
    return Stack(
      children: <Widget>[
        ClipPath(
          clipper: MyClipper(),
          child: Container(
              height: upperContainerHeight,
              width: upperContainerWidth,
              child: Image.asset(
                //give dynamic uri in this name of string
                "images/bg.png",
                fit: BoxFit.cover,
                color: Colors.black12,
                //screen
                colorBlendMode: BlendMode.screen,
              )),
        ),
        Positioned(
          top: upperContainerHeight * 0.2,
          left: upperContainerWidth * 0.8,
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
        Positioned(
          top: upperContainerHeight * 0.22,
          left: upperContainerWidth * 0.40,
          child: Text(
            "Mohan Dhakal",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
        Positioned(
          top: upperContainerHeight * 0.30,
          left: upperContainerWidth * 0.40,
          child: Text(
            "AUTHOR",
            style: TextStyle(
                color: Colors.black, fontSize: Constants.small_font_size),
          ),
        ),
        Positioned(
          top: upperContainerHeight * 0.40,
          left: upperContainerWidth * 0.35,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.bookmark,
                  color: bkmark_selected,
                ),
                iconSize: 20,
                onPressed: () {
                  setState(() {
                    if (bkmark_selected == Colors.black38) {
                      bkmark_selected = Colors.blue;
                    } else {
                      bkmark_selected = Colors.black38;
                    }

                  });
                },
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: IconButton(
                  icon: Icon(
                    Icons.share,
                    size: 20,
                    color: share_selected,
                  ),
                  onPressed: () {
                    setState(() {
                      if (share_selected == Colors.black38) {
                        share_selected = Colors.blue;
                      } else {
                        share_selected = Colors.black38;
                      }
                    });
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: IconButton(

                  icon: Icon(
                    Icons.thumb_up,
                    size: 20,
                    color: like_selected,
                  ),
                  onPressed: () {
                    if (like_selected == Colors.black38) {
                      setState(() {
                        like_selected = Colors.blue;
                      });
                      //todo: update the comment section with dynamic parameters
                      Provider.of<CommentsList>(context,listen: false).addLikes(new Comment(
                        commentsId: 1,
                        commentMessage: "This is my own comment and nobody can take over it hai guys!",
                        userId: 2,
                        userName: "Mohan Kumar Dhakal",
                        likes: 2
                      ));
                    } else {
                      setState(() {
                        like_selected = Colors.black38;
                      });
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
