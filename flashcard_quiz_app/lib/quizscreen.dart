import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  String selectedTopic = "AI/ML";
  List<String> topics = [
    "AI/ML",
    "Cloud Computing",
    "App Development",
    " Computer Networks",
    "Cybersecurity",
    "Database Management Systems",
    "Operating Systems",
    "Web Development",
  ];

  var data = "";
  String result = "";

  String getUrlEasy() =>
      "http://127.0.0.1:5000/quiz?no=5&topic=$selectedTopic&cat=easy";
  String getUrlIntermediate() =>
      "http://127.0.0.1:5000/quiz?no=10&topic=$selectedTopic&cat=intermediate";
  String getUrlHard() =>
      "http://127.0.0.1:5000/quiz?no=15&topic=$selectedTopic&cat=difficult";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Select Topic:",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF0D47A1),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: const Color(0xFF1565C0)),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: DropdownButton<String>(
                          isExpanded: true,
                          value: selectedTopic,
                          icon: const Icon(
                            Icons.arrow_drop_down,
                            color: Color(0xFF1565C0),
                          ),
                          iconSize: 24,
                          elevation: 16,
                          style: const TextStyle(color: Color(0xFF0D47A1)),
                          underline: const SizedBox(),
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedTopic = newValue!;
                            });
                          },
                          items: topics.map<DropdownMenuItem<String>>((
                            String value,
                          ) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 30),
              const Text(
                "Choose Difficulty:",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0D47A1),
                ),
              ),
              const SizedBox(height: 20),
              _buildDifficultyButton(
                "Easy",
                Icons.star_half,
                Color(0xFF42A5F5),
              ),
              const SizedBox(height: 15),
              _buildDifficultyButton(
                "Intermediate",
                Icons.star,
                const Color(0xFF1E88E5),
              ),
              const SizedBox(height: 15),
              _buildDifficultyButton(
                "Hard",
                Icons.stars,
                const Color(0xFF0D47A1),
              ),
              const SizedBox(height: 30),
              if (result.isNotEmpty) _buildResultCard(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDifficultyButton(String text, IconData icon, Color color) {
    return InkWell(
      onTap: () async {
        String url;
        if (text == "Easy") {
          url = getUrlEasy();
        } else if (text == "Intermediate") {
          url = getUrlIntermediate();
        } else {
          url = getUrlHard();
        }

        data = await fetchdata(url);
        var decoded = jsonDecode(data);
        setState(() {
          result = decoded["result"];
        });
      },
      child: Container(
        height: 80,
        decoration: BoxDecoration(
          color: color.withOpacity(0.2),
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: color, width: 2),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.3),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 30, color: color),
            const SizedBox(width: 15),
            Text(
              text,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildResultCard() {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.quiz, color: Color(0xFF1565C0), size: 30),
                const SizedBox(width: 10),
                Text(
                  "Quiz Results - $selectedTopic",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF0D47A1),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: const Color(0xFFE3F2FD),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: const Color(0xFFBBDEFB)),
              ),
              child: Text(
                result,
                style: const TextStyle(fontSize: 16, color: Colors.black87),
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "Good job! Keep learning!",
              style: TextStyle(
                fontSize: 14,
                fontStyle: FontStyle.italic,
                color: Colors.blueGrey,
              ),
            ),
          ],
        ),
      ),
    );
  }

  fetchdata(String url) async {
    http.Response response = await http.get(Uri.parse(url));
    return response.body;
  }
}