// Gerekli paketlerin içe aktarımı
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'home_page.dart';

/// Firebase hata mesajlarını Türkçeleştiren yardımcı fonksiyon
String firebaseErrorToTurkish(String code) {
  switch (code) {
    case 'invalid-email': return 'Geçersiz e-posta adresi.';
    case 'user-disabled': return 'Bu kullanıcı devre dışı bırakılmış.';
    case 'user-not-found': return 'Kullanıcı bulunamadı.';
    case 'wrong-password': return 'Şifre hatalı.';
    case 'email-already-in-use': return 'Bu e-posta zaten kullanımda.';
    case 'operation-not-allowed': return 'Bu işlem izin verilmiyor.';
    case 'weak-password': return 'Şifre çok zayıf.';
    case 'too-many-requests': return 'Çok fazla deneme yapıldı.';
    default: return 'Bir hata oluştu.';
  }
}

/// Google hesabıyla giriş yapan fonksiyon
Future<UserCredential?> signInWithGoogle() async {
  try {
    final googleUser = await GoogleSignIn().signIn();
    if (googleUser == null) return null;

    final googleAuth = await googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    return await FirebaseAuth.instance.signInWithCredential(credential);
  } catch (e) {
    print('Google Giriş Hatası: $e');
    return null;
  }
}

/// GitHub hesabıyla giriş yapan fonksiyon
Future<UserCredential?> signInWithGitHub() async {
  try {
    GithubAuthProvider githubProvider = GithubAuthProvider();
    return await FirebaseAuth.instance.signInWithPopup(githubProvider);
  } catch (e) {
    print('GitHub Giriş Hatası: $e');
    return null;
  }
}

/// Kayıt ekranı
class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // Form verilerini tutmak için controller’lar
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final birthdateController = TextEditingController();
  final birthplaceController = TextEditingController();
  final cityController = TextEditingController();

  // Firebase kimlik doğrulama nesnesi
  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool isLoading = false;         // Yükleme durumu
  String errorMessage = '';       // Hata mesajı

  /// Kullanıcıyı e-posta/şifre ile kaydeden fonksiyon
  Future<void> registerUser() async {
    final email = emailController.text.trim();
    final password = passwordController.text;
    final birthdate = birthdateController.text.trim();
    final birthplace = birthplaceController.text.trim();
    final city = cityController.text.trim();

    setState(() {
      isLoading = true;
      errorMessage = '';
    });

    try {
      // Firebase Authentication ile kullanıcı oluşturulur
      final userCred = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Firestore veritabanına ek bilgiler kaydedilir
      await FirebaseFirestore.instance.collection('users').doc(userCred.user!.uid).set({
        'email': email,
        'birthdate': birthdate,
        'birthplace': birthplace,
        'city': city,
        'createdAt': Timestamp.now(),
      });

      // SharedPreferences ile kullanıcı bilgileri yerel olarak saklanır
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('uid', userCred.user!.uid);
      await prefs.setString('email', email);
      await prefs.setString('birthdate', birthdate);
      await prefs.setString('birthplace', birthplace);
      await prefs.setString('city', city);

      // Başarılı kayıt sonrası ana sayfaya yönlendirme
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    } on FirebaseAuthException catch (e) {
      // Hata olursa kullanıcıya mesaj gösterilir
      setState(() => errorMessage = firebaseErrorToTurkish(e.code));
    } finally {
      setState(() => isLoading = false);
    }
  }

  /// Google/GitHub gibi sosyal giriş butonları için ortak işlev
  void handleSocialLogin(Future<UserCredential?> Function() loginMethod) async {
    final userCred = await loginMethod();
    if (userCred != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    }
  }

  /// Ortak stil için form alanı widget’ı
  Widget buildTextField({required TextEditingController controller, required String label, bool obscure = false}) {
    return TextField(
      controller: controller,
      obscureText: obscure,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.white70),
        enabledBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.white24)),
        focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.blueAccent)),
      ),
    );
  }

  /// Arayüz
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(32),
          child: Column(
            children: [
              const SizedBox(height: 40),
              const Text('Kıyat Ol', // burada "Kayıt Ol" olmalı
                  style: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold)),
              const SizedBox(height: 30),

              // Form alanları
              buildTextField(controller: emailController, label: 'E-posta'),
              const SizedBox(height: 15),
              buildTextField(controller: passwordController, label: 'Şifre', obscure: true),
              const SizedBox(height: 15),
              buildTextField(controller: birthdateController, label: 'Doğum Tarihi (gg.aa.yyyy)'),
              const SizedBox(height: 15),
              buildTextField(controller: birthplaceController, label: 'Doğum Yeri'),
              const SizedBox(height: 15),
              buildTextField(controller: cityController, label: 'Yaşadığı İl'),

              const SizedBox(height: 20),

              // Hata varsa ekranda göster
              if (errorMessage.isNotEmpty)
                Text(errorMessage, style: const TextStyle(color: Colors.redAccent)),

              const SizedBox(height: 20),

              // Kayıt butonu ya da yükleme göstergesi
              isLoading
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                onPressed: registerUser,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  minimumSize: const Size(double.infinity, 50),
                ),
                child: const Text('Kıyat Ol', // burada da "Kayıt Ol" olmalı
                    style: TextStyle(color: Colors.white, fontSize: 16)),
              ),

              const SizedBox(height: 30),

              // "veya" ayıracı
              Row(
                children: const [
                  Expanded(child: Divider(color: Colors.white24)),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    child: Text('veya', style: TextStyle(color: Colors.white38)),
                  ),
                  Expanded(child: Divider(color: Colors.white24)),
                ],
              ),

              const SizedBox(height: 30),

              // Google ile kayıt
              OutlinedButton.icon(
                icon: const Icon(Icons.g_mobiledata, color: Colors.red),
                label: const Text('Google ile Kıyat Ol', style: TextStyle(color: Colors.white)),
                onPressed: () => handleSocialLogin(signInWithGoogle),
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Colors.red),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
              ),

              const SizedBox(height: 12),

              // GitHub ile kayıt
              OutlinedButton.icon(
                icon: const Icon(Icons.code, color: Colors.white),
                label: const Text('GitHub ile Kıyat Ol', style: TextStyle(color: Colors.white)),
                onPressed: () => handleSocialLogin(signInWithGitHub),
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Colors.white24),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
              ),

              // Girişe yönlendirme
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Zaten hesabın var mı? Giriş Yap', style: TextStyle(color: Colors.white38)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
