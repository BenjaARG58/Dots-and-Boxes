import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'app_drawer.dart';

class ScoreListPage extends StatefulWidget {
  const ScoreListPage({super.key});

  @override
  State<ScoreListPage> createState() => _ScoreListPageState();
}

class _ScoreListPageState extends State<ScoreListPage> {
  late final SupabaseClient supabase;
  List<dynamic> scores = [];
  bool isLoading = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    supabase = Supabase.instance.client;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    fetchScores();
  }

  Future<void> fetchScores() async {
    try {
      final user = FirebaseAuth.instance.currentUser;

      if (user == null) {
        setState(() {
          errorMessage = "Kullanıcı giriş yapmamış!";
          isLoading = false;
        });
        return;
      }

      final response = await supabase
          .from('scores')
          .select('score_text, created_at')
          .eq('user_id', user.uid)
          .order('created_at', ascending: false);

      setState(() {
        scores = response;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        errorMessage = "Veriler alınırken hata oluştu: $e";
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text('Skorlarım', style: TextStyle(color: Colors.white)),
        elevation: 1,
      ),
      drawer: const AppDrawer(),
      backgroundColor: Colors.black,
      body: isLoading
          ? const Center(child: CircularProgressIndicator(color: Colors.white))
          : errorMessage != null
          ? Center(
          child: Text(errorMessage!,
              style: const TextStyle(color: Colors.white)))
          : scores.isEmpty
          ? const Center(
        child: Text("Henüz skor yok.",
            style: TextStyle(color: Colors.white)),
      )
          : ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: scores.length,
        itemBuilder: (context, index) {
          final score = scores[index];
          final date = DateTime.parse(score['created_at']);
          final formattedDate =
          DateFormat('dd.MM.yyyy HH:mm').format(date);

          final scoreText = score['score_text'] as String;
          final parts = scoreText.split('-');
          final blue = parts.length > 0 ? parts[0] : '?';
          final pink = parts.length > 1 ? parts[1] : '?';

          return Card(
            color: Colors.grey[900],
            elevation: 3,
            margin: const EdgeInsets.only(bottom: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  vertical: 12, horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            const Text(
                              "Mavi Takım",
                              style: TextStyle(
                                color: Colors.lightBlueAccent,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              blue,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          children: [
                            const Text(
                              "Pembe Takım",
                              style: TextStyle(
                                color: Colors.pinkAccent,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              pink,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Tarih: $formattedDate',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white60,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
