import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('expenzia.db');
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

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE transactions (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL,
        amount REAL NOT NULL,
        is_income INTEGER NOT NULL,
        category TEXT NOT NULL,
        date TEXT NOT NULL,
        created_at TEXT NOT NULL
      )
    ''');

    // Seed default initial data matching the Figma screen
    final now = DateTime.now().toIso8601String();
    final batch = db.batch();

    batch.insert('transactions', {
      'title': 'Upwork',
      'amount': 850.00,
      'is_income': 1,
      'category': 'Freelance',
      'date': 'Today',
      'created_at': now,
    });

    batch.insert('transactions', {
      'title': 'Transfer',
      'amount': 85.00,
      'is_income': 0,
      'category': 'Transfer',
      'date': 'Yesterday',
      'created_at': now,
    });

    batch.insert('transactions', {
      'title': 'Paypal',
      'amount': 1406.00,
      'is_income': 1,
      'category': 'Income',
      'date': 'Jan 30, 2022',
      'created_at': now,
    });

    batch.insert('transactions', {
      'title': 'Coffee & Snacks',
      'amount': 199.00,
      'is_income': 0,
      'category': 'Food',
      'date': 'Jan 28, 2022',
      'created_at': now,
    });

    await batch.commit(noResult: true);
  }

  Future<int> insert(String table, Map<String, dynamic> data) async {
    final db = await database;
    return await db.insert(table, data);
  }

  Future<List<Map<String, dynamic>>> queryAll(String table) async {
    final db = await database;
    return await db.query(table, orderBy: 'id DESC');
  }

  Future<int> delete(String table, int id) async {
    final db = await database;
    return await db.delete(table, where: 'id = ?', whereArgs: [id]);
  }

  Future<void> close() async {
    final db = _database;
    if (db != null) {
      await db.close();
    }
  }
}
