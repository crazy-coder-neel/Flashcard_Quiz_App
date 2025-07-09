import 'package:flutter/material.dart';

class FlashcardScreen extends StatefulWidget {
  final String category;

  const FlashcardScreen({super.key, required this.category});

  @override
  State<FlashcardScreen> createState() => _FlashcardScreenState();
}

class _FlashcardScreenState extends State<FlashcardScreen> {
  int _currentIndex = 0;
  bool _showAnswer = false;
  
  get flashcarddata => null;

  @override
  Widget build(BuildContext context) {
    final flashcards = flashcarddata[widget.category] ?? [];

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category),
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Spacer(),
            GestureDetector(
              onTap: () {
                setState(() {
                  _showAnswer = !_showAnswer;
                });
              },
              child: AnimatedContainer(
                duration: Duration(milliseconds: 300),
                padding: EdgeInsets.all(20),
                width: double.infinity,
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.purple.shade100,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 6,
                      color: Colors.deepPurple.withOpacity(0.3),
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    _showAnswer
                        ? flashcards[_currentIndex]["answer"]!
                        : flashcards[_currentIndex]["question"]!,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: _currentIndex > 0
                      ? () {
                          setState(() {
                            _currentIndex--;
                            _showAnswer = false;
                          });
                        }
                      : null,
                  child: Text("Previous"),
                ),
                ElevatedButton(
                  onPressed: _currentIndex < flashcards.length - 1
                      ? () {
                          setState(() {
                            _currentIndex++;
                            _showAnswer = false;
                          });
                        }
                      : null,
                  child: Text("Next"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
