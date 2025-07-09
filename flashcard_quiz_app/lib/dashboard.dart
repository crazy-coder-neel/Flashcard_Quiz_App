// import 'package:curved_navigation_bar/curved_navigation_bar.dart';
// import 'package:flashcard_quiz_app/Appdevelopmentscreen.dart';
// // import 'package:flashcard_quiz_app/add_cards_screen.dart';
// import 'package:flashcard_quiz_app/chatbot_ui.dart';
// import 'package:flashcard_quiz_app/profile1.dart';
// // import 'package:flashcard_quiz_app/chatbot.dart';
// // import 'package:flashcard_quiz_app/decks_screen.dart';
// // import 'package:flashcard_quiz_app/home_screen.dart';
// // import 'package:flashcard_quiz_app/profile_screen1.dart';
// import 'package:flashcard_quiz_app/profile_startscreen.dart';
// // import 'package:flashcard_quiz_app/quiz_screen.dart';
// // import 'package:flashcard_quiz_app/flashcard.dart';
// import 'package:flashcard_quiz_app/quizscreen.dart';
// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// class DashboardScreen extends StatefulWidget {
//   const DashboardScreen({super.key});

//   @override
//   State<DashboardScreen> createState() => _DashboardScreenState();
// }

// class _DashboardScreenState extends State<DashboardScreen> {
//   int index = 0;

//   final items = <Widget>[
//     Icon(Icons.home, size: 30),
//     Icon(Icons.add, size: 30),
//     // Icon(Icons.folder, size: 30),
//     Icon(Icons.quiz, size: 30),
//     Icon(FontAwesomeIcons.robot, size: 25),
//   ];

//   // final screens = [
//   //   // HomeScreen(),
//   //   // AddCardsScreen(),
//   //   // DecksScreen(),
//   //   QuizScreen(),
//   //   ProfileStartscreen(),
//   //   FlashcardScreen(),
//   //   // ChatbotUi(),
//   // ];
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: Container(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//             colors: [Color(0xFF0A0E21), Color(0xFF1E3C72), Color(0xFF2A5298)],
//           ),
//         ),
//         child: Scaffold(
//           extendBody: true,
//           backgroundColor: Color(0x0A0E21),
//           appBar: AppBar(
//             backgroundColor: Colors.blue,
//             title: Text("QUIZZY FLIP"),
//             centerTitle: true,
//             elevation: 30,
//             actions: [
//               Padding(
//                 padding: EdgeInsetsGeometry.only(right: 18),
//                 child: MouseRegion(
//                   cursor: SystemMouseCursors.click,
//                   child: GestureDetector(
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => const EditableProfileScreen(),
//                         ),
//                       );
//                     },
//                     child: CircleAvatar(
//                       radius: 18,
//                       child: Icon(FontAwesomeIcons.user),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           // body: screens[index],
//           bottomNavigationBar: MouseRegion(
//             cursor: SystemMouseCursors.click,

//             child: CurvedNavigationBar(
//               backgroundColor: Colors.transparent,
//               buttonBackgroundColor: Colors.white,
//               height: 60,
//               index: index,
//               items: items,
//               onTap: (index) {
//                 switch (index) {
//                   case 0:
//                     setState(() {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(builder: (context) => QuizScreen()),
//                       );
//                     });
//                     break;
//                   case 1:
//                     setState(() {});
//                     break;
//                   case 2:
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => ProfileStartscreen(),
//                       ),
//                     );
//                     break;

//                   case 3:
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(builder: (context) => ChatbotUi()),
//                     );
//                     break;
//                 }
//               },
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flashcard_quiz_app/Appdevelopmentscreen.dart';
import 'package:flashcard_quiz_app/chatbot_ui.dart';
import 'package:flashcard_quiz_app/profile1.dart';
import 'package:flashcard_quiz_app/profile_startscreen.dart';
import 'package:flashcard_quiz_app/quizscreen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF0A0E21), Color(0xFF1E3C72), Color(0xFF2A5298)],
          ),
        ),
        child: Scaffold(
          extendBody: true,
          backgroundColor: Color(0x0A0E21),
          appBar: AppBar(
            backgroundColor: Colors.blue,
            title: Text("QUIZZY FLIP"),
            centerTitle: true,
            elevation: 30,
            actions: [
              Padding(
                padding: EdgeInsets.only(right: 18),
                child: MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const EditableProfileScreen(),
                        ),
                      );
                    },
                    child: CircleAvatar(
                      radius: 18,
                      child: Icon(FontAwesomeIcons.user),
                    ),
                  ),
                ),
              ),
            ],
          ),
          drawer: Drawer(
            backgroundColor: Color(0xFF0A0E21).withOpacity(0.9),
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                DrawerHeader(
                  decoration: BoxDecoration(color: Colors.blue),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        radius: 30,
                        child: Icon(FontAwesomeIcons.user, size: 30),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Menu',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.home, color: Colors.white),
                  title: Text('Home', style: TextStyle(color: Colors.white)),
                  selected: _selectedIndex == 0,
                  onTap: () {
                    Navigator.pop(context);
                    _onItemTapped(0);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => QuizScreen()),
                    );
                  },
                ),
                ListTile(
                  leading: Icon(Icons.add, color: Colors.white),
                  title: Text(
                    'Add Cards',
                    style: TextStyle(color: Colors.white),
                  ),
                  selected: _selectedIndex == 1,
                  onTap: () {
                    Navigator.pop(context);
                    _onItemTapped(1);
                    // Add your navigation logic here
                  },
                ),
                ListTile(
                  leading: Icon(Icons.quiz, color: Colors.white),
                  title: Text(
                    'Flashcards',
                    style: TextStyle(color: Colors.white),
                  ),
                  selected: _selectedIndex == 2,
                  onTap: () {
                    Navigator.pop(context);
                    _onItemTapped(2);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProfileStartscreen(),
                      ),
                    );
                  },
                ),
                ListTile(
                  leading: Icon(FontAwesomeIcons.robot, color: Colors.white),
                  title: Text('Chatbot', style: TextStyle(color: Colors.white)),
                  selected: _selectedIndex == 3,
                  onTap: () {
                    Navigator.pop(context);
                    _onItemTapped(3);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ChatbotUi()),
                    );
                  },
                ),
                Divider(color: Colors.grey),
                ListTile(
                  leading: Icon(Icons.settings, color: Colors.white),
                  title: Text(
                    'Settings',
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    // Add settings navigation logic here
                  },
                ),
              ],
            ),
          ),
          body: Center(child: _getBodyContent(_selectedIndex)),
        ),
      ),
    );
  }

  Widget _getBodyContent(int index) {
    // Return different content based on the selected index
    switch (index) {
      case 0:
        return QuizScreen();
      case 1:
        return Center(child: Text('Add Cards Screen Content'));
      case 2:
        return ProfileStartscreen();
      case 3:
        return ChatbotUi();
      default:
        return QuizScreen();
    }
  }
}
