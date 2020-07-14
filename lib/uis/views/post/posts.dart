import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:swasthyapala_flutter/enum/view_state.dart';
import 'package:swasthyapala_flutter/stmgmt/image_progress.dart';
import 'package:swasthyapala_flutter/stmgmt/post.dart';
import 'package:swasthyapala_flutter/stmgmt/user.dart';
import 'package:swasthyapala_flutter/util/constants.dart';
import 'package:swasthyapala_flutter/util/utility_widget.dart';

class PostList extends StatefulWidget {
  static const routeName = "/postlist";

  @override
  _PostListState createState() => _PostListState();
}

class _PostListState extends State<PostList> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 0)).then((value) {
      Provider.of<PostBloc>(context, listen: false).addPostListToUi();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(child: Consumer<PostBloc>(
      builder: (context, posts, child) {
        return posts.state == ViewState.active
            ? Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                itemBuilder: (context, index) {
                  final newPost = posts.getAllPost.elementAt(index);
                  return MultiProvider(
                    providers: [
                      ChangeNotifierProvider(
                        create: (_) => UserBloc(),
                      ),
                      ChangeNotifierProvider(
                        create: (_) => ImageProgress(),
                      )
                    ],
                    child: Post(
                      title: newPost.title,
                      content: newPost.content,
                      time: newPost.dateTime,
                      tags: newPost.tags,
                      userId: newPost.userId,
                      imageId: newPost.imageId,
                    ),
                  );
                },
                itemCount: posts.getAllPost.length,
              );
      },
    ));
  }
}

class Post extends StatefulWidget {
  final String title, content;
  final String tags;
  final String time;
  final int userId;
  final int imageId;

  Post(
      {this.time,
      this.content,
      this.tags,
      this.title,
      this.userId,
      this.imageId});

  static const routeName = "/post";

  @override
  _PostState createState() => _PostState();
}

class _PostState extends State<Post> {
  Color bkmarkSelected = Colors.black38;
  Color shareSelected = Colors.black38;
  Color likeSelected = Colors.black38;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<UserBloc>(context, listen: false)
          .setUserWithId(widget.userId);
      Provider.of<ImageProgress>(context, listen: false)
          .addImageUri(context, widget.imageId);
    });

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
                          widget.title,
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
                            widget.time.substring(12, 16),
                            style: TextStyle(color: Colors.black38),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 15.0),
                          child: Text(
                            widget.tags.split(',').first ?? ' ',
                            style: TextStyle(color: Colors.black38),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 5.0),
                          child: Text(
                            widget.tags.split(',').last ?? ' ',
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
                    widget.content,
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
              child: Consumer<ImageProgress>(
                builder: (context, image, child) {
                  return image.state == ViewState.active
                      ? SpinKitFadingGrid(
                          color: Colors.greenAccent,
                        )
                      : Image.network(
                          image.imageUri ?? Constants.defaultImageUri,
                          fit: BoxFit.cover,
                          color: Colors.black12,
                          //screen
                          colorBlendMode: BlendMode.screen,
                        );
                },
              )),
        ),
        Positioned(
          top: upperContainerHeight * 0.1,
          left: upperContainerWidth * 0.75,
          child: ClipRRect(
            child: Image.asset(
              "images/mohan.jpg",
              fit: BoxFit.cover,
              height: 50,
              width: 50,
            ),
            borderRadius: BorderRadius.circular(24),
          ),
        ),
        Consumer<UserBloc>(
          builder: (context, newUser, child) {
            return Positioned(
              top: upperContainerHeight * 0.12,
              left: upperContainerWidth * 0.40,
              child: Text(
                newUser.state == ViewState.active || newUser.user == null
                    ? ""
                    : newUser.user.userName,
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
            );
          },
        ),
        Positioned(
          top: upperContainerHeight * 0.20,
          left: upperContainerWidth * 0.40,
          child: Text(
            "AUTHOR",
            style: TextStyle(
                color: Colors.black, fontSize: Constants.SMALL_FONT_SIZE),
          ),
        ),
        Positioned(
          top: upperContainerHeight * 0.30,
          left: upperContainerWidth * 0.35,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.bookmark,
                  color: bkmarkSelected,
                ),
                iconSize: 20,
                onPressed: () {
                  setState(() {
                    if (bkmarkSelected == Colors.black38) {
                      bkmarkSelected = Colors.blue;
                    } else {
                      bkmarkSelected = Colors.black38;
                    }
                  });
                },
              ),
              Padding(
                padding: EdgeInsets.all(8),
                child: IconButton(
                  icon: Icon(
                    Icons.share,
                    size: 20,
                    color: shareSelected,
                  ),
                  onPressed: () {
                    setState(() {
                      if (shareSelected == Colors.black38) {
                        shareSelected = Colors.blue;
                      } else {
                        shareSelected = Colors.black38;
                      }
                    });
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8),
                child: IconButton(
                  icon: Icon(
                    Icons.thumb_up,
                    size: 20,
                    color: likeSelected,
                  ),
                  onPressed: () {
                    if (likeSelected == Colors.black38) {
                      setState(() {
                        likeSelected = Colors.blue;
                      });
                    } else {
                      setState(() {
                        likeSelected = Colors.black38;
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
