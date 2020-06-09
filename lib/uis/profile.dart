import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:swasthyapala_flutter/util/constants.dart';

// ignore: must_be_immutable

class UserProfile extends StatelessWidget {
  Size size;

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 50.0),
        child: Container(
          width: size.width * 0.95,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 7,
                  blurRadius: 10,
                  offset: Offset(0, 3), // changes position of shadow
                )
              ]),
          child: Stack(
              fit: StackFit.expand,
              overflow: Overflow.visible,
              children: [
                Positioned(
                    top: size.width * (-0.07),
                    left: size.width * 0.40,
                    child: Container(
                        decoration: BoxDecoration(boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 1,
                            blurRadius: 40,
                          )
                        ]),
                        child: getImageAsset("images/mohan.jpg"))),
                Positioned(
                  top: size.height * 0.1,
                  left: size.width * 0.25,
                  child: Text(
                    "Mohan Kumar Dhakal",
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.deepPurple,
                      fontFamily: 'OpenSans',
                    ),
                  ),
                ),
                Positioned(
                  top: size.height * 0.15,
                  left: size.width * 0.30,
                  child: Text(
                    "Flutter Developer,Nepal ",
                    maxLines: 2,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black26,
                      fontFamily: 'OpenSans',
                    ),
                  ),
                ),
                Positioned(
                  width: size.width * 0.85,
                  top: size.height * 0.20,
                  left: size.width * 0.05,
                  child: Text(
                    "Hi,this is mohan ,a flutter enthusiat and currently lost in quarantine.",
                    maxLines: 10,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 16.0,
                        fontFamily: 'OpenSans',
                        color: Colors.deepPurple),
                  ),
                ),
                FollowMsgLink(size: size),
                LikesFollowCount(size: size),
                Positioned(
                  top: size.height * 0.51,
                  child: Container(
                    height: 10,
                    width: size.width * 0.95,
                    color: Colors.black.withOpacity(0.03),
                  ),
                ),
                followersList(),
                Positioned(
                  top: size.height * 0.73,
                  child: Container(
                    height: 10,
                    width: size.width * 0.95,
                    color: Colors.black.withOpacity(0.03),
                  ),
                ),
                Positioned(
                  width: size.width*0.4,
                  top:size.height*0.80,
                  left: size.width*0.30,
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                    onPressed: () => null,
                    elevation: 6,
                    child: Text(
                      "Visit Posts",
                      style: TextStyle(color: Colors.white),
                    ),
                    color: Colors.blue,
                  ),
                ),
              ]),
        ),
      ),
    );
  }

  Widget followersList() {
    return Padding(
      padding: EdgeInsets.only(
          top: size.height * 0.55, left: 5, right: 5, bottom: 5),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("followers"),
              Text(
                "view all",
                style: TextStyle(color: Colors.blue),
              ),
            ],
          ),
          SingleChildScrollView(
            padding: EdgeInsets.only(top: 10),
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                getFollower("images/mohan.jpg", "mohan"),
                getFollower("images/argentina.jpg", "argentina"),
                getFollower("images/messi.jpg", "messi"),
                getFollower("images/fc_barcelona.jpg", "barca"),
                getFollower("images/logo.png", "swasthyapala"),
                getFollower("images/aaki.jpg", "aakriti"),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget getImageAsset(String imageUri) {
    return ClipRRect(
      child: Image.asset(
        imageUri,
        fit: BoxFit.cover,
        height: 60,
        width: 60,
      ),
      borderRadius: BorderRadius.circular(34),
    );
  }

  Widget getFollower(String imageUri, String name) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(36),
              color: name=='mohan'?Colors.blue:Colors.black12,
              border: Border.all(width: 3, style: BorderStyle.none)),
          child: getImageAsset(imageUri),
        ),
        Text(name)
      ],
    );
  }
}

class LikesFollowCount extends StatelessWidget {
  const LikesFollowCount({
    Key key,
    @required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: size.height * 0.44),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Text(
                "877k",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: Constants.medium_font_size),
                textAlign: TextAlign.center,
              ),
              Text(
                "Followers",
                textAlign: TextAlign.center,
              ),
            ],
          ),
          Container(
            width: 1,
            color: Colors.black.withOpacity(0.5),
            height: 30,
          ),
          Column(
            children: [
              Text(
                "877k",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: Constants.medium_font_size),
                textAlign: TextAlign.center,
              ),
              Text(
                "Following",
                textAlign: TextAlign.center,
              ),
            ],
          ),
          Container(
            width: 1,
            color: Colors.black.withOpacity(0.5),
            height: 30,
          ),
          Column(
            children: [
              Text(
                "877k",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: Constants.medium_font_size),
                textAlign: TextAlign.center,
              ),
              Text(
                "Likes",
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class FollowMsgLink extends StatelessWidget {
  const FollowMsgLink({
    Key key,
    @required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: size.height * 0.32),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border(
                  top: BorderSide(
                    color: Colors.grey.withOpacity(0.3),
                  ),
                  left: BorderSide(
                    color: Colors.grey.withOpacity(0.3),
                  ),
                  bottom: BorderSide(
                    color: Colors.grey.withOpacity(0.3),
                  ),
                  right: BorderSide(
                    color: Colors.grey.withOpacity(0.3),
                  ),
                )),
            child: Icon(
              Icons.message,
              color: Colors.blue,
            ),
          ),
          Container(
            width: size.width*0.35,
            height: size.height*0.06,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
            child: RaisedButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              onPressed: () => null,
              elevation: 7,
              child: Text(
                "Follow",
                style: TextStyle(color: Colors.white),
              ),
              color: Colors.blue,
            ),
          ),
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border(
                  top: BorderSide(
                    color: Colors.grey.withOpacity(0.3),
                  ),
                  left: BorderSide(
                    color: Colors.grey.withOpacity(0.3),
                  ),
                  bottom: BorderSide(
                    color: Colors.grey.withOpacity(0.3),
                  ),
                  right: BorderSide(
                    color: Colors.grey.withOpacity(0.3),
                  ),
                )),
            child: Icon(
              Icons.share,
              color: Colors.blue,
            ),
          )
        ],
      ),
    );
  }
}
