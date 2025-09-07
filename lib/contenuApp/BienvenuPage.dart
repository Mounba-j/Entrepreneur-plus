import 'package:entrepreneur_plus/Connexion.dart';
import 'package:entrepreneur_plus/auth.dart';
import 'package:entrepreneur_plus/contenuApp/PageCitationDuJour.dart';
import 'package:entrepreneur_plus/contenuApp/objectifPage.dart';
import 'package:entrepreneur_plus/contenuApp/profilPage.dart';
import 'package:flutter/material.dart';

class BienvenuPage extends StatefulWidget {
  const BienvenuPage({super.key});

  @override
  State<BienvenuPage> createState() => _BienvenuPageState();
}

class _BienvenuPageState extends State<BienvenuPage> {
  int _currentIndex = 0;
  final List<Widget> _pages = [CitationDuJour(), ObjectifsPage(), ProfilPage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 30,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        automaticallyImplyLeading: false,
        title: Text(
          "Bienvenu(e): ${AuthService().getCurrentUser()?.email?.split('@').first ?? 'Utilisateur'}",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 25),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            color: Colors.red,
            onPressed: () async {
              await AuthService().signOut();
              // Après la déconnexion, l'utilisateur sera redirigé automatiquement par le StreamBuilder dans RedirectionPage
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => Connexion()),
              );
            },
          ),
        ],
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        elevation: 30,
        unselectedItemColor: Colors.grey,

        backgroundColor: Colors.white,
        selectedItemColor: Colors.blue,
        type: BottomNavigationBarType.shifting,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          
          BottomNavigationBarItem(
            
            icon: Icon(Icons.lightbulb_outline),
            label: 'Citation',
          ),
          BottomNavigationBarItem(
           
            icon: Icon(Icons.flag_outlined),
            label: 'Objectifs',
          ),
          BottomNavigationBarItem(
             
            icon: Icon(Icons.person_outline),
            label: 'Profil',
          ),
        ],
      ),
    );
  }
}
