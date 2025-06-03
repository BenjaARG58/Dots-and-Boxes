// firebase_options.dart

// Firebase SDK'nın çekirdeği import edilir.
// Bu paket, Firebase ile bağlantı kurmamıza ve yapılandırmamıza olanak sağlar.
import 'package:firebase_core/firebase_core.dart';

// Web uygulaması için Firebase yapılandırma ayarları burada tanımlanır.
// Bu ayarlar, Firebase Console üzerinden alınır ve uygulamanın Firebase hizmetlerine bağlanmasını sağlar.
const FirebaseOptions webOptions = FirebaseOptions(
  apiKey: "AIzaSyBQ0b0U3rE1ZI9jxyZ-6i1MPhxFReQ9BVY",
  // Uygulamanın Firebase API anahtarıdır. Kimlik doğrulama ve erişim izni sağlar.

  authDomain: "mobilfinal-68f71.firebaseapp.com",
  // Web'de kimlik doğrulama işlemleri için kullanılan alan adıdır.

  projectId: "mobilfinal-68f71",
  // Firebase projesinin benzersiz kimliğidir.

  storageBucket: "mobilfinal-68f71.firebasestorage.app",
  // Firebase Storage (dosya yükleme vb.) için kullanılan bucket URL’sidir.

  messagingSenderId: "279819232706",
  // Firebase Cloud Messaging (bildirim gönderme) servisinde kullanılan gönderen kimliğidir.

  appId: "1:279819232706:android:1ccf666299228d4930625b",
  // Uygulamanın benzersiz Firebase kimliğidir. Genellikle platforma özel olarak verilir.
);
