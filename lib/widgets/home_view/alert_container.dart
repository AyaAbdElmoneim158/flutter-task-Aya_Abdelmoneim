import 'package:flutter/material.dart';
import 'package:otex_app/helper/app_strings.dart';
import 'package:otex_app/helper/app_styles.dart';

class AlertContainer extends StatelessWidget {
  const AlertContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFFF95B1C).withOpacity(0.05),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(Icons.check, color: Color(0xFF3A813F)),
              Text(AppStrings.freeShipping, style: AppStyles.font12BlackRegular.copyWith(color: Color(0xFF3A813F))),
            ],
          ),
          Text(AppStrings.offerNow, style: AppStyles.font12BlackRegular),
        ],
      ),
    );
  }
}
