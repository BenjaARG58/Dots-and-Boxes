// Gerekli Flutter ve diğer paketlerin içe aktarımı
import 'package:flutter/material.dart';
import 'login_page.dart' as login;
import 'home_page.dart' as home;
import 'game_page.dart' as game;
import 'profile_page.dart' as profile;
import 'package:untitled/ScoreListPage.dart' as score;
import 'how_to_play_page.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart'; // Firebase otomatik oluşturulan ayarları içerir
import 'package:flutter/foundation.dart' show kIsWeb;

import 'package:supabase_flutter/supabase_flutter.dart'; // Supabase bağlantısı için

void main() async {
  // Flutter motoru ve widget binding başlatılır
  WidgetsFlutterBinding.ensureInitialized();

  // Firebase, web'de ve mobilde farklı şekilde başlatılır
  if (kIsWeb) {
    await Firebase.initializeApp(options: webOptions); // Web için özel ayarlarla
  } else {
    await Firebase.initializeApp(); // Mobil için varsayılan ayarlarla
  }

  // Supabase servisi başlatılır (veritabanı gibi servisleri içerir)
  await Supabase.initialize(
    url: 'https://tdpoltfdoabfktuzucxo.supabase.co', // Projeye ait Supabase URL'si
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ...snip...', // Güvenlik anahtarı (anon erişim)
  );

  // Uygulama çalıştırılır
  runApp(MyApp());
}

/// Ana uygulama widget'ı
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Sağ üstte çıkan "debug" yazısını gizler

      // Uygulama ilk açıldığında gösterilecek sayfa
      initialRoute: '/',

      // Uygulama rotaları (sayfa yolları) tanımlanır
      routes: {
        '/': (context) => login.LoginPage(),        // Giriş ekranı
        '/home': (context) => home.HomePage(),      // Ana ekran
        '/scorelist': (context) => score.ScoreListPage(), // Skor listesi ekranı
        '/profile': (context) => profile.ProfilePage(),   // Profil ekranı
        '/game': (context) => game.GamePage(),      // Oyun ekranı
        '/howtoplay': (context) => HowToPlayPage(), // Nasıl oynanır ekranı
      },
    );
  }
}
