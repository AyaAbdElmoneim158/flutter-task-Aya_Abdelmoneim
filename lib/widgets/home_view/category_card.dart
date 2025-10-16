import 'package:flutter/material.dart';
import 'package:otex_app/helper/app_colors.dart';
import 'package:otex_app/helper/app_styles.dart';
import 'package:otex_app/models/category.dart';

class CategoryCard extends StatelessWidget {
  final Category category;
  final bool isSelected;

  const CategoryCard(this.category, {super.key, this.isSelected = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected ? AppColors.secondary.withOpacity(0.05) : const Color(0x4DFFFFFF),
        border: Border.all(
          color: const Color(0x1A000000),
          width: 1,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        category.name,
        style: AppStyles.font16GrayBold.copyWith(
          color: isSelected ? AppColors.secondary : AppColors.gray,
        ),
      ),
    );
  }
}
