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
      onOpen: (db) async {
        await _ensureCreditsTable(db);
        await _ensureProfileTable(db);
      },
    );
  }

  Future<void> _ensureCreditsTable(Database db) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS credits (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        credit_type TEXT NOT NULL,
        to_name TEXT NOT NULL,
        amount REAL NOT NULL,
        due_date TEXT NOT NULL,
        plan_type TEXT NOT NULL,
        created_at TEXT NOT NULL
      )
    ''');

    final count = Sqflite.firstIntValue(
      await db.rawQuery('SELECT COUNT(*) FROM credits'),
    );
    if (count == null || count == 0) {
      final now = DateTime.now().toIso8601String();
      final batch = db.batch();
      batch.insert('credits', {
        'credit_type': 'Subscriptions',
        'to_name': 'Netflix',
        'amount': 850.00,
        'due_date': 'Due Today',
        'plan_type': 'Monthly',
        'created_at': now,
      });
      batch.insert('credits', {
        'credit_type': 'Subscriptions',
        'to_name': 'Rohith',
        'amount': 18500.00,
        'due_date': 'Due on 10/12/26',
        'plan_type': 'One-time',
        'created_at': now,
      });
      batch.insert('credits', {
        'credit_type': 'Bills',
        'to_name': 'Electricity Bill',
        'amount': 850.00,
        'due_date': 'Due on 05/11/26',
        'plan_type': 'Monthly',
        'created_at': now,
      });
      batch.insert('credits', {
        'credit_type': 'Insurance',
        'to_name': 'Health Insurance',
        'amount': 21000.00,
        'due_date': 'Due on 01/01/27',
        'plan_type': 'Yearly',
        'created_at': now,
      });
      await batch.commit(noResult: true);
    }
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

  Future<void> _ensureProfileTable(Database db) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS user_profile (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        avatar_path TEXT
      )
    ''');

    final count = Sqflite.firstIntValue(
      await db.rawQuery('SELECT COUNT(*) FROM user_profile'),
    );
    if (count == null || count == 0) {
      await db.insert('user_profile', {
        'name': 'Sahal Muhammed',
        'avatar_path': 'assets/images/profile_avatar.png',
      });
    }
  }

  Future<Map<String, dynamic>?> getProfile() async {
    final db = await database;
    final results = await db.query('user_profile', limit: 1);
    return results.isNotEmpty ? results.first : null;
  }

  Future<int> updateProfileName(String name) async {
    final db = await database;
    return await db.update(
      'user_profile',
      {'name': name},
      where: 'id = 1',
    );
  }

  Future<void> clearAllStorage() async {
    final db = await database;
    await db.delete('transactions');
    await db.delete('credits');
    await db.update('user_profile', {'name': 'Sahal Muhammed'});
  }

  Future<int> delete(String table, int id) async {
    final db = await database;
    return await db.delete(table, where: 'id = ?', whereArgs: [id]);
  }

  Future<int> update(String table, Map<String, dynamic> data, int id) async {
    final db = await database;
    return await db.update(table, data, where: 'id = ?', whereArgs: [id]);
  }

  Future<void> close() async {
    final db = _database;
    if (db != null) {
      await db.close();
    }
  }
}
