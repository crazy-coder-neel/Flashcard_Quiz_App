import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flashcard_quiz_app/flashcardcustomized.dart';
import 'package:flutter/material.dart';
import 'Appdevelopmentscreen.dart';
import 'aimldevelopmentscreen.dart';
import 'cloudcomputingscreen.dart';
import 'computernetworkscreen.dart';
import 'cybersecurityscreen.dart';
import 'databasesystemscreen.dart';
import 'operatingsystemscreen.dart';
import 'webdevelopmentscreen.dart';
import 'flashcardcustomized.dart'; // Make sure this is the correct path

class ProfileStartscreen extends StatefulWidget {
  const ProfileStartscreen({super.key});

  @override
  State<ProfileStartscreen> createState() => _ProfileStartscreenState();
}

class _ProfileStartscreenState extends State<ProfileStartscreen> {
  final List<String> categories = [
    "Web Development",
    "AI / ML",
    "App Development",
    "Operating Systems",
    "Computer Networks",
    "Cyber Security",
    "Database Systems",
    "Cloud Computing",
  ];

  void navigateToCategory(String title) {
    Widget? targetScreen;

    switch (title) {
      case "App Development":
        targetScreen = const FlashcardScreen();
        break;
      case "Web Development":
        targetScreen = const WebDevelopmentScreen();
        break;
      case "AI / ML":
        targetScreen = const Aimldevelopmentscreen();
        break;
      case "Operating Systems":
        targetScreen = const OperatingSystemScreen();
        break;
      case "Computer Networks":
        targetScreen = const ComputerNetworkScreen();
        break;
      case "Cyber Security":
        targetScreen = const CyberSecurityScreen();
        break;
      case "Database Systems":
        targetScreen = const DatabaseSystemScreen();
        break;
      case "Cloud Computing":
        targetScreen = const CloudComputingScreen();
        break;
      default:
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Screen for '$title' not implemented.")),
        );
        return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => targetScreen!),
    );
  }

  void navigateToCustomCard(String subjectId, String subjectName) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FlashcardCustomized(
  subjectId: subjectId,
  subjectName: subjectName,
),

      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.grey.shade100,
        appBar: AppBar(
          title: const Text("Select Your Interests"),
          backgroundColor: Colors.deepPurple,
          elevation: 0,
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('flashcardSubjects')
              .snapshots(),
          builder: (context, snapshot) {
            List<Map<String, dynamic>> customSubjects = [];

            if (snapshot.hasData) {
              customSubjects = snapshot.data!.docs
                  .map((doc) => {'id': doc.id, 'name': doc['name']})
                  .toList();
            }

            final allCards = [
              ...categories.map((e) => {'type': 'static', 'name': e}),
              ...customSubjects.map(
                (e) => {'type': 'custom', 'name': e['name'], 'id': e['id']},
              ),
            ];

            return Padding(
              padding: const EdgeInsets.all(12.0),
              child: GridView.builder(
                itemCount: allCards.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  childAspectRatio: 1,
                ),
                itemBuilder: (context, index) {
                  final item = allCards[index];
                  final title = item['name'];
                  final isCustom = item['type'] == 'custom';

                  return CategoryCard(
                    title: title,
                    onTap: () {
                      if (isCustom) {
                        navigateToCustomCard(item['id'], title);
                      } else {
                        navigateToCategory(title);
                      }
                    },
                  );
                },
              ),
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const FlashcardCustomized(
                  subjectName: '',
                  subjectId: '',
                ),
              ),
            );
          },
          backgroundColor: Colors.deepPurple,
          child: const Icon(Icons.add),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const CategoryCard({super.key, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Colors.deepPurple, Colors.purpleAccent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(50),
          boxShadow: [
            BoxShadow(
              color: const Color.fromARGB(255, 28, 60, 223),
              blurRadius: 6,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
