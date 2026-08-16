import 'package:flutter/material.dart';
import 'package:flutter_math_fork/flutter_math.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: HomeScreen(),
  ));
}

// ---------------- DATA MODELS & QUESTIONS ----------------
class MathQuestion {
  final int id;
  final String chapter;
  final String questionLatex;
  final List<String> steps;
  final String difficulty;

  MathQuestion({
    required this.id,
    required this.chapter,
    required this.questionLatex,
    required this.steps,
    required this.difficulty,
  });
}

final List<MathQuestion> sampleQuestions = [
  MathQuestion(
    id: 1,
    chapter: "Quadratic Equations",
    questionLatex: r"\text{Solve: } 2x^2 - 5x + 3 = 0",
    steps: [
      r"\text{Step 1: } a=2, b=-5, c=3",
      r"\text{Step 2: } D = b^2 - 4ac = (-5)^2 - 4(2)(3) = 1",
      r"\text{Step 3: } x = \frac{-(-5) \pm \sqrt{1}}{2(2)} = \frac{5 \pm 1}{4}",
      r"\text{Final Answer: } x = \frac{3}{2}, \quad x = 1",
    ],
    difficulty: "Standard",
  ),
  MathQuestion(
    id: 2,
    chapter: "Trigonometry",
    questionLatex: r"\text{Prove: } \frac{\sin \theta}{1 + \cos \theta} + \frac{1 + \cos \theta}{\sin \theta} = 2\csc \theta",
    steps: [
      r"\text{Step 1: LHS } = \frac{\sin^2 \theta + (1 + \cos \theta)^2}{\sin \theta(1 + \cos \theta)}",
      r"\text{Step 2: } = \frac{\sin^2 \theta + 1 + 2\cos \theta + \cos^2 \theta}{\sin \theta(1 + \cos \theta)}",
      r"\text{Step 3: } = \frac{2 + 2\cos \theta}{\sin \theta(1 + \cos \theta)} = \frac{2(1 + \cos \theta)}{\sin \theta(1 + \cos \theta)}",
      r"\text{Step 4: } = \frac{2}{\sin \theta} = 2\csc \theta = \text{RHS}",
    ],
    difficulty: "Standard",
  ),
  MathQuestion(
    id: 3,
    chapter: "Arithmetic Progressions",
    questionLatex: r"\text{Find 10th term of AP: } 2, 7, 12, \dots",
    steps: [
      r"\text{Step 1: } a = 2, \quad d = 7 - 2 = 5",
      r"\text{Step 2: } a_n = a + (n - 1)d",
      r"\text{Step 3: } a_{10} = 2 + (10 - 1) \times 5 = 2 + 45 = 47",
      r"\text{Final Answer: } 47",
    ],
    difficulty: "Easy",
  ),
];

