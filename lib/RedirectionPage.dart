import 'package:entrepreneur_plus/auth.dart';
import 'package:entrepreneur_plus/contenuApp/BienvenuPage.dart';
import 'package:flutter/material.dart';
import 'package:entrepreneur_plus/Connexion.dart';

class RedirectionPage extends StatefulWidget {
  const RedirectionPage({super.key});

  @override
  State<RedirectionPage> createState() => _RedirectionPageState();
}

class _RedirectionPageState extends State<RedirectionPage> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder   (
      stream: AuthService().userStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasData) {
          return const BienvenuPage();
       
        } else {
        
          return Connexion();
        }
      },
    );
  }
}