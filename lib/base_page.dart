// Flutter'ın temel materyal bileşenleri kullanılıyor
import 'package:flutter/material.dart';

// Uygulamadaki ortak yan menü (drawer) bileşeni import ediliyor
import 'app_drawer.dart'; // drawer dosyanın yolu doğru olmalı

// BasePage, uygulamada tekrar eden sayfa yapısı için temel bir şablondur
class BasePage extends StatelessWidget {
  final String title;   // Sayfanın başlık metni
  final Widget content; // Sayfanın içeriğini temsil eden widget (gövde kısmı)

  // BasePage yapıcısı: başlık ve içerik zorunlu parametre olarak verilir
  const BasePage({
    Key? key,
    required this.title,
    required this.content,
  }) : super(key: key); // üst sınıfa key gönderilir

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Uygulamanın üst barı (başlık çubuğu)
      appBar: AppBar(
        title: Text(
          title, // Başlık olarak dışarıdan alınan değer kullanılır
          style: const TextStyle(
            color: Colors.white,          // Başlık yazısı beyaz
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.black, // AppBar'ın arka plan rengi siyah
        iconTheme: const IconThemeData(color: Colors.white), // Menü ikonu (hamburger) beyaz
      ),

      // Sayfanın sol menüsü (Drawer)
      drawer: const AppDrawer(), // Her sayfada sabit olarak kullanılan Drawer

      // Sayfanın arka plan rengi siyah
      backgroundColor: Colors.black,

      // Sayfanın ana içeriği
      body: Padding(
        padding: const EdgeInsets.all(16.0), // Kenarlardan boşluk
        child: content, // Dışarıdan gönderilen özel içerik burada gösterilir
      ),
    );
  }
}
