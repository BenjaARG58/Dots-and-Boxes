import 'package:flutter/material.dart';
import 'login_page.dart' as login;
import 'game_page.dart' as home;
import 'how_to_play_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => login.LoginPage(),
        '/game': (context) => home.HomePage(),
        '/howtoplay': (context) => HowToPlayPage(),
      },
    );
  }
}
