import 'package:flutter/material.dart';
import 'package:otex_app/helper/app_colors.dart';

class CustomDivider extends StatelessWidget {
  const CustomDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Divider(color: AppColors.black.withOpacity(0.1));
  }
}
