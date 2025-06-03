import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> saveScoreToSupabase(String score) async {
  final user = Supabase.instance.client.auth.currentUser;

  if (user == null) {
    print("Giriş yapan kullanıcı yok!");
    return;
  }

  final response = await Supabase.instance.client.from('scores').insert({
    'user_id': user.id,
    'score': score,
    'created_at': DateTime.now().toIso8601String(),
  });

  if (response == null) {
    print("Supabase: Skor başarıyla kaydedildi");
  } else {
    print("Supabase Hatası: $response");
  }
}
