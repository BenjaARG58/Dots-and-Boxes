import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Arka plan rengi siyah olarak ayarlandı
      body: SafeArea(
        // Güvenli bölge içinde sayfa oluşturuluyor (çentik, status bar gibi bölgelerden kaçınmak için)
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0), // Yatay boşluk
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center, // Dikeyde ortala
              children: [
                // Logo resmi
                ClipRRect(
                  borderRadius: BorderRadius.circular(100), // Yuvarlak kenarlar
                  child: Image.network(
                    'https://i.imgur.com/1hwwXl0.png', // Logo URL'si
                    width: 120,
                    height: 120,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(height: 30), // Boşluk

                // ANİMASYONLU "KUTU KAPMACA" YAZISI
                AnimatedTextKit(
                  animatedTexts: [
                    ColorizeAnimatedText(
                      'KUTU KAPMACA', // Gösterilecek yazı
                      textStyle: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                      colors: [
                        Colors.pinkAccent, // Renk geçişleri
                        Colors.lightBlueAccent,
                      ],
                      speed: Duration(milliseconds: 400), // Animasyon hızı
                    ),
                  ],
                  totalRepeatCount: 999, // Sürekli tekrar
                  isRepeatingAnimation: true,
                ),

                SizedBox(height: 50), // Boşluk

                // Yeni Oyun Butonu
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.pinkAccent, // Buton rengi
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/game'); // Oyun sayfasına geçiş
                  },
                  child: Text(
                    'Yeni Oyun',
                    style: TextStyle(fontSize: 18, color: Colors.white), // Yazı stili
                  ),
                ),
                SizedBox(height: 20), // Boşluk

                // Nasıl Oynanır Butonu
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.lightBlueAccent, // Buton rengi
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/howtoplay'); // Nasıl Oynanır sayfasına geçiş
                  },
                  child: Text(
                    'Nasıl Oynanır',
                    style: TextStyle(fontSize: 18, color: Colors.white), // Yazı stili
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
