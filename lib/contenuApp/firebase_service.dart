import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final User? user = FirebaseAuth.instance.currentUser;

  // CREATE - Ajouter un objectif
  Future<void> addObjectif(String titre, {String? description, String? categorie}) async {
    try {
      await _firestore.collection('objectifs').add({
        'titre': titre,
        'description': description ?? '',
        'categorie': categorie ?? 'Général',
        'accompli': false,
        'userId': user?.uid,
        'dateCreation': Timestamp.now(),
      });
    } catch (e) {
      throw 'Erreur lors de l\'ajout: $e';
    }
  }

  // READ - Récupérer tous les objectifs de l'utilisateur
  Stream<QuerySnapshot> getObjectifs() {
    return _firestore
        .collection('objectifs')
        .where('userId', isEqualTo: user?.uid)
        .orderBy('dateCreation', descending: true)
        .snapshots();
  }

  // READ - Récupérer les objectifs par statut
  Stream<QuerySnapshot> getObjectifsByStatus(bool accompli) {
    return _firestore
        .collection('objectifs')
        .where('userId', isEqualTo: user?.uid)
        .where('accompli', isEqualTo: accompli)
        .orderBy('dateCreation', descending: true)
        .snapshots();
  }

  // UPDATE - Modifier un objectif
  Future<void> updateObjectif(String docId, Map<String, dynamic> data) async {
    try {
      await _firestore.collection('objectifs').doc(docId).update(data);
    } catch (e) {
      throw 'Erreur lors de la modification: $e';
    }
  }

  // UPDATE - Toggle le statut accompli
  Future<void> toggleObjectif(String docId, bool accompli) async {
    try {
      await _firestore.collection('objectifs').doc(docId).update({
        'accompli': accompli,
      });
    } catch (e) {
      throw 'Erreur lors de la modification: $e';
    }
  }

  // DELETE - Supprimer un objectif
  Future<void> deleteObjectif(String docId) async {
    try {
      await _firestore.collection('objectifs').doc(docId).delete();
    } catch (e) {
      throw 'Erreur lors de la suppression: $e';
    }
  }

  // Compter les objectifs accomplis
  Stream<int> getObjectifsAccomplisCount() {
    return _firestore
        .collection('objectifs')
        .where('userId', isEqualTo: user?.uid)
        .where('accompli', isEqualTo: true)
        .snapshots()
        .map((snapshot) => snapshot.docs.length);
  }

  // Compter les objectifs en cours
  Stream<int> getObjectifsEnCoursCount() {
    return _firestore
        .collection('objectifs')
        .where('userId', isEqualTo: user?.uid)
        .where('accompli', isEqualTo: false)
        .snapshots()
        .map((snapshot) => snapshot.docs.length);
  }
}