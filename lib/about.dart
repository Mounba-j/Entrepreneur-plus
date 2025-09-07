import 'package:flutter/material.dart';



class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Récupère la date et l'heure de compilation et ne garde que la partie date
    String buildDate = DateTime.now().toString().split(' ')[0];

    return Scaffold(
      appBar: AppBar(title: const Text('À Propos')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ... autres informations sur l'app ...
            const SizedBox(height: 20),
            Text('Version de l\'application : 1.0.0'),
            // Affiche la date de compilation
            Text('Dernière mise à jour : $buildDate'),
            Text('© 2025 Entrepreneur Plus'),
          ],
        ),
      ),
    );
  }
}