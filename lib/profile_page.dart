// Firebase ve Flutter kütüphanelerinin içe aktarımı
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// Sayfa düzeni için temel bileşenler
import 'base_page.dart';
import 'login_page.dart';

/// Kullanıcının profil sayfasını gösteren stateless widget
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  /// Giriş yapan kullanıcının verilerini Firestore'dan çeker
  Future<Map<String, dynamic>?> _getUserData() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return null; // Kullanıcı oturum açmamışsa

    // 'users' koleksiyonundan kullanıcıya ait dökümanı getir
    final doc = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get();

    // Döküman varsa verileri döndür, yoksa null
    return doc.exists ? doc.data() : null;
  }

  @override
  Widget build(BuildContext context) {
    // Veriyi beklemek için FutureBuilder kullanılır
    return FutureBuilder<Map<String, dynamic>?>(
      future: _getUserData(),
      builder: (context, snapshot) {
        // Veri henüz gelmemişse yükleme animasyonu göster
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const BasePage(
            title: 'Profil',
            content: Center(child: CircularProgressIndicator()),
          );
        }

        // Veri gelmiş ama boşsa, kullanıcı verisi yok mesajı göster
        if (!snapshot.hasData || snapshot.data == null) {
          return const BasePage(
            title: 'Profil',
            content: Center(
              child: Text(
                'Kullanıcı verisi bulunamadı',
                style: TextStyle(color: Colors.white),
              ),
            ),
          );
        }

        // Veri başarıyla alınmışsa, ekranda detayları göster
        final data = snapshot.data!;
        return BasePage(
          title: 'Profil',
          content: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Kullanıcı bilgileri kutucukları
                  _infoTile("E-posta", data['email'] ?? '-'),
                  _infoTile("Doğum Tarihi", data['birthdate'] ?? '-'),
                  _infoTile("Doğum Yeri", data['birthplace'] ?? '-'),
                  _infoTile("Yaşadığı İl", data['city'] ?? '-'),

                  const SizedBox(height: 30),
                  const Divider(color: Colors.white24),
                  const SizedBox(height: 20),

                  // Çıkış yap butonu
                  Center(
                    child: ElevatedButton.icon(
                      onPressed: () async {
                        // Firebase'den çıkış yapılır
                        await FirebaseAuth.instance.signOut();

                        // Giriş ekranına yönlendirme
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (_) => const LoginPage()),
                        );
                      },
                      icon: const Icon(Icons.logout, size: 22, color: Colors.white),
                      label: const Text(
                        'Çıkış Yap',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.redAccent.shade200,
                        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        elevation: 6,
                        shadowColor: Colors.redAccent.withOpacity(0.4),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  /// Kullanıcı bilgilerini etiket ve değer şeklinde gösteren yardımcı widget
  Widget _infoTile(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "$label: ",
            style: const TextStyle(color: Colors.lightBlueAccent, fontSize: 16),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
