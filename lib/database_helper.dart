class MathQuestion {
  final int? id;
  final String chapter;
  final String questionLatex;
  final List<String> steps;
  final String difficulty;

  MathQuestion({
    this.id,
    required this.chapter,
    required this.questionLatex,
    required this.steps,
    required this.difficulty,
  });
}

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  DatabaseHelper._init();

  final List<MathQuestion> _questions = [
    MathQuestion(
      id: 1,
      chapter: "Quadratic Equations",
      questionLatex: r"\text{Solve: } 2x^2 - 5x + 3 = 0 \text{ using Quadratic Formula.}",
      steps: [
        r"\text{Step 1: Identify coefficients } a=2, b=-5, c=3",
        r"\text{Step 2: Find Discriminant } D = b^2 - 4ac = (-5)^2 - 4(2)(3) = 25 - 24 = 1",
        r"\text{Step 3: Apply Formula } x = \frac{-b \pm \sqrt{D}}{2a} = \frac{-(-5) \pm \sqrt{1}}{2(2)}",
        r"\text{Step 4: Calculate roots } x = \frac{5 + 1}{4} = \frac{3}{2}, \quad x = \frac{5 - 1}{4} = 1",
        r"\text{Final Answer: } x = \frac{3}{2} \text{ and } x = 1"
      ],
      difficulty: "Standard",
    ),
    MathQuestion(
      id: 2,
      chapter: "Introduction to Trigonometry",
      questionLatex: r"\text{Prove that: } \frac{\sin \theta}{1 + \cos \theta} + \frac{1 + \cos \theta}{\sin \theta} = 2\csc \theta",
      steps: [
        r"\text{Step 1: Take LCM on LHS } \frac{\sin^2 \theta + (1 + \cos \theta)^2}{\sin \theta(1 + \cos \theta)}",
        r"\text{Step 2: Expand numerator } \frac{\sin^2 \theta + 1 + 2\cos \theta + \cos^2 \theta}{\sin \theta(1 + \cos \theta)}",
        r"\text{Step 3: Use identity } \sin^2 \theta + \cos^2 \theta = 1 \implies \frac{1 + 1 + 2\cos \theta}{\sin \theta(1 + \cos \theta)} = \frac{2(1 + \cos \theta)}{\sin \theta(1 + \cos \theta)}",
        r"\text{Step 4: Simplify } \frac{2}{\sin \theta} = 2\csc \theta = \text{RHS}"
      ],
      difficulty: "Standard",
    ),
    MathQuestion(
      id: 3,
      chapter: "Arithmetic Progressions",
      questionLatex: r"\text{Find the 10th term of the AP: } 2, 7, 12, \dots",
      steps: [
        r"\text{Step 1: Identify first term } a = 2 \text{ and common difference } d = 7 - 2 = 5",
        r"\text{Step 2: Formula: } a_n = a + (n - 1)d",
        r"\text{Step 3: Substitute } n = 10 \implies a_{10} = 2 + (10 - 1) \times 5",
        r"\text{Step 4: Calculate: } a_{10} = 2 + 45 = 47",
        r"\text{Final Answer: } 47"
      ],
      difficulty: "Easy",
    ),
  ];

  Future<List<MathQuestion>> getAllQuestions() async {
    return _questions;
  }
}
