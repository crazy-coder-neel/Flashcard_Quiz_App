import 'package:flutter/material.dart';
import 'dart:math';
import 'profile_startscreen.dart'; // adjust path if needed

class ComputerNetworkScreen extends StatefulWidget {
  const ComputerNetworkScreen({super.key});

  @override
  State<ComputerNetworkScreen> createState() => _FlashcardScreenState();
}

class _FlashcardScreenState extends State<ComputerNetworkScreen>
    with SingleTickerProviderStateMixin {
  int currentIndex = 0;
  bool showAnswer = false;
  late AnimationController _controller;
  late Animation<double> _animation;

  final List<Map<String, String>> appDevelopmentCards = [
    {"question": "What is an IP address?", "answer": "Unique identifier for a device on a network."},
    {"question": "What is DNS?", "answer": "Translates domain names to IP addresses."},
    {"question": "What is HTTP?", "answer": "Protocol for web communication."},
    {"question": "What is TCP/IP?", "answer": "Suite of protocols for communication on networks."},
    {"question": "What is a router?", "answer": "Device that forwards data between networks."},
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0, end: pi).animate(_controller);
  }

  void toggleCard() {
    if (!_controller.isAnimating) {
      if (!showAnswer) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
      setState(() {
        showAnswer = !showAnswer;
      });
    }
  }

  void nextCard() {
    if (currentIndex < appDevelopmentCards.length - 1) {
      setState(() {
        currentIndex++;
        showAnswer = false;
        _controller.reset();
      });
    }
  }

  void previousCard() {
    if (currentIndex > 0) {
      setState(() {
        currentIndex--;
        showAnswer = false;
        _controller.reset();
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _buildFront(String question) {
    return _buildCard("Question", question);
  }

  Widget _buildBack(String answer) {
    return _buildCard("Answer", answer);
  }

  Widget _buildCard(String label, String content) {
    return Container(
      constraints: const BoxConstraints(
        minHeight: 250,
        maxHeight: 450, // Make the card taller
        minWidth: double.infinity,
      ),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF0A2647), Color(0xFF144272)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            // ignore: deprecated_member_use
            color: Colors.blueAccent.withOpacity(0.3),
            blurRadius: 20,
            spreadRadius: 2,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 40.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 20,
              color: Colors.white70,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 24),
          Text(
            content,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final currentCard = appDevelopmentCards[currentIndex];
    final bool isLastCard = currentIndex == appDevelopmentCards.length - 1;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: const Color(0xFF0B1E3B),
        appBar: AppBar(
          title: const Text("App Development"),
          backgroundColor: const Color(0xFF1E3C72),
          elevation: 2,
          centerTitle: true,
          actions: [
            IconButton(
              icon: const Icon(Icons.exit_to_app),
              tooltip: 'Exit',
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ProfileStartscreen(),
                  ),
                );
              },
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: toggleCard,
                  child: AnimatedBuilder(
                    animation: _animation,
                    builder: (context, child) {
                      final isFront = _animation.value < pi / 2;
                      return Transform(
                        alignment: Alignment.center,
                        transform: Matrix4.identity()
                          ..setEntry(3, 2, 0.001)
                          ..rotateY(_animation.value),
                        child: isFront
                            ? _buildFront(currentCard['question']!)
                            : Transform(
                                alignment: Alignment.center,
                                transform: Matrix4.rotationY(pi),
                                child: _buildBack(currentCard['answer']!),
                              ),
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(height: 30),

              // 🎉 Completion Message
              if (isLastCard && showAnswer)
                Column(
                  children: [
                    const Text(
                      "🎉 Awesome! You completed it!",
                      style: TextStyle(
                        fontSize: 22,
                        color: Colors.white70,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton.icon(
                      icon: const Icon(Icons.exit_to_app),
                      label: const Text("Exit"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF1976D2),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 12,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ProfileStartscreen(),
                          ),
                        );
                      },
                    ),
                  ],
                )
              else
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton.icon(
                      icon: const Icon(Icons.arrow_back_ios_new_rounded),
                      label: const Text("Previous"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(
                          255,
                          168,
                          177,
                          193,
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 12,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      onPressed: previousCard,
                    ),
                    if (!isLastCard)
                      ElevatedButton.icon(
                        icon: const Icon(Icons.arrow_forward_ios_rounded),
                        label: const Text("Next"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(
                            255,
                            168,
                            177,
                            193,
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 12,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                         onPressed: nextCard,
                      ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}