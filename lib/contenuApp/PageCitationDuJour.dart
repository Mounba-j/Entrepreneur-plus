import 'package:flutter/material.dart';

class CitationDuJour extends StatefulWidget {
  @override
  _CitationDuJourState createState() => _CitationDuJourState();
}

class _CitationDuJourState extends State<CitationDuJour> {
  final List<Map<String, String>> citations = [
    {
      "texte": "Votre temps est limité, ne le gâchez pas en menant une existence qui n’est pas la vôtre.",
      "auteur": "Steve Jobs",
      "categorie": "Développement personnel"
    },
  {
    "texte": "L’échec est simplement l’opportunité de recommencer, cette fois de manière plus intelligente.",
    "auteur": "Henry Ford",
    "categorie": "Entrepreneuriat"
  },
  {
    "texte": "Le succès n'est pas final, l'échec n'est pas fatal : c'est le courage de continuer qui compte.",
    "auteur": "Winston Churchill",
    "categorie": "Motivation"
  },
  {
    "texte": "Entreprendre, c’est se jeter dans le vide et assembler un avion sur le chemin de la chute.",
    "auteur": "Reid Hoffman",
    "categorie": "Entrepreneuriat"
  },
  {
    "texte": "Les idées sont faciles. L’exécution, c’est ce qui compte.",
    "auteur": "Guy Kawasaki",
    "categorie": "Entrepreneuriat"
  },
  {
    "texte": "La meilleure façon de prédire l’avenir est de l’inventer.",
    "auteur": "Alan Kay",
    "categorie": "Motivation"
  },
  {
    "texte": "Ne vous inquiétez pas d’être parfait. Soyez inquiet de ne pas commencer.",
    "auteur": "Mark Zuckerberg",
    "categorie": "Motivation"
  },
  {
    "texte": "Il n’est jamais trop tard pour être ce que vous auriez pu être.",
    "auteur": "George Eliot",
    "categorie": "Développement personnel"
  },
  {
    "texte": "Si vous ne pouvez pas voler, alors courez. Si vous ne pouvez pas courir, alors marchez. Si vous ne pouvez pas marcher, alors rampez, mais quoi que vous fassiez, vous devez continuer à avancer.",
    "auteur": "Martin Luther King Jr.",
    "categorie": "Motivation"
  },
  {
    "texte": "La persévérance est un grand élément de succès. Si vous frappez assez longtemps et assez fort à la porte, vous êtes sûr de réveiller quelqu’un.",
    "auteur": "Henry Wadsworth Longfellow",
    "categorie": "Motivation"
  },
  {
    "texte": "Le secret du changement, c’est de concentrer toute son énergie, non pas à lutter contre le passé mais à construire l’avenir.",
    "auteur": "Socrate",
    "categorie": "Développement personnel"
  },
  {
    "texte": "Faites ce que vous pouvez, avec ce que vous avez, là où vous êtes.",
    "auteur": "Theodore Roosevelt",
    "categorie": "Motivation"
  },
  {
    "texte": "L’innovation distingue les leaders des suiveurs.",
    "auteur": "Steve Jobs",
    "categorie": "Entrepreneuriat"
  },
  {
    "texte": "Le meilleur moment pour planter un arbre était il y a 20 ans. Le deuxième meilleur moment est maintenant.",
    "auteur": "Proverbe chinois",
    "categorie": "Développement personnel"
  },
  {
    "texte": "Le succès, c’est tomber sept fois et se relever huit.",
    "auteur": "Proverbe japonais",
    "categorie": "Motivation"
  },
  {
    "texte": "Ne te demande pas ce dont le monde a besoin. Demande-toi ce qui te fait vivre pleinement. Et ensuite, va le faire.",
    "auteur": "Howard Thurman",
    "categorie": "Développement personnel"
  },
  {
    "texte": "Soyez incontestablement bon.",
    "auteur": "Steve Martin",
    "categorie": "Motivation"
  },
  {
    "texte": "Toujours livrer plus que prévu.",
    "auteur": "Larry Page",
    "categorie": "Entrepreneuriat"
  },
  {
    "texte": "Il n’y a pas de raccourci pour aller d’un point A à un point B que le travail acharné.",
    "auteur": "Mark Zuckerberg",
    "categorie": "Entrepreneuriat"
  },
  {
    "texte": "Je savais que si j’échouais, je ne regretterais pas cela, mais je savais que la seule chose que je pourrais regretter est de ne pas essayer.",
    "auteur": "Jeff Bezos",
    "categorie": "Entrepreneuriat"
  },
  {
    "texte": "Ne vous inquiétez pas d’échouer. Vous avez seulement à avoir raison une fois.",
    "auteur": "Drew Houston",
    "categorie": "Entrepreneuriat"
  },
  {
    "texte": "Le succès consiste à aller d’échec en échec sans perdre son enthousiasme.",
    "auteur": "Winston Churchill",
    "categorie": "Motivation"
  },
  {
    "texte": "La seule façon de faire du bon travail est d’aimer ce que vous faites.",
    "auteur": "Steve Jobs",
    "categorie": "Développement personnel"
  },
  {
    "texte": "Le plus grand risque est de ne prendre aucun risque.",
    "auteur": "Mark Zuckerberg",
    "categorie": "Entrepreneuriat"
  },
  {
    "texte": "Ce n’est pas parce que les choses sont difficiles que nous n’osons pas, c’est parce que nous n’osons pas qu’elles sont difficiles.",
    "auteur": "Sénèque",
    "categorie": "Motivation"
  },
  {
    "texte": "La discipline est le pont entre les objectifs et les résultats.",
    "auteur": "Jim Rohn",
    "categorie": "Développement personnel"
  },
  {
    "texte": "Le seul endroit où le succès vient avant le travail, c’est dans le dictionnaire.",
    "auteur": "Vidal Sassoon",
    "categorie": "Motivation"
  },
  {
    "texte": "Ce que vous obtenez en atteignant vos objectifs n’est pas aussi important que ce que vous devenez en les atteignant.",
    "auteur": "Zig Ziglar",
    "categorie": "Développement personnel"
  },
  {
    "texte": "Les vrais entrepreneurs sont motivés par leur passion et non par le profit.",
    "auteur": "Guy Kawasaki",
    "categorie": "Entrepreneuriat"
  },
  {
    "texte": "Si vous passez outre ce sentiment de peur, ce sentiment de prise de risque, des choses vraiment surprenantes peuvent arriver.",
    "auteur": "Marissa Mayer",
    "categorie": "Motivation"
  },


    {
      "texte": "Le succès n'est pas final, l'échec n'est pas fatal : c'est le courage de continuer qui compte.",
      "auteur": "Winston Churchill",
      "categorie": "Motivation"
    },
    {
      "texte": "La meilleure façon de prédire l'avenir est de le créer.",
      "auteur": "Peter Drucker",
      "categorie": "Entrepreneuriat"
    },
    {
      "texte": "Votre temps est limité, ne le gâchez pas en vivant la vie de quelqu'un d'autre.",
      "auteur": "Steve Jobs",
      "categorie": "Développement personnel"
    },
    {
      "texte": "N'attendez pas. Le temps ne sera jamais juste.",
      "auteur": "Napoleon Hill",
      "categorie": "Motivation"
    },
    {
      "texte": "Le seul endroit où le succès vient avant le travail est dans le dictionnaire.",
      "auteur": "Vidal Sassoon",
      "categorie": "Travail"
    },
    {
      "texte": "Ne regardez pas l'horloge; faites ce qu'elle fait. Continuez.",
      "auteur": "Sam Levenson",
      "categorie": "Persévérance"
    },
    {
      "texte": "La créativité, c'est l'intelligence qui s'amuse.",
      "auteur": "Albert Einstein",
      "categorie": "Créativité"
    },
    {
      "texte": "Le leadership est la capacité de transformer une vision en réalité.",
      "auteur": "Warren Bennis",
      "categorie": "Leadership"
    },
    {
      "texte": "L'innovation distingue un leader d'un suiveur.",
      "auteur": "Steve Jobs",
      "categorie": "Innovation"
    },
    {
      "texte": "Le succès n'est pas la clé du bonheur. Le bonheur est la clé du succès.",
      "auteur": "Albert Schweitzer",
      "categorie": "Bonheur"
    },
    {
      "texte": "Il n'y a pas de substitut au travail acharné.",
      "auteur": "Thomas Edison",
      "categorie": "Travail"
    },
    {
      "texte": "Les grandes choses ne sont jamais faites par une seule personne. Elles sont faites par une équipe de personnes.",
      "auteur": "Steve Jobs",
      "categorie": "Travail d'équipe"
    },
    {
      "texte": "Le succès c'est tomber sept fois, se relever huit.",
      "auteur": "Proverbe japonais",
      "categorie": "Persévérance"
    },
    {
      "texte": "Faites ce que vous pouvez, avec ce que vous avez, là où vous êtes.",
      "auteur": "Theodore Roosevelt",
      "categorie": "Action"
    },
    {
      "texte": "La seule limite à notre épanouissement de demain sera nos doutes d'aujourd'hui.",
      "auteur": "Franklin D. Roosevelt",
      "categorie": "Développement personnel"
    },
    {
      "texte": "Le succès n'est pas mesuré par l'argent ou le pouvoir, mais par l'impact que vous avez sur la vie des autres.",
      "auteur": "Michelle Obama",
      "categorie": "Impact"
    },
    {
      "texte": "Ne soyez pas intimidé par ce que vous ne savez pas. Cela peut être votre plus grande force et vous assurer de faire les choses différemment des autres.",
      "auteur": "Sara Blakely",
      "categorie": "Confiance en soi"
    },
    {
      "texte": "Le plus grand risque est de ne prendre aucun risque.",
      "auteur": "Mark Zuckerberg",
      "categorie": "Prise de risque"
    },
    {
      "texte": "La discipline est le pont entre les objectifs et les réalisations.",
      "auteur": "Jim Rohn",
      "categorie": "Discipline"
    },
    {
      "texte": "Le succès n'est pas dans ce que vous avez, mais dans qui vous êtes.",
      "auteur": "Bo Bennett",
      "categorie": "Identité"
    },
    {
      "texte": "L'échec est simplement l'opportunité de recommencer, cette fois de manière plus intelligente.",
      "auteur": "Henry Ford",
      "categorie": "Échec"
    },
    {
      "texte": "La persévérance est souvent la clé du succès.",
      "auteur": "Debasish Mridha",
      "categorie": "Persévérance"
    },
    {
      "texte": "Le succès appartient à ceux qui croient en la beauté de leurs rêves.",
      "auteur": "Eleanor Roosevelt",
      "categorie": "Rêves"
    },
    {
      "texte": "Ne jugez pas chaque jour à la récolte que vous faites, mais aux graines que vous plantez.",
      "auteur": "Robert Louis Stevenson",
      "categorie": "Patience"
    },
    {
      "texte": "La seule façon de faire un excellent travail est d'aimer ce que vous faites.",
      "auteur": "Steve Jobs",
      "categorie": "Passion"
    },
    {
      "texte": "Le succès n'est pas une destination, c'est un voyage.",
      "auteur": "Zig Ziglar",
      "categorie": "Voyage"
    },

    // Ajoutez au moins 30 citations différentes ici
  ];

