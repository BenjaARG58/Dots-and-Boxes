// Supabase Flutter paketi
import 'package:supabase_flutter/supabase_flutter.dart';

/// Skoru Supabase veritabanına kaydeden fonksiyon
Future<void> saveScoreToSupabase(String score) async {
  // Giriş yapan kullanıcı alınır
  final user = Supabase.instance.client.auth.currentUser;

  // Eğer kullanıcı giriş yapmamışsa işlem iptal edilir
  if (user == null) {
    print("Giriş yapan kullanıcı yok!");
    return;
  }

  // Supabase 'scores' tablosuna yeni bir kayıt eklenir
  final response = await Supabase.instance.client.from('scores').insert({
    'user_id': user.id,                            // Kullanıcının UID'si
    'score': score,                                // Skor metni (örneğin "4-2")
    'created_at': DateTime.now().toIso8601String() // ISO formatlı tarih
  });

  // Supabase Flutter client `insert()` metodu void döner, ancak hata olmadığını `postgrestError` ile kontrol edebilirsin.
  // Şu haliyle response null değil, her zaman bir `PostgrestResponse` olur. Bu nedenle kontrol eksik gibi.

  if (response == null) {
    print("Supabase: Skor başarıyla kaydedildi");
  } else {
    print("Supabase Hatası: $response");
  }
}
