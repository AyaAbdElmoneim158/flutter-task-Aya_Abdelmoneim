import 'package:flutter/material.dart';
import 'package:otex_app/helper/app_colors.dart';
import 'package:otex_app/helper/app_strings.dart';
import 'package:otex_app/helper/app_styles.dart';

class SpecialPlan extends StatelessWidget {
  const SpecialPlan({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(8),
      decoration: AppStyles.specialPlanBoxDecoration,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(AppStrings.customPackages, style: AppStyles.font14BlackMedium),
          Text(AppStrings.contactForPackage, style: AppStyles.font12BlackRegular),
          Text(AppStrings.salesTeam, style: AppStyles.font16GrayBold.copyWith(color: AppColors.primary)),
        ],
      ),
    );
  }
}