  Map<String, String> citationDuJour = {};

  @override
  void initState() {
    super.initState();
    _chargerCitationDuJour();
  }

  void _chargerCitationDuJour() {
    final now = DateTime.now();
    final dayOfYear = now.difference(DateTime(now.year, 1, 1)).inDays;
    final index = dayOfYear % citations.length;
    
    setState(() {
      citationDuJour = citations[index];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Citation du Jour', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 24)),
        backgroundColor: Colors.lightBlueAccent,

        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: citationDuJour.isEmpty
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.format_quote, size: 50, color: Colors.lightGreen[400]),
                  SizedBox(height: 20),
                  Text(
                    
                    '"${citationDuJour["texte"]}"',
                    style: TextStyle(fontSize: 22, fontStyle: FontStyle.italic, color: Colors.green[800]),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 30),
                  Text(
                    '- ${citationDuJour["auteur"]}',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.right,
                  ),
                  SizedBox(height: 10),
                  Chip(
                    label: Text(
                      citationDuJour["categorie"]!,
                      style: TextStyle(color: Colors.white),
                    ),
                    backgroundColor: Colors.blueGrey[200],
                  ),
                  SizedBox(height: 40),
                  ElevatedButton.icon(
                    onPressed: _chargerCitationDuJour,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.lightBlueAccent,
                      foregroundColor: Colors.white,
                    ),
                    icon: Icon(Icons.autorenew),
                    label: Text('Citation'),
                  ),
                ],
              ),
            ),
    );
  }
}