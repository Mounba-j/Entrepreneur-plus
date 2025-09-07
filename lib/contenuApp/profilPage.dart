import 'package:entrepreneur_plus/auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfilPage extends StatelessWidget {
  final User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Mon Profil'), automaticallyImplyLeading: false, centerTitle: true,),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: user?.photoURL != null 
                  ? NetworkImage(user!.photoURL!) 
                  : null,
              child: user?.photoURL == null 
                  ? Icon(Icons.person, size: 50) 
                  : null,
            ),
            SizedBox(height: 20),
            Text(
              user?.displayName ?? '${AuthService().getCurrentUser()?.email?.split('@').first ?? 'utilisateur'}',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5),
            Text(user?.email ?? ''),
            SizedBox(height: 30),
            ElevatedButton.icon(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
              },
              icon: Icon(Icons.logout),
              label: Text('Déconnexion'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
            ),
            SizedBox(height: 20),
            Divider(),
            ListTile(
              leading: Icon(Icons.star),
              title: Text('Objectifs accomplis', style: TextStyle( color: Colors.lightGreenAccent,fontSize: 18)),
              trailing: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('objectifs')
                    .where('userId', isEqualTo: user?.uid)
                    .where('accompli', isEqualTo: true)
                    .snapshots(),
                builder: (context, snapshot) {
                  return Text(
                    snapshot.hasData ? '${snapshot.data!.docs.length}' : '0',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.lightGreenAccent),
                  );
                },
              ),
            ),
            ListTile(
              leading: Icon(Icons.flag),
              title: Text('Objectifs en cours', style: TextStyle( color: Colors.orangeAccent, fontSize: 18)),
              trailing: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('objectifs')
                    .where('userId', isEqualTo: user?.uid)
                    .where('accompli', isEqualTo: false)
                    .snapshots(),
                builder: (context, snapshot) {
                  return Text(
                    snapshot.hasData ? '${snapshot.data!.docs.length}' : '0',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.orangeAccent),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}