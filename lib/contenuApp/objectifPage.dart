import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'firebase_service.dart';

class ObjectifsPage extends StatefulWidget {
  const ObjectifsPage({super.key});

  @override
  _ObjectifsPageState createState() => _ObjectifsPageState();
}

class _ObjectifsPageState extends State<ObjectifsPage> {
  final FirebaseService _firebaseService = FirebaseService();
  final _formKey = GlobalKey<FormState>();
  String _selectedFilter = 'Tous';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
         automaticallyImplyLeading: false,
         centerTitle: true,
        title: Text('Mes Objectifs'),
        actions: [
          // Filtre des objectifs
          PopupMenuButton<String>(
            onSelected: (value) {
              setState(() {
                _selectedFilter = value;
              });
            },
            itemBuilder: (BuildContext context) => [
              PopupMenuItem(value: 'Tous', child: Text('Tous les objectifs')),
              PopupMenuItem(value: 'Accomplis', child: Text('Accomplis')),
              PopupMenuItem(value: 'En cours', child: Text('En cours')),
            ],
            icon: Icon(Icons.filter_list),
          ),
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _showAddObjectifDialog(),
          ),
        ],
      ),
      body: _buildObjectifsList(),
    );
  }

  Widget _buildObjectifsList() {
    Stream<QuerySnapshot> objectifsStream;

    switch (_selectedFilter) {
      case 'Accomplis':
        objectifsStream = _firebaseService.getObjectifsByStatus(true);
        break;
      case 'En cours':
        objectifsStream = _firebaseService.getObjectifsByStatus(false);
        break;
      default:
        objectifsStream = _firebaseService.getObjectifs();
    }

    return StreamBuilder<QuerySnapshot>(
      stream: objectifsStream,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text('Erreur: ${snapshot.error}'));
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if (snapshot.data!.docs.isEmpty) {
          return _buildEmptyState();
        }

        return ListView.builder(
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (context, index) {
            DocumentSnapshot doc = snapshot.data!.docs[index];
            Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

            return _buildObjectifTile(doc.id, data);
          },
        );
      },
    );
  }

  Widget _buildObjectifTile(String docId, Map<String, dynamic> data) {
    return Dismissible(
      key: Key(docId),
      direction: DismissDirection.endToStart,
      background: Container(
        color: Colors.red,
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 20),
        child: Icon(Icons.delete, color: Colors.white),
      ),
      confirmDismiss: (direction) async {
        return await showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Confirmer la suppression"),
              content: Text("Voulez-vous vraiment supprimer cet objectif ?"),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: Text("Annuler"),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: Text("Supprimer", style: TextStyle(color: Colors.red)),
                ),
              ],
            );
          },
        );
      },
      onDismissed: (direction) {
        _firebaseService.deleteObjectif(docId);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Objectif supprimé"),
            action: SnackBarAction(
              label: "Annuler",
              onPressed: () {
                // Option: recréer l'objectif supprimé
              },
            ),
          ),
        );
      },
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: ListTile(
          leading: Checkbox(
            value: data['accompli'] ?? false,
            onChanged: (value) {
              _firebaseService.toggleObjectif(docId, value!);
            },
          ),
          title: Text(
            data['titre'],
            style: TextStyle(
              decoration: data['accompli'] 
                  ? TextDecoration.lineThrough 
                  : TextDecoration.none,
              fontWeight: data['accompli'] ? FontWeight.normal : FontWeight.bold,
            ),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (data['description'] != null && data['description'].isNotEmpty)
                Text(
                  data['description'],
                  style: TextStyle(
                    decoration: data['accompli'] 
                        ? TextDecoration.lineThrough 
                        : TextDecoration.none,
                  ),
                ),
              SizedBox(height: 4),
              Text(
                DateFormat('dd/MM/yyyy à HH:mm').format(
                  (data['dateCreation'] as Timestamp).toDate(),
                ),
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
              if (data['categorie'] != null && data['categorie'].isNotEmpty)
                Chip(
                  label: Text(
                    data['categorie'],
                    style: TextStyle(fontSize: 10, color: Colors.white),
                  ),
                  backgroundColor: Colors.blue,
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
            ],
          ),
          trailing: IconButton(
            icon: Icon(Icons.edit, size: 20),
            onPressed: () => _showEditObjectifDialog(docId, data),
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.flag, size: 60, color: Colors.grey[300]),
          SizedBox(height: 20),
          Text(
            'Aucun objectif',
            style: TextStyle(fontSize: 18, color: Colors.grey),
          ),
          SizedBox(height: 10),
          Text(
            _selectedFilter == 'Accomplis' 
              ? 'Aucun objectif accompli pour le moment'
              : _selectedFilter == 'En cours'
                ? 'Aucun objectif en cours'
                : 'Commencez par ajouter votre premier objectif',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey),
          ),
          SizedBox(height: 20),
          ElevatedButton.icon(
            onPressed: () => _showAddObjectifDialog(),
            icon: Icon(Icons.add),
            label: Text('Ajouter un objectif'),
          ),
        ],
      ),
    );
  }

  void _showAddObjectifDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        final titreController = TextEditingController();
        final descriptionController = TextEditingController();
        String selectedCategorie = 'Général';

        return AlertDialog(
          title: Text('Nouvel Objectif'),
          content: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: titreController,
                  decoration: InputDecoration(
                    labelText: 'Objectif*',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Veuillez entrer un objectif';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: descriptionController,
                  decoration: InputDecoration(
                    labelText: 'Description',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 3,
                ),
                SizedBox(height: 10),
                DropdownButtonFormField<String>(
                  value: selectedCategorie,
                  items: ['Business', 'Personnel', 'Santé', 'Apprentissage', 'Général']
                      .map((categorie) => DropdownMenuItem(
                            value: categorie,
                            child: Text(categorie),
                          ))
                      .toList(),
                  onChanged: (value) {
                    selectedCategorie = value!;
                  },
                  decoration: InputDecoration(
                    labelText: 'Catégorie',
                    border: OutlineInputBorder(),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Annuler'),
            ),
            ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  try {
                    await _firebaseService.addObjectif(
                      titreController.text,
                      description: descriptionController.text,
                      categorie: selectedCategorie,
                    );
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Objectif ajouté avec succès!')),
                    );
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Erreur: $e')),
                    );
                  }
                }
              },
              child: Text('Ajouter'),
            ),
          ],
        );
      },
    );
  }

  void _showEditObjectifDialog(String docId, Map<String, dynamic> data) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        final titreController = TextEditingController(text: data['titre']);
        final descriptionController = TextEditingController(text: data['description']);
        String selectedCategorie = data['categorie'] ?? 'Général';

        return AlertDialog(
          title: Text('Modifier l\'objectif'),
          content: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: titreController,
                  decoration: InputDecoration(
                    labelText: 'Objectif*',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Veuillez entrer un objectif';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: descriptionController,
                  decoration: InputDecoration(
                    labelText: 'Description',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 3,
                ),
                SizedBox(height: 10),
                DropdownButtonFormField<String>(
                  value: selectedCategorie,
                  items: ['Business', 'Personnel', 'Santé', 'Apprentissage', 'Général']
                      .map((categorie) => DropdownMenuItem(
                            value: categorie,
                            child: Text(categorie),
                          ))
                      .toList(),
                  onChanged: (value) {
                    selectedCategorie = value!;
                  },
                  decoration: InputDecoration(
                    labelText: 'Catégorie',
                    border: OutlineInputBorder(),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Annuler'),
            ),
            ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  try {
                    await _firebaseService.updateObjectif(docId, {
                      'titre': titreController.text,
                      'description': descriptionController.text,
                      'categorie': selectedCategorie,
                    });
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Objectif modifié avec succès!')),
                    );
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Erreur: $e')),
                    );
                  }
                }
              },
              child: Text('Modifier'),
            ),
          ],
        );
      },
    );
  }
}