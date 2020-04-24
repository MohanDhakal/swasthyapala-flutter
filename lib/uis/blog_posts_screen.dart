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
          height: height * 0.725,
          margin: EdgeInsets.only(top: 15),
          child: Card(
            elevation: 10,
            child: Column(
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    ClipPath(
                      clipper: MyClipper(),
                      child: Container(
                        height: height * 0.30,
                        width: width,
                        child: Image.asset(
                             //give dynamic uri in this name of string
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
                            fontSize: Constants.small_font_size),
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
                            size: Constants.medium_icon_size,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 30.0),
                            child: Icon(
                              Icons.share,
                              size: Constants.medium_icon_size,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 30.0),
                            child: Icon(
                              Icons.thumb_up,
                              size: Constants.medium_icon_size,
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
                    Container(
                      height: 200,
                      child: Stack(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Aakriti Always likes to fight with me. She accidentally wins over me with big margin on LUDO on Facebook."
                              "She is dumbhead,a real dumbhead, starts fighting with no reason and she "
                              "herself tells me to stop talking because we end of fighting everytime"
                              "These days when i try to explain she tries to skip, that's how it's going these days.Thank your for reading . Have a nice"
                              "Day.Shit i have to write more to fill up the space. Now it's done,woaaaah!!!",
                              textAlign: TextAlign.justify,
                              style: TextStyle(
                                letterSpacing: 0.5,
                                color: Colors.black54,
                                fontStyle: FontStyle.normal,
                              ),
                            ),
                          ),
                          Positioned(
                            top: height * 0.229,
                            child: Container(
                              width: width,
                              child: FlatButton(
                                  onPressed: () {},
                                  color: Colors.lightBlueAccent,
                                  child: Text(
                                    "View In Full Screen",
                                  )),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ));
  }

}

