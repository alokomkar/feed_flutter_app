import 'package:feed_flutter_app/ui/screens/home_screen.dart';
import 'package:feed_flutter_app/ui/screens/login.dart';
import 'package:feed_flutter_app/ui/theme.dart';
import 'package:flutter/material.dart';

class FeedApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Social Feed',
      theme: buildTheme(),
      routes: {
        // If you're using navigation routes, Flutter needs a base route.
        // We're going to change this route once we're ready with
        // implementation of HomeScreen.
        '/': (context) => HomeScreen(),
        '/login': (context) => LoginScreen(),
      },
    );
  }

}