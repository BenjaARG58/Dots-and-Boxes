import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'login_page.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.grey[900],
      child: Column(
        children: [
          DrawerHeader(
            margin: EdgeInsets.zero,
            padding: EdgeInsets.zero,
            decoration: BoxDecoration(color: Colors.grey[850]),
            child: Center(
              child: FutureBuilder<String>(
                future: _fetchLogoUrl(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator(color: Colors.white);
                  } else if (snapshot.hasError) {
                    return const Text('Logo yüklenemedi', style: TextStyle(color: Colors.white));
                  } else {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        snapshot.data!,
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                    );
                  }
                },
              ),
            ),
          ),

          Expanded(
            child: ListView(
              children: [
                _buildDrawerItem(
                  context,
                  icon: Icons.grid_on,
                  label: 'Kare Kapmaca',
                  route: '/game',
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

          const Divider(color: Colors.white24),

          ListTile(
            leading: const Icon(Icons.logout, color: Colors.redAccent),
            title: const Text(
              'Çıkış Yap',
              style: TextStyle(color: Colors.white),
            ),
            onTap: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const LoginPage()),
                    (route) => false,
              );
            },
          ),

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

  Widget _buildDrawerItem(BuildContext context,
      {required IconData icon, required String label, required String route}) {
    return ListTile(
      leading: Icon(icon, color: Colors.lightBlueAccent),
      title: Text(
        label,
        style: const TextStyle(color: Colors.white, fontSize: 16),
      ),
      hoverColor: Colors.lightBlueAccent.withOpacity(0.1),
      onTap: () {
        Navigator.pushReplacementNamed(context, route);
      },
    );
  }

  Future<String> _fetchLogoUrl() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return 'https://i.imgur.com/1hwwXl0.png';
  }
}
