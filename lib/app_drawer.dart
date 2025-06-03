// Gerekli paketleri projeye dahil ediyoruz
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Firebase kullanıcı işlemleri için
import 'login_page.dart'; // Çıkış sonrası yönlendirme yapılacak giriş sayfası

// Sol menü (Drawer) yapısını temsil eden widget
class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.grey[900], // Drawer’ın genel arka plan rengi

      child: Column( // Drawer içeriği bir sütun şeklinde düzenleniyor
        children: [

          // Üstte yer alacak logo kısmı, özel başlık (header)
          DrawerHeader(
            margin: EdgeInsets.zero,
            padding: EdgeInsets.zero,
            decoration: BoxDecoration(color: Colors.grey[850]), // Koyu arka plan

            child: Center(
              // Logo URL'si bir future ile çekiliyor
              child: FutureBuilder<String>(
                future: _fetchLogoUrl(), // Logo URL'sini döndüren metod
                builder: (context, snapshot) {
                  // Logo yükleniyorsa göstergesi dönsün
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator(color: Colors.white);
                  }
                  // Hata varsa mesaj göster
                  else if (snapshot.hasError) {
                    return const Text('Logo yüklenemedi', style: TextStyle(color: Colors.white));
                  }
                  // Logo yüklendiyse göster
                  else {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(12), // Köşeleri yumuşat
                      child: Image.network(
                        snapshot.data!, // Logo URL’si
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover, // Görsel taşmasın
                      ),
                    );
                  }
                },
              ),
            ),
          ),

          // Menü seçeneklerini listeleyen kısım
          Expanded(
            child: ListView(
              children: [
                // Her bir satır bir menü seçeneğidir
                _buildDrawerItem(
                  context,
                  icon: Icons.grid_on, // İkon
                  label: 'Kare Kapmaca', // Görünecek yazı
                  route: '/game', // Gidilecek sayfa rotası
                ),
                _buildDrawerItem(
                  context,
                  icon: Icons.person,
                  label: 'Son Oyunlar',
                  route: '/scorelist',
                ),
                _buildDrawerItem(
                  context,
                  icon: Icons.lightbulb_outline,
                  label: 'Nasıl Oynanır',
                  route: '/howtoplay',
                ),
                _buildDrawerItem(
                  context,
                  icon: Icons.person,
                  label: 'Profil',
                  route: '/profile',
                ),
              ],
            ),
          ),

          // Menü altına çizgi çizilir (görsel ayrım için)
          const Divider(color: Colors.white24),

          // Çıkış yap butonu
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.redAccent), // Sol tarafta çıkış ikonu
            title: const Text(
              'Çıkış Yap',
              style: TextStyle(color: Colors.white),
            ),
            onTap: () async {
              // Firebase oturumunu kapat
              await FirebaseAuth.instance.signOut();

              // Tüm geçmiş sayfaları kapat ve giriş sayfasına yönlendir
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const LoginPage()),
                    (route) => false,
              );
            },
          ),

          // En alt köşeye telif benzeri açıklama
          const Padding(
            padding: EdgeInsets.all(12.0),
            child: Text(
              '© Berşan Kurtcephe',
              style: TextStyle(color: Colors.white54, fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }

  // Menü öğesi oluşturan yardımcı fonksiyon
  Widget _buildDrawerItem(BuildContext context,
      {required IconData icon, required String label, required String route}) {
    return ListTile(
      leading: Icon(icon, color: Colors.lightBlueAccent), // Sol ikon
      title: Text(
        label, // Menüde gösterilecek yazı
        style: const TextStyle(color: Colors.white, fontSize: 16),
      ),
      hoverColor: Colors.lightBlueAccent.withOpacity(0.1), // Üzerine gelince hafif renk
      onTap: () {
        // Yeni sayfaya geçiş yapılır (önceki sayfayı değiştirir)
        Navigator.pushReplacementNamed(context, route);
      },
    );
  }

  // Logo URL’sini simüle eden bir fonksiyon (örnek olarak gecikmeli bir URL dönüyor)
  Future<String> _fetchLogoUrl() async {
    await Future.delayed(const Duration(milliseconds: 500)); // 0.5 saniyelik bekleme
    return 'https://i.imgur.com/1hwwXl0.png'; // Dönülecek görsel URL'si
  }
}
