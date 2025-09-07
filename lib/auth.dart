import 'package:firebase_auth/firebase_auth.dart';


class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  
  // Stream pour surveiller les changements d'état d'authentification
  Stream<User?> get userStream => _auth.authStateChanges();
  
  // Stream alternatif qui retourne l'UID de l'utilisateur (version string)
  Stream<String?> get uidStream => 
      _auth.authStateChanges().map((User? user) => user?.uid);

  // Inscription avec email et mot de passe
  Future<User?> signUp(String email, String password) async {
    
    try {
      // Nettoyer les entrées
      final String cleanedEmail = email.trim();
      final String cleanedPassword = password.trim();
      
      UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: cleanedEmail, 
        password: cleanedPassword
      );
      
      return result.user;
    } on FirebaseAuthException catch (e) {
      print("Erreur d'inscription: ${e.code} - ${e.message}");
      rethrow; // Propager l'exception pour la gérer dans l'interface utilisateur
    } catch (e) {
      print("Erreur inattendue: $e");
      rethrow;
    }
  }

  // Connexion avec email et mot de passe
  Future<User?> signIn(String email, String password) async {
    try {
      // Nettoyer les entrées
      email = email.trim();
      password = password.trim();

      UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email, 
        password: password
      );
      return result.user;
    } on FirebaseAuthException catch (e) {
      print("Erreur de connexion: ${e.code} - ${e.message}");
      rethrow; // Propager l'exception pour la gérer dans l'interface utilisateur
    } 
  }

  // Déconnexion
  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      print("Erreur lors de la déconnexion: $e");
      rethrow;
    }
  }

  // Obtenir l'utilisateur actuel
  User? getCurrentUser() {
    return _auth.currentUser;
  }
  
  // Récupérer l'UID de l'utilisateur actuel
  String? getCurrentUID() {
    return _auth.currentUser?.uid;
  }
}


