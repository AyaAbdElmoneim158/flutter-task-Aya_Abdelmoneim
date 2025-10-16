import 'package:flutter/material.dart';
import 'package:otex_app/helper/app_colors.dart';
import 'package:otex_app/helper/app_styles.dart';

class CustomBtn extends StatelessWidget {
  final String label;
  final VoidCallback? onTap;
  final Color? color;

  const CustomBtn({
    super.key,
    required this.label,
    this.onTap,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: 8),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: AppStyles.customBtnBoxDecoration.copyWith(
          color: color ?? AppColors.primary,
        ),
        child: Center(
          child: Text(
            label,
            style: AppStyles.font16GrayBold.copyWith(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
