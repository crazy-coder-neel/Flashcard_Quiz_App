import 'package:firebase_core/firebase_core.dart';
import 'package:flashcard_quiz_app/dashboard.dart';
import 'package:flashcard_quiz_app/sign.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flashcard_quiz_app/profile_startscreen.dart';
// ignore: unused_import
import 'Appdevelopmentscreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: FirebaseOptions(
        apiKey: "",
        authDomain: "",
        projectId: "",
        storageBucket: "",
        messagingSenderId: "",
        appId: "",
        measurementId: "",
      ),
    );
  } else {
    await Firebase.initializeApp();
  }

  runApp(const MyApp());
}

class flash_screen {
  const flash_screen();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const VideoBackgroundScreen(),
    );
  }
}
