import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:otex_app/helper/app_styles.dart';
import 'package:otex_app/helper/app_strings.dart';
import 'package:otex_app/helper/widgets/custom_btn.dart';

Widget errorStateWidget({
  required BuildContext context,
  required String message,
  required VoidCallback onTap,
  String? buttonText,
  String? imageUrl,
}) {
  return Align(
    alignment: Alignment.center,
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.network(imageUrl ?? "https://cdn-icons-png.flaticon.com/512/2797/2797387.png", width: 70),
          const Gap(12),
          Text(message, style: AppStyles.font16BlackMedium, textAlign: TextAlign.center),
          const Gap(32),
          IntrinsicWidth(child: CustomBtn(label: buttonText ?? AppStrings.retry, onTap: onTap)),
        ],
      ),
    ),
  );
}


  // AppStrings.errorFetchingPlans
  // () => context.read<PlanCubit>().getPlans()