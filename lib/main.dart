import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swasthyapala_flutter/stmgmt/comments.dart';
import 'package:swasthyapala_flutter/uis/blog_posts_screen.dart';
import 'package:swasthyapala_flutter/uis/comments.dart';
import 'package:swasthyapala_flutter/uis/home_screen.dart';
import 'package:swasthyapala_flutter/uis/login_screen.dart';
import 'package:swasthyapala_flutter/uis/post_detail.dart';
import 'package:swasthyapala_flutter/uis/posts.dart';
import 'package:swasthyapala_flutter/uis/signup_screen.dart';
import 'package:swasthyapala_flutter/uis/splash_screen.dart';
import 'package:swasthyapala_flutter/stmgmt/user.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
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
    );
  }
}
