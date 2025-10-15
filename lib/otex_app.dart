import 'package:flutter/material.dart';
import 'package:otex_app/helper/app_strings.dart';
import 'package:otex_app/root.dart';

class OtexApp extends StatelessWidget {
  const OtexApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppStrings.appName,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color(0XFF0062E2)),
        primaryColor: Color(0XFF0062E2),
        fontFamily: AppStrings.fontFamily,
      ),
      home: Directionality(
        textDirection: TextDirection.rtl,
        child: const Root(),
      ),
    );
  }
}
