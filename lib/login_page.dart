import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'register_page.dart';
import 'home_page.dart';

// Hata mesajlarını Türkçeleştiren fonksiyon
String firebaseErrorToTurkish(String code) {
  switch (code) {
    case 'invalid-email':
      return 'Geçersiz e-posta adresi.';
    case 'user-disabled':
      return 'Bu kullanıcı devre dışı bırakılmış.';
    case 'user-not-found':
      return 'Bu e-posta ile kayıtlı bir kullanıcı bulunamadı.';
    case 'wrong-password':
      return 'Şifre hatalı.';
    case 'email-already-in-use':
      return 'Bu e-posta adresi zaten kullanımda.';
    case 'operation-not-allowed':
      return 'Bu işlem şu anda izin verilmiyor.';
    case 'weak-password':
      return 'Şifre çok zayıf. Lütfen daha güçlü bir şifre girin.';
    case 'too-many-requests':
      return 'Çok fazla deneme yapıldı. Lütfen daha sonra tekrar deneyin.';
    default:
      return 'Bir hata oluştu. Lütfen tekrar deneyin.';
  }
}


// Google ile Giriş Fonksiyonu
Future<UserCredential?> signInWithGoogle() async {
  try {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    if (googleUser == null) return null;

    final GoogleSignInAuthentication googleAuth =
    await googleUser.authentication;

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

// GitHub ile Giriş Fonksiyonu
Future<UserCredential?> signInWithGitHub() async {
  try {
    GithubAuthProvider githubProvider = GithubAuthProvider();
    return await FirebaseAuth.instance.signInWithPopup(githubProvider);
  } catch (e) {
    print('GitHub Giriş Hatası: $e');
    return null;
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool isLoading = false;
  String errorMessage = '';

  Future<void> loginUser() async {
    final email = emailController.text.trim();
    final password = passwordController.text;

    setState(() {
      isLoading = true;
      errorMessage = '';
    });

    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = firebaseErrorToTurkish(e.code);

      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Giriş Yap',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),

                  ),

                  const SizedBox(height: 40),

                  TextField(

                    controller: emailController,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      labelText: 'E-posta',
                      labelStyle: TextStyle(color: Colors.white70),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white24),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blueAccent),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  TextField(
                    controller: passwordController,
                    obscureText: true,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      labelText: 'Şifre',
                      labelStyle: TextStyle(color: Colors.white70),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white24),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blueAccent),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  if (errorMessage.isNotEmpty)
                    Text(
                      errorMessage,
                      style: TextStyle(color: Colors.redAccent),
                    ),

                  const SizedBox(height: 20),

                  isLoading
                      ? CircularProgressIndicator()
                      : ElevatedButton(
                    onPressed: loginUser,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      padding: EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      minimumSize: Size(double.infinity, 50),
                    ),
                    child: Text(
                      'Giriş Yap',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),


                  const SizedBox(height: 16),
                  const SizedBox(height: 16),

                  Row(
                    children: [
                      Expanded(
                        child: Divider(
                          color: Colors.white24,
                          thickness: 1,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          'veya',
                          style: TextStyle(color: Colors.white54),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          color: Colors.white24,
                          thickness: 1,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),


                  OutlinedButton.icon(
                    icon: Icon(Icons.g_mobiledata, color: Colors.red),
                    label: Text(
                      'Google ile Giriş Yap',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () async {
                      final userCred = await signInWithGoogle();
                      if (userCred != null) {
                        Navigator.pushReplacementNamed(context, '/home');
                      }
                    },
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: Colors.red),
                      padding: EdgeInsets.symmetric(vertical: 14),
                      minimumSize: Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),

                  OutlinedButton.icon(
                    icon: Icon(Icons.code, color: Colors.white),
                    label: Text(
                      'GitHub ile Giriş Yap',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () async {
                      final userCred = await signInWithGitHub();
                      if (userCred != null) {
                        Navigator.pushReplacementNamed(context, '/home');
                      }
                    },
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: Colors.white24),
                      padding: EdgeInsets.symmetric(vertical: 14),
                      minimumSize: Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),

                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RegisterPage()),
                      );
                    },
                    child: Text(
                      'Hesabın yok mu? Kayıt Ol',
                      style: TextStyle(color: Colors.white38),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
