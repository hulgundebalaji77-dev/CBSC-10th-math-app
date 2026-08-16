import 'package:flutter/material.dart';
import 'package:flutter_math_fork/flutter_math.dart';

class QuizQuestion {
  final String questionLatex;
  final List<String> options;
  final int correctIndex;

  QuizQuestion({required this.questionLatex, required this.options, required this.correctIndex});
}

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  final List<QuizQuestion> questions = [
    QuizQuestion(
      questionLatex: r"\text{If } \alpha, \beta \text{ are zeroes of } x^2 - 5x + 6, \text{ then } \alpha + \beta = ?",
      options: ["5", "-5", "6", "-6"],
      correctIndex: 0,
    ),
    QuizQuestion(
      questionLatex: r"\text{The value of } \sin 30^\circ + \cos 60^\circ \text{ is:}",
      options: ["1/2", "1", r"\sqrt{3}", "0"],
      correctIndex: 1,
    ),
    QuizQuestion(
      questionLatex: r"\text{The distance of point } P(3, 4) \text{ from the origin is:}",
      options: ["3", "4", "5", "7"],
      correctIndex: 2,
    ),
  ];

  int currentIndex = 0;
  int score = 0;
  int? selectedOption;

  void checkAnswer(int index) {
    if (selectedOption != null) return;
    setState(() {
      selectedOption = index;
      if (index == questions[currentIndex].correctIndex) {
        score++;
      }
    });
  }

  void nextQuestion() {
    if (currentIndex < questions.length - 1) {
      setState(() {
        currentIndex++;
        selectedOption = null;
      });
    } else {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => AlertDialog(
          title: const Text("Quiz Complete! 🎉"),
          content: Text("Your Score: $score / ${questions.length}"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
              child: const Text("Back to Home"),
            )
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final q = questions[currentIndex];
    return Scaffold(
      appBar: AppBar(
        title: Text("Math Quiz (${currentIndex + 1}/${questions.length})"),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              color: Colors.indigo.shade50,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Math.tex(q.questionLatex, textStyle: const TextStyle(fontSize: 18)),
              ),
            ),
            const SizedBox(height: 20),
            ...List.generate(q.options.length, (idx) {
              Color btnColor = Colors.white;
              if (selectedOption != null) {
                if (idx == q.correctIndex) btnColor = Colors.green.shade100;
                if (selectedOption == idx && idx != q.correctIndex) btnColor = Colors.red.shade100;
              }
              return Container(
                margin: const EdgeInsets.only(bottom: 10),
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    backgroundColor: btnColor,
                    padding: const EdgeInsets.all(14),
                  ),
                  onPressed: () => checkAnswer(idx),
                  child: Text(q.options[idx], style: const TextStyle(fontSize: 16, color: Colors.black)),
                ),
              );
            }),
            const Spacer(),
            if (selectedOption != null)
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigo,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                onPressed: nextQuestion,
                child: Text(currentIndex == questions.length - 1 ? "Finish Quiz" : "Next Question",
                    style: const TextStyle(color: Colors.white, fontSize: 16)),
              )
          ],
        ),
      ),
    );
  }
}