import 'package:flutter/material.dart';
import 'app_drawer.dart';

class HowToPlayPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Arka plan rengi siyah
      drawer: AppDrawer(), // Sol menü çekmecesi
      body: SafeArea(
        // Güvenli bölge içinde içerik oluşturuluyor
        child: Column(
          children: [
            // Üst başlık ve menü simgesi
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [
                  Builder(
                    builder: (context) => IconButton(
                      icon: Icon(Icons.menu, color: Colors.white), // Menü ikonu
                      onPressed: () => Scaffold.of(context).openDrawer(), // Menüyü açar
                    ),
                  ),
                  const SizedBox(width: 8), // İkon ile metin arası boşluk
                  Expanded(
                    child: Text(
                      'Nasıl Oynanır?', // Başlık
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.lightBlueAccent,
                      ),
                      textAlign: TextAlign.center, // Ortalanmış metin
                    ),
                  ),
                ],
              ),
            ),
            // Açıklamaların yer aldığı scroll alanı
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildStep("🎯 Amaç", "Rakibinden daha fazla kutu kapatmak."),
                    _buildStep("👆 Oynanış", "Oyuncular sırayla iki nokta arasında bir çizgi çizer."),
                    _buildStep("🧠 Strateji", "Bir kutunun dört kenarı kapandığında kutu kapanır ve son çizen oyuncuya puan kazandırır."),
                    _buildStep("💥 Devam", "Kutu kapanırsa oyuncu tekrar oynar."),
                    _buildStep("🏁 Bitiş", "Tüm kutular kapanınca oyun biter, en çok kutuya sahip oyuncu kazanır."),
                    const SizedBox(height: 20), // Boşluk
                    Center(
                      child: Text(
                        "İyi şanslar!", // Motivasyon mesajı
                        style: TextStyle(
                          color: Colors.pinkAccent,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Her bir adımı oluşturan yardımcı fonksiyon
  Widget _buildStep(String title, String desc) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title, // Başlık kısmı
            style: TextStyle(
              color: Colors.lightBlueAccent,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 6), // Başlık ile açıklama arası boşluk
          Text(
            desc, // Açıklama metni
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
        ],
      ),
    );
  }
}