// ---------------- HOME SCREEN ----------------
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CBSE Class 10 Math'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.indigo, padding: const EdgeInsets.symmetric(vertical: 12)),
                    icon: const Icon(Icons.menu_book, color: Colors.white),
                    label: const Text("Formulas", style: TextStyle(color: Colors.white)),
                    onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const FormulaScreen())),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.orange.shade800, padding: const EdgeInsets.symmetric(vertical: 12)),
                    icon: const Icon(Icons.timer, color: Colors.white),
                    label: const Text("Quiz", style: TextStyle(color: Colors.white)),
                    onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const QuizScreen())),
                  ),
                ),
              ],
            ),
          ),
          const Divider(),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text("Step-by-Step Solutions", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: sampleQuestions.length,
              itemBuilder: (context, index) {
                final q = sampleQuestions[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.indigo.shade50,
                      child: Text("${q.id}", style: const TextStyle(color: Colors.indigo, fontWeight: FontWeight.bold)),
                    ),
                    title: Text(q.chapter, style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text("Level: ${q.difficulty}"),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => SolutionDetailScreen(question: q)),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------- FORMULA SCREEN ----------------
class FormulaScreen extends StatelessWidget {
  const FormulaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final formulas = [
      {"title": "Quadratic Formula", "tex": r"x = \frac{-b \pm \sqrt{b^2 - 4ac}}{2a}"},
      {"title": "n-th Term of AP", "tex": r"a_n = a + (n - 1)d"},
      {"title": "Sum of AP", "tex": r"S_n = \frac{n}{2}[2a + (n - 1)d]"},
      {"title": "Distance Formula", "tex": r"d = \sqrt{(x_2 - x_1)^2 + (y_2 - y_1)^2}"},
      {"title": "Trigonometric Identity", "tex": r"\sin^2 \theta + \cos^2 \theta = 1"},
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Formula Sheet'), backgroundColor: Colors.indigo, foregroundColor: Colors.white),
      body: ListView.builder(
        itemCount: formulas.length,
        itemBuilder: (context, idx) => Card(
          margin: const EdgeInsets.all(8.0),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(formulas[idx]["title"]!, style: const TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Center(child: Math.tex(formulas[idx]["tex"]!, textStyle: const TextStyle(fontSize: 18, color: Colors.indigo))),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ---------------- QUIZ SCREEN ----------------
class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int score = 0;
  int current = 0;
  int? selected;

  final questions = [
    {"q": r"\text{Zeroes sum of } x^2 - 5x + 6 = ?", "opt": ["5", "-5", "6", "-6"], "ans": 0},
    {"q": r"\sin 30^\circ + \cos 60^\circ = ?", "opt": ["1/2", "1", "0", "2"], "ans": 1},
    {"q": r"\text{Distance of } (3,4) \text{ from origin:}", "opt": ["3", "4", "5", "7"], "ans": 2},
  ];

  @override
  Widget build(BuildContext context) {
    final q = questions[current];
    return Scaffold(
      appBar: AppBar(title: Text("Quiz (${current + 1}/${questions.length})"), backgroundColor: Colors.indigo, foregroundColor: Colors.white),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Card(
              color: Colors.indigo.shade50,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Math.tex(q["q"] as String, textStyle: const TextStyle(fontSize: 18)),
              ),
            ),
            const SizedBox(height: 20),
            ...(q["opt"] as List<String>).asMap().entries.map((e) {
              Color c = Colors.white;
              if (selected != null) {
                if (e.key == q["ans"]) c = Colors.green.shade100;
                if (selected == e.key && e.key != q["ans"]) c = Colors.red.shade100;
              }
              return Container(
                margin: const EdgeInsets.only(bottom: 8),
                width: double.infinity,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(backgroundColor: c, padding: const EdgeInsets.all(14)),
                  onPressed: () {
                    if (selected != null) return;
                    setState(() {
                      selected = e.key;
                      if (e.key == q["ans"]) score++;
                    });
                  },
                  child: Text(e.value, style: const TextStyle(color: Colors.black, fontSize: 16)),
                ),
              );
            }),
            const Spacer(),
            if (selected != null)
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.indigo, padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12)),
                onPressed: () {
                  if (current < questions.length - 1) {
                    setState(() {
                      current++;
                      selected = null;
                    });
                  } else {
                    showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                        title: const Text("Quiz Complete!"),
                        content: Text("Score: $score / ${questions.length}"),
                        actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text("OK"))],
                      ),
                    );
                  }
                },
                child: Text(current == questions.length - 1 ? "Finish" : "Next", style: const TextStyle(color: Colors.white)),
              )
          ],
        ),
      ),
    );
  }
}

// ---------------- SOLUTION DETAIL SCREEN ----------------
class SolutionDetailScreen extends StatelessWidget {
  final MathQuestion question;
  const SolutionDetailScreen({super.key, required this.question});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(question.chapter), backgroundColor: Colors.indigo, foregroundColor: Colors.white),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          Card(
            color: Colors.indigo.shade50,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Math.tex(question.questionLatex, textStyle: const TextStyle(fontSize: 16)),
            ),
          ),
          const SizedBox(height: 16),
          const Text("Solution Steps:", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 8),
          ...question.steps.map((s) => Card(
            margin: const EdgeInsets.only(bottom: 8),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Math.tex(s, textStyle: const TextStyle(fontSize: 15)),
            ),
          )),
        ],
      ),
    );
  }
}
