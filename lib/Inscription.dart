import 'package:entrepreneur_plus/auth.dart';
import 'package:entrepreneur_plus/contenuApp/BienvenuPage.dart';
import 'package:flutter/material.dart';
import 'dart:ui';
import 'Connexion.dart';

class Inscription extends StatefulWidget {
  const Inscription({super.key});

  @override
  State<Inscription> createState() => _InscriptionState();
}

class _InscriptionState extends State<Inscription> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  bool isLoading = false;
  bool passwordVisible = false;
  bool confirmPasswordVisible = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _signUp() async {
    if (_formKey.currentState!.validate()) {
      setState(() => isLoading = true);

      print("Tentative d'inscription avec: ${emailController.text}");
      
      try {
        final result = await AuthService().signUp(
          emailController.text.trim(),
          passwordController.text,
        );
        
        print("Résultat de l'inscription: $result");
        
        setState(() => isLoading = false);
        
        // CORRECTION ICI : Vérifier le type du résultat
        if (result is String) {
          // C'est une erreur (String)
          print("Erreur lors de l'inscription: $result");
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("Erreur lors de l'inscription: $result"),
                backgroundColor: Colors.red,
                duration: const Duration(seconds: 4),
              ),
            );
          }
        } else {
          // C'est un succès (null ou User object)
          print("Inscription réussie, redirection...");
          if (mounted) {
            Navigator.pushReplacement(
              context, 
              MaterialPageRoute(builder: (context) => BienvenuPage())
            );
          }
        }
      } catch (e) {
        print("Exception during signup: $e");
        setState(() => isLoading = false);
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Erreur lors de l'inscription: ${e.toString()}"),
              backgroundColor: Colors.red,
              duration: const Duration(seconds: 4),
            ),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            "assets/images/connexionScreen.gif", 
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => Container(color: Colors.grey[300]),
          ),
          Center(
            child: SingleChildScrollView(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30.0),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
                  child: Container(
                    width: 350,
                    padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.18),
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(color: Colors.white.withOpacity(0.3), width: 1.5),
                    ),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "Inscription", 
                            style: TextStyle(
                              fontSize: 32, 
                              fontWeight: FontWeight.bold, 
                              color: Colors.white.withOpacity(0.95)
                            )
                          ),
                          const SizedBox(height: 10),
                          Text(
                            "Bienvenu(e) Entrepreneur", 
                            style: TextStyle(
                              fontSize: 18, 
                              color: Colors.white.withOpacity(0.85)
                            )
                          ),
                          const SizedBox(height: 30),

                          // Champ Email
                          TextFormField(
                            controller: emailController,
                            keyboardType: TextInputType.emailAddress,
                            style: const TextStyle(color: Colors.white),
                            decoration: _inputDecoration("Email", Icons.email),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Veuillez entrer votre email';
                              }
                              if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                                return 'Email invalide';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),

                          // Champ Mot de passe
                          TextFormField(
                            controller: passwordController,
                            obscureText: !passwordVisible,
                            style: const TextStyle(color: Colors.white),
                            decoration: _inputDecoration("Mot de passe", Icons.lock).copyWith(
                              suffixIcon: IconButton(
                                icon: Icon(
                                  passwordVisible ? Icons.visibility : Icons.visibility_off, 
                                  color: Colors.white70
                                ),
                                onPressed: () {
                                  setState(() {
                                    passwordVisible = !passwordVisible;
                                  });
                                },
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Veuillez entrer un mot de passe';
                              }
                              if (value.length < 6) {
                                return 'Le mot de passe doit contenir au moins 6 caractères';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),

                          // Champ Confirmation
                          TextFormField(
                            controller: confirmPasswordController,
                            obscureText: !confirmPasswordVisible,
                            style: const TextStyle(color: Colors.white),
                            decoration: _inputDecoration("Confirmer le mot de passe", Icons.lock_outline).copyWith(
                              suffixIcon: IconButton(
                                icon: Icon(
                                  confirmPasswordVisible ? Icons.visibility : Icons.visibility_off, 
                                  color: Colors.white70
                                ),
                                onPressed: () {
                                  setState(() {
                                    confirmPasswordVisible = !confirmPasswordVisible;
                                  });
                                },
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Veuillez confirmer votre mot de passe';
                              }
                              if (value != passwordController.text) {
                                return 'Les mots de passe ne correspondent pas';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 24),

                          // Bouton d'inscription
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: isLoading ? null : _signUp,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blueAccent,
                                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                disabledBackgroundColor: Colors.blueAccent.withOpacity(0.5),
                              ),
                              child: isLoading
                                  ? const SizedBox(
                                      width: 20,
                                      height: 20,
                                      child: CircularProgressIndicator(
                                        color: Colors.white,
                                        strokeWidth: 2,
                                      ),
                                    )
                                  : const Text(
                                      "S'inscrire", 
                                      style: TextStyle(fontSize: 18)
                                    ),
                            ),
                          ),
                          
                          const SizedBox(height: 16),
                          
                          // Lien vers la page de connexion
                          TextButton(
                            onPressed: isLoading 
                                ? null 
                                : () {
                                  Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => Connexion(),
                                        ),
                                      );
                                  },
                            child: Text(
                              "J'ai un compte ? Se connecter",
                              style: TextStyle(
                                color: isLoading 
                                    ? Colors.white.withOpacity(0.4)
                                    : Colors.white.withOpacity(0.8),
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  InputDecoration _inputDecoration(String label, IconData icon) {
    return InputDecoration(
      filled: true,
      fillColor: Colors.white.withOpacity(0.15),
      prefixIcon: Icon(icon, color: Colors.white70),
      labelText: label,
      labelStyle: TextStyle(color: Colors.white70),
      hintStyle: const TextStyle(color: Colors.white54),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20), 
        borderSide: BorderSide(color: Colors.white.withOpacity(0.5))
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20), 
        borderSide: const BorderSide(color: Colors.white)
      ),
      errorStyle: const TextStyle(color: Colors.orangeAccent),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: const BorderSide(color: Colors.orangeAccent),
      ),
    );
  }
}