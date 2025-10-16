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
    await db.debugTableSchema();
    // Insert plans
    for (var plan in Plan.samplePlans) {
      final id = await db.insertPlan(plan);
      debugPrint('✓ Successfully inserted plan: ${plan.name} with id: $id');
    }

    // Insert categories
    for (var category in Category.categories) {
      final id = await db.insertCategory(category);
      debugPrint('✓ Successfully inserted category: ${category.name} with id: $id');
    }

    // Insert products
    for (var product in Product.sampleProducts) {
      final id = await db.insertProduct(product);
      debugPrint('✓ Successfully inserted product: ${product.name} with id: $id');
    }

    debugPrint('All data inserted successfully!');

    // Verify insertion by reading back
    final plans = await db.getAllPlans();
    final categories = await db.getAllCategories();

    debugPrint('Total plans in database: ${plans.length}');
    debugPrint('Total categories in database: ${categories.length}');

    // Test getting products by category
    for (var category in categories) {
      final products = await db.getProductsByCategory(category.id!);
      debugPrint('Category "${category.name}" has ${products.length} products');
    }
  } catch (e) {
    debugPrint('Fatal error during app startup: $e');
    debugPrint('Stack trace: ${StackTrace.current}');
  }

  runApp(const OtexApp());
}
