import 'package:flutter/material.dart';
import 'login_page.dart' as login;
import 'home_page.dart' as home;
import 'game_page.dart' as game;
import 'profile_page.dart' as profile;
import 'package:untitled/ScoreListPage.dart' as score;
import 'how_to_play_page.dart';
import 'package:firebase_core/firebase_core.dart';

import 'firebase_options.dart';
import 'package:flutter/foundation.dart' show kIsWeb;



import 'package:supabase_flutter/supabase_flutter.dart';
import 'firebase_options.dart'; // Firebase için otomatik oluşturulmuş dosya

import 'login_page.dart'; // Örnek giriş ekranı

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  WidgetsFlutterBinding.ensureInitialized();

  if (kIsWeb) {
    await Firebase.initializeApp(options: webOptions);
  } else {
    await Firebase.initializeApp();
  }

  // Supabase başlat
  await Supabase.initialize(
    url: 'https://tdpoltfdoabfktuzucxo.supabase.co',          // Supabase URL
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InRkcG9sdGZkb2FiZmt0dXp1Y3hvIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDg5MTM5MTUsImV4cCI6MjA2NDQ4OTkxNX0.f6F2uLo75n2OlQEBTZXU6Sir9mlP4BDZUGOJyLXoAGc',                // Supabase Anon Key
  );

  runApp(MyApp());
}




class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => login.LoginPage(),
        '/home': (context) => home.HomePage(),
        '/scorelist': (context) => score.ScoreListPage(),
        '/profile': (context) => profile.ProfilePage(),
        '/game': (context) => game.GamePage(),
        '/howtoplay': (context) => HowToPlayPage(),
      },
    );
  }
}
