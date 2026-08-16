import 'package:flutter/material.dart';
import 'package:flutter_math_fork/flutter_math.dart';
import 'database_helper.dart';

class MathSolutionScreen extends StatefulWidget {
  final MathQuestion question;

  const MathSolutionScreen({Key? key, required this.question}) : super(key: key);

  @override
  State<MathSolutionScreen> createState() => _MathSolutionScreenState();
}

class _MathSolutionScreenState extends State<MathSolutionScreen> {
  int revealedStepsCount = 0;

  @override
  Widget build(BuildContext context) {
    final totalSteps = widget.question.steps.length;
    final bool isCompleted = revealedStepsCount >= totalSteps;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.question.chapter),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              color: Colors.indigo.shade50,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("QUESTION", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.indigo)),
                        Chip(
                          label: Text(widget.question.difficulty),
                          backgroundColor: Colors.indigo.shade100,
                        )
                      ],
                    ),
                    const SizedBox(height: 10),
                    Math.tex(
                      widget.question.questionLatex,
                      textStyle: const TextStyle(fontSize: 18, color: Colors.black87),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "Step-by-Step Solution:",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            if (revealedStepsCount == 0)
              Container(
                padding: const EdgeInsets.all(20),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  "उत्तर पाहण्यापूर्वी स्वतः सोडवण्याचा प्रयत्न करा!\nपायरी पाहण्यासाठी खालील बटण दाबा.",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: revealedStepsCount,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: index == totalSteps - 1 ? Colors.green.shade50 : Colors.white,
                    border: Border.all(
                      color: index == totalSteps - 1 ? Colors.green : Colors.grey.shade300,
                      width: index == totalSteps - 1 ? 1.5 : 1,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Math.tex(
                    widget.question.steps[index],
                    textStyle: TextStyle(
                      fontSize: 16,
                      color: index == totalSteps - 1 ? Colors.green.shade900 : Colors.black87,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4, offset: const Offset(0, -2))],
        ),
        child: ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            backgroundColor: isCompleted ? Colors.green : Colors.indigo,
            padding: const EdgeInsets.symmetric(vertical: 14),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
          onPressed: isCompleted
              ? null
              : () {
                  setState(() {
                    revealedStepsCount++;
                  });
                },
          icon: Icon(isCompleted ? Icons.check_circle : Icons.visibility, color: Colors.white),
          label: Text(
            isCompleted ? "पूर्ण उत्तर रिव्हील झाले" : "पुढची पायरी दाखवा (${revealedStepsCount + 1}/$totalSteps)",
            style: const TextStyle(fontSize: 16, color: Colors.white),
          ),
        ),
      ),
    );
  }
}