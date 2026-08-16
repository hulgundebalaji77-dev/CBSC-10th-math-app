import 'dart:convert';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

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

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'chapter': chapter,
      'questionLatex': questionLatex,
      'stepsJson': jsonEncode(steps),
      'difficulty': difficulty,
    };
  }

  factory MathQuestion.fromMap(Map<String, dynamic> map) {
    return MathQuestion(
      id: map['id'],
      chapter: map['chapter'],
      questionLatex: map['questionLatex'],
      steps: List<String>.from(jsonDecode(map['stepsJson'])),
      difficulty: map['difficulty'],
    );
  }
}

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('cbse_math10.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE questions (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        chapter TEXT NOT NULL,
        questionLatex TEXT NOT NULL,
        stepsJson TEXT NOT NULL,
        difficulty TEXT NOT NULL
      )
    ''');

    final sampleData = [
      MathQuestion(
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
    ];

    for (var q in sampleData) {
      await db.insert('questions', q.toMap());
    }
  }

  Future<List<MathQuestion>> getAllQuestions() async {
    final db = await instance.database;
    final result = await db.query('questions');
    return result.map((json) => MathQuestion.fromMap(json)).toList();
  }
}