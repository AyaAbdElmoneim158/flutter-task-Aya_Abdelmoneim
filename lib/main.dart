import 'package:flutter/material.dart';
import 'package:otex_app/helper/database_helper.dart';
import 'package:otex_app/models/category.dart';
import 'package:otex_app/models/plan.dart';
import 'package:otex_app/models/product.dart';
import 'package:otex_app/otex_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    final db = DatabaseHelper();
    await db.database;

    // Debug: Check table schema
    await db.debugTableSchema();

    print('Starting database initialization...');

    // Insert plans
    print('Inserting plans...');
    for (var plan in Plan.samplePlans) {
      print('Processing plan: ${plan.name}');
      final id = await db.insertPlan(plan);
      print('✓ Successfully inserted plan: ${plan.name} with id: $id');
    }

    // Insert categories
    print('Inserting categories...');
    for (var category in Category.categories) {
      print('Processing category: ${category.name}');
      final id = await db.insertCategory(category);
      print('✓ Successfully inserted category: ${category.name} with id: $id');
    }

    // // Insert products
    print('Inserting products...');
    for (var product in Product.sampleProducts) {
      print('Processing product: ${product.name}');
      final id = await db.insertProduct(product);
      print('✓ Successfully inserted product: ${product.name} with id: $id');
    }

    print('All data inserted successfully!');

    // Verify insertion by reading back
    final plans = await db.getAllPlans();
    final categories = await db.getAllCategories();

    print('Total plans in database: ${plans.length}');
    print('Total categories in database: ${categories.length}');

    // Test getting products by category
    for (var category in categories) {
      final products = await db.getProductsByCategory(category.id!);
      print('Category "${category.name}" has ${products.length} products');
    }
  } catch (e) {
    print('Fatal error during app startup: $e');
    print('Stack trace: ${StackTrace.current}');
  }

  runApp(const OtexApp());
}
