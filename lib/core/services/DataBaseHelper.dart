import 'dart:convert';
import 'package:injectable/injectable.dart';
import 'package:online_exam_app/data/model/Result/ResultModel.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'token_storage_service.dart';

@singleton
class DatabaseHelper {
  static Database? _database;
  final TokenStorageService _tokenStorageService;
  late String userId;

  @factoryMethod
  DatabaseHelper(this._tokenStorageService);

  /// Returns the database instance, initializing it if necessary.
  Future<Database> get database async {
    // If userId is empty, try to get it from token storage
    if (userId.isEmpty) {
      final token = await _tokenStorageService.getToken();
      if (token != null && token.isNotEmpty) {
        // Extract user ID from token or use token hash as userId
        userId = token.hashCode.toString();
        print('📌 Using token-based userId: $userId');
      } else {
        // Use a temporary ID if no token is available
        userId = 'temp_user';
        print('⚠️ No token found, using temporary userId: $userId');
      }
    }

    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  /// Initializes the SQLite database and returns the instance.
  Future<Database> _initDB() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'exam_results.db');
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  /// Callback function to handle database creation.
  Future<void> _onCreate(Database db, int version) async {
    // No need to create tables here; they are created dynamically per user
  }

  /// Creates a table for storing exam results for a specific user.
  Future<void> createUserTable() async {
    final db = await database; // This will set the userId properly
    print('📌 Creating table for userId: $userId'); // Debug print

    await db.execute('''
      CREATE TABLE IF NOT EXISTS results_$userId (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        examId TEXT UNIQUE,
        message TEXT,
        studentAnswers TEXT,
        questions TEXT,
        correctQuestions TEXT,
        wrongQuestions TEXT,
        subject TEXT,
        exam TEXT
      )
    ''');
  }

  /// Inserts an exam result for a specific user.
  Future<int> insertResult(ResultModel result) async {
    final db = await database;
    await createUserTable();

    // Use the toDatabaseJson method from ResultModel
    final Map<String, dynamic> resultJson = result.toJson();

    print(
        "✅✅✅ Result Inserted ✅✅✅\n${const JsonEncoder.withIndent('  ').convert(resultJson)}");

    return await db.insert(
      'results_$userId',
      resultJson,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  /// Retrieves all exam results for a specific user.
  Future<List<ResultModel>> getResults() async {
    final db = await database;
    await createUserTable();

    try {
      final List<Map<String, dynamic>> maps = await db.query('results_$userId');
      return maps
          .map((map) {
            try {
              // Use the fromDatabaseJson method from ResultModel
              return ResultModel.fromJson(map);
            } catch (e) {
              print('Error parsing ResultModel: $e');
              return null;
            }
          })
          .whereType<ResultModel>()
          .toList();
    } catch (e) {
      print('Error fetching results: $e');
      return [];
    }
  }

  /// Retrieves a specific exam result by its ID for a given user.
  Future<ResultModel?> getResultById(String examId) async {
    final db = await database;
    await createUserTable(); // This creates the table with proper userId

    try {
      // Add debug prints to track the process
      print('📌 Attempting to fetch result for examId: $examId');
      print('📌 Current userId: $userId');
      print('📌 Table name: results_$userId');

      final List<Map<String, dynamic>> maps = await db.query(
        'results_$userId', // This is correct, using the table with userId
        where: 'examId = ?',
        whereArgs: [examId],
      );

      print('📌 Query result: $maps'); // Debug print

      if (maps.isNotEmpty) {
        try {
          final result = ResultModel.fromJson(maps.first);
          print('📌 Parsed result: $result'); // Debug print
          return result;
        } catch (e) {
          print('Error parsing ResultModel: $e');
          return null;
        }
      }
    } catch (e) {
      print('Error fetching result by ID: $e');
    }

    return null;
  }

  /// Deletes an exam result by its ID for a given user.
  Future<int> deleteResult(String examId) async {
    final db = await database;
    return await db.delete(
      'results_$userId',
      where: 'examId = ?',
      whereArgs: [examId],
    );
  }

  /// Closes the database connection.
  Future<void> close() async {
    final db = await database;
    db.close();
  }
}
