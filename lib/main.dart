import 'dart:ui';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swasthyapala_flutter/stmgmt/post.dart';
import 'package:swasthyapala_flutter/uis/splash_screen.dart';
import 'package:swasthyapala_flutter/uis/views/post/add_post.dart';
import 'package:swasthyapala_flutter/uis/views/post/posts.dart';
import 'package:swasthyapala_flutter/uis/views/user/profile.dart';

void main() {
  runApp(MyApp());
}

final TextStyle kStyle = TextStyle(
  fontSize: 16,
  color: Colors.white,
  decoration: TextDecoration.none,
);

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SplashScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _page = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: CurvedNavigationBar(
          backgroundColor: Colors.greenAccent,
          index: _page,
          animationDuration: Duration(milliseconds: 300),
          items: <Widget>[
            Icon(Icons.add, size: 30),
            Icon(Icons.list, size: 30),
            Icon(Icons.person, size: 30),
            Icon(
              Icons.group,
              size: 30,
            ),
          ],
          onTap: (index) {
            //Handle button tap
            setState(() {
              _page = index;
            });
          },
        ),
        body: _switchPage());
  }

  Widget _switchPage() {
    switch (_page) {
      case 0:
        return AddPostBtn();
        break;
      case 1:
        return ChangeNotifierProvider(
            create: (_) => PostBloc(), child: PostList());
        break;
      case 2:
        return UserProfile();
        break;
      default:
        return PostList();
    }
  }
}
/*return MultiProvider(
      providers: [
        MultiProvider(providers: [
          ChangeNotifierProvider(create: (_) => User()),
          ChangeNotifierProvider(
            create: (_) => CommentsList(),
          )
        ])
      ],
      child: MaterialApp(
        initialRoute: PostDetail.routeName,
        routes: {
          PostDetail.routeName: (context) => PostDetail(),
          PostList.routeName: (context) => PostList(),
          SplashScreen.routeName: (context) => SplashScreen(),
          HomeScreen.routeName: (context) => HomeScreen(),
          LoginScreen.routeName: (context) => LoginScreen(),
          SignUpScreen.routeName: (context) => SignUpScreen(),
          BlogPosts.routeName: (context) => BlogPosts(),
          PostCommentBox.routeName: (context) => PostCommentBox()
        },
      ),
//    );*/

//
//class Screen1 extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      body: Container(
//        child: _buildBuyTicketButton(),
//      ),
//    );
//  }
//
//  _buildBuyTicketButton() {
//    return Container(
//      alignment: Alignment.bottomCenter,
//      margin: EdgeInsets.all(8),
//      child: BuyButton(),
//    );
//  }
//}
//
///*class Screen2 extends StatelessWidget {
//  //providing the circular expansion of the widget by
//  //modifying the createRectTween property.
//  static RectTween _createRectTween(Rect begin, Rect end) {
//    return CircularRectTween(begin: begin, end: end);
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      body: Hero(
//        tag: 'blackBox',
//        createRectTween: _createRectTween,
//        child: Container(
//          color: Colors.black,
//          alignment: Alignment.center,
//          child: Text(
//            'SCREEN 2',
//            style: kStyle,
//          ),
//        ),
//      ),
//    );
//  }
//}*//*
//
//class CircularRectTween extends RectTween {
//  CircularRectTween({Rect begin, Rect end}) : super(begin: begin, end: end);
//
//  @override
//  Rect lerp(double t) {
//    //to being fading from center of the button from hero animation
//    double startWidthCenter = begin.left + (begin.width / 2);
//    double startHeightCenter = begin.top + (begin.height / 2);
//    final double width = lerpDouble(begin.width, end.width, t);
//
//    return Rect.fromCircle(
//        center: Offset(startWidthCenter, startHeightCenter),
//        radius: width * 1.7);
//  }
//}
//*/
//class BuyButton extends StatefulWidget {
//  @override
//  _BuyButtonState createState() => _BuyButtonState();
//}
//
//class _BuyButtonState extends State<BuyButton>
//    with SingleTickerProviderStateMixin {
//  Animation rAnimation;
//  Animation wAnimation;
//  AnimationController _controller;
//
//  String _buttonText = 'BUY TICKET';
//
//  @override
//  void initState() {
//    super.initState();
//    _controller =
//        AnimationController(duration: Duration(milliseconds: 500), vsync: this)
//          ..addListener(() {
//            setState(() {});
//          })
//          ..addStatusListener((status) {
//            if (status == AnimationStatus.completed) {
//              Navigator.push(
//                  context, MaterialPageRoute(builder: (context) => Screen2()));
//            }
//          });
//
//    rAnimation = Tween<double>(begin: 10, end: 25)
//        .animate(CurvedAnimation(parent: _controller, curve: Curves.linear));
//    wAnimation = Tween<double>(begin: 250, end: 40)
//        .animate(CurvedAnimation(parent: _controller, curve: Curves.linear));
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    timeDilation=3.0;
//    return Material(
//      child: GestureDetector(
//        onTap: () {
//          setState(() {
//            _buttonText = '';
//            _controller.forward();
//          });
//        },
//        child: Hero(
//          tag: 'blackBox',
//          flightShuttleBuilder: (
//            BuildContext flightContext,
//            Animation<double> animation,
//            HeroFlightDirection flightDirection,
//            BuildContext fromHeroContext,
//            BuildContext toHeroContext,
//          ) {
//            return Container(
//              decoration: BoxDecoration(
//                color: Colors.black,
//                shape: BoxShape.circle,
//              ),
//            );
//          },
//          child: Container(
//            width: wAnimation.value,
//            decoration: BoxDecoration(
//              color: Colors.black,
//              borderRadius: BorderRadius.circular(rAnimation.value),
//            ),
//            padding: EdgeInsets.symmetric(vertical: 10),
//            child: Text(
//              _buttonText,
//              textAlign: TextAlign.center,
//              style: kStyle,
//            ),
//          ),
//        ),
//      ),
//    );
//  }
///*
//  static RectTween _createRectTween(Rect begin, Rect end) {
//    return CircularRectTween(begin: begin, end: end);
//  }
//}*/
//
//class Heroes extends StatelessWidget {
//  final heroList = [
//    MyHero(
//        name: 'first slider ever',
//        age: 22,
//        isActive: true,
//        image: 'images/slider1.jpeg'),
//    MyHero(
//        name: 'cover photo',
//        age: 22,
//        isActive: true,
//        image: 'images/cover.jpeg'),
//    MyHero(
//        name: 'mohan k. dhakal',
//        age: 22,
//        isActive: true,
//        image: 'images/mohan.jpg')
//  ];
//
//  @override
//  Widget build(BuildContext context) {
//    return Container(
//      child: ListView.builder(
//        itemBuilder: (context, index) {
//          final newHero = heroList.elementAt(index);
//          return InkWell(
//            onTap: () {},
//            child: AHero(
//              name: newHero.name,
//              image: newHero.image,
//              onTap: () {
//                Navigator.push(
//                    context,
//                    MaterialPageRoute(
//                        builder: (context) => HeroDetail(
//                              name: newHero.name,
//                              image: newHero.image,
//                              age: newHero.image,
//                              isActive: newHero.isActive,
//                            )));
//              },
//            ),
//          );
//        },
//        itemCount: heroList.length,
//      ),
//    );
//  }
//}
//
//class HeroDetail extends StatelessWidget {
//  final image;
//  final name;
//  final age;
//  final isActive;
//
//  HeroDetail({this.image, this.name, this.age, this.isActive});
//
//  var width;
//
//  @override
//  Widget build(BuildContext context) {
//    width = MediaQuery.of(context).size.width;
//    return Scaffold(
//      appBar: AppBar(
//        title: Text('detail of the hero'),
//      ),
//      body: Column(
//        mainAxisAlignment: MainAxisAlignment.center,
//        children: <Widget>[
//          AHero(
//            name: this.name,
//            image: this.image,
//            onTap: () {
//              Navigator.pop(context);
//            },
//          ),
//          Text('my age is $age'),
//          Text('and i am  $isActive')
//        ],
//      ),
//    );
//  }
//}
//
//class AHero extends StatelessWidget {
//  final name;
//  final image;
//  VoidCallback onTap;
//
//  AHero({this.name, this.image, this.onTap});
//
//  var width;
//
//  @override
//  Widget build(BuildContext context) {
//    width = MediaQuery.of(context).size.width;
//    return Column(
//      children: <Widget>[
//        Padding(
//          padding: EdgeInsets.only(left: width * 0.1),
//          child: Hero(
//            tag: image,
//            transitionOnUserGestures: true, //for ios back swipe
//            child: Material(
//              child: InkWell(
//                onTap: onTap,
//                child: Image.asset(
//                  image,
//                  height: 50,
//                  width: width * 0.8,
//                ),
//              ),
//            ),
//            placeholderBuilder: (context, size, widget) {
//              return Container(
//                height: 50,
//                width: 50,
//                child: CircularProgressIndicator(),
//              );
//            },
//          ),
//        ),
//        Padding(
//          padding: const EdgeInsets.all(8.0),
//          child: Text(name),
//        )
//      ],
//    );
//  }
//}
//
//class MyHero {
//  final name;
//  final age;
//  final isActive;
//  final image;
//
//  MyHero({this.name, this.age, this.isActive, this.image});
//}
//
//class HeroAnimation extends StatelessWidget {
//  Widget build(BuildContext context) {
//     timeDilation = 5.0; // 1.0 means normal animation speed.
//
//    return Scaffold(
//      appBar: AppBar(
//        title: const Text('Basic Hero Animation'),
//      ),
//      body: Center(
//        child: PhotoHero(
//          photo: 'images/logo.png',
//          width: 300.0,
//          onTap: () {
//            Navigator.of(context)
//                .push(MaterialPageRoute<void>(builder: (BuildContext context) {
//              return Scaffold(
//                appBar: AppBar(
//                  title: const Text('Flippers Page'),
//                ),
//                body: Container(
//                  // The blue background emphasizes that it's a new route.
//                  color: Colors.lightBlueAccent,
//                  padding: const EdgeInsets.all(16.0),
//                  alignment: Alignment.topLeft,
//                  child: PhotoHero(
//                    photo: 'images/logo.png',
//                    width: 100.0,
//                    onTap: () {
//                      Navigator.of(context).pop();
//                    },
//                  ),
//                ),
//              );
//            }));
//          },
//        ),
//      ),
//    );
//  }
//}
//
//class PhotoHero extends StatelessWidget {
//  const PhotoHero({Key key, this.photo, this.onTap, this.width})
//      : super(key: key);
//
//  final String photo;
//  final VoidCallback onTap;
//  final double width;
//
//  Widget build(BuildContext context) {
//    return SizedBox(
//      width: width,
//      child: Material(
//        color: Colors.transparent,
//        child: InkWell(
//          onTap: onTap,
//          child: Image.asset(
//            photo,
//            fit: BoxFit.contain,
//          ),
//        ),
//      ),
//    );
//  }
//}
