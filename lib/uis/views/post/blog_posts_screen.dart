import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:swasthyapala_flutter/util/constants.dart';
import 'package:swasthyapala_flutter/util/utility_widget.dart';


class BlogPosts extends StatelessWidget {
  static const routeName = "blog";

  @override
  Widget build(BuildContext context) {

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
        appBar: AppBar(
          title: Text("Test App"),
        ),
        body: Container(
          margin: EdgeInsets.only(top: 15),
          child: Card(
            elevation: 5,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    ClipPath(
                      clipper: MyClipper(),
                      child: Container(
                        height: height * 0.30,
                        width: width,
                        child: Image.asset(
                             //todo:give dynamic uri in this name of string
                              "images/bg.png",
                              fit: BoxFit.cover,
                              color: Colors.black12,
                              //screen
                              colorBlendMode: BlendMode.screen,
                            )
                      ),
                    ),
                    Positioned(
                      left: width * 0.8,
                      top: height * 0.06,
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
                      top: height * 0.075,
                      left: width * 0.52,
                      child: Text(
                        "Mohan Dhakal",
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Positioned(
                      top: height * 0.11,
                      left: width * 0.65,
                      child: Text(
                        "AUTHOR",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: Constants.SMALL_FONT_SIZE),
                      ),
                    ),
                    Positioned(
                      left: width * 0.55,
                      top: height * 0.18,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Icon(
                            Icons.bookmark_border,
                            size: Constants.MEDIUM_ICON_SIZE,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 30.0),
                            child: Icon(
                              Icons.share,
                              size: Constants.MEDIUM_ICON_SIZE,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 30.0),
                            child: Icon(
                              Icons.thumb_up,
                              size: Constants.MEDIUM_ICON_SIZE,
                              color: Colors.black,
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
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
                    Stack(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                           Constants.ARTICLE_ABSTRACT,
                            textAlign: TextAlign.justify,
                            maxLines: 9,
                            overflow: TextOverflow.ellipsis,
                            
                            style: TextStyle(
                              letterSpacing: 0.5,
                              
                              color: Colors.black54,
                              fontStyle: FontStyle.normal,
                            ),
                          ),
                        ),
                        
                      ],
                    ),
                    Center(
                      child: Container(
                        width: width*0.95,
                        child: RaisedButton(
                            onPressed: () {},
                            elevation: 8,
                            color: Colors.lightBlueAccent,
                            child: Text(
                              "View In Full Screen",
                            )),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ));
  }

}

