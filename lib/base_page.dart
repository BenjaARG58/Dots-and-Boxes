import 'package:flutter/material.dart';
import 'app_drawer.dart'; // drawer dosyanın yolu doğru olmalı

class BasePage extends StatelessWidget {
  final String title;
  final Widget content;

  const BasePage({
    Key? key,
    required this.title,
    required this.content,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          title,
          style: const TextStyle(
            color: Colors.white,          // Başlık rengi beyaz
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white), // Menü ikonu beyaz
      ),
      drawer: const AppDrawer(),
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: content,
      ),
    );
  }
}
