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

    for (var plan in Plan.samplePlans) {
      await db.insertPlan(plan);
    }

    for (var category in Category.categories) {
      await db.insertCategory(category);
    }

    for (var product in Product.sampleProducts) {
      await db.insertProduct(product);
    }
  } catch (e) {
    // Silent error handling - or handle as needed for production
  }

  runApp(const OtexApp());
}
