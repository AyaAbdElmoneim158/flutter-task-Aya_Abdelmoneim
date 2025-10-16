import 'dart:convert';

import 'package:otex_app/models/category.dart';
import 'package:otex_app/models/plan.dart';
import 'package:otex_app/models/product.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  _initDatabase() async {
    final documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'otex_app.db');

    return await openDatabase(
      path,
      version: 15,
      onCreate: (db, version) async {
        await _createTables(db);
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion < 15) {
          await db.execute('DROP TABLE IF EXISTS plans');
          await _createTables(db);
        }
      },
    );
  }

  _createTables(Database db) async {
    await db.execute('''
      CREATE TABLE categories (
        id INTEGER PRIMARY KEY,
        name TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE products(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        price REAL NOT NULL,
        oldPrice REAL,
        image TEXT,
        freeShipping INTEGER DEFAULT 0,
        categoryId INTEGER,
        FOREIGN KEY (categoryId) REFERENCES categories (id)
      )
    ''');

    await db.execute('''
      CREATE TABLE plans (
        id INTEGER PRIMARY KEY,
        name TEXT,
        description TEXT,
        price REAL,           
        isSelected INTEGER,
        viewsNumber INTEGER,   
        features TEXT
      )
    ''');
  }

  Future<int> insertCategory(Category category) async {
    final db = await database;
    return await db.insert('categories', category.toMap());
  }

  Future<List<Category>> getAllCategories() async {
    final db = await database;
    final maps = await db.query('categories');
    return List.generate(maps.length, (i) => Category.fromMap(maps[i]));
  }

  Future<int> insertProduct(Product product) async {
    final db = await database;
    return await db.insert('products', product.toMap());
  }

  Future<int> insertPlan(Plan plan) async {
    final db = await database;
    final data = {
      'id': plan.id,
      'name': plan.name,
      'description': plan.description,
      'price': plan.price,
      'isSelected': plan.isSelected ? 1 : 0,
    };

    final featuresJson = jsonEncode(plan.features.map((f) => f.toMap()).toList());
    data['features'] = featuresJson;

    final result = await db.insert('plans', data);
    return result;
  }

  Future<List<Plan>> getAllPlans() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('plans');

    return List.generate(maps.length, (i) {
      final decodedFeatures = jsonDecode(maps[i]['features']) as List;
      final features = decodedFeatures.map((e) => Feature.fromMap(Map<String, dynamic>.from(e))).toList();

      return Plan(
        id: maps[i]['id'],
        name: maps[i]['name'],
        description: maps[i]['description'],
        price: maps[i]['price'],
        isSelected: maps[i]['isSelected'] == 1,
        features: features,
      );
    });
  }

  Future<List<Product>> getAllProducts() async {
    final db = await database;
    final maps = await db.query('products');
    return List.generate(maps.length, (i) => Product.fromMap(maps[i]));
  }

  Future<List<Product>> getProductsByCategory(int categoryId) async {
    final db = await database;
    final maps = await db.query(
      'products',
      where: 'categoryId = ?',
      whereArgs: [categoryId],
    );
    return List.generate(maps.length, (i) => Product.fromMap(maps[i]));
  }

  Future close() async {
    final db = await database;
    db.close();
  }
}
