import 'package:flutter/material.dart';
import 'package:otex_app/helper/app_colors.dart';

class AppStyles {
  static TextStyle font16BlackMedium = TextStyle(
    color: AppColors.black,
    fontWeight: FontWeight.w500,
    fontSize: 16,
  );
  static TextStyle font16GrayBold = TextStyle(
    color: AppColors.gray,
    fontWeight: FontWeight.w700,
    fontSize: 16,
  );
  static TextStyle font12BlackRegular = TextStyle(
    color: AppColors.black,
    fontWeight: FontWeight.w400,
    fontSize: 12,
  );
  static TextStyle font14BlackMedium = TextStyle(
    color: AppColors.black,
    fontWeight: FontWeight.w500,
    fontSize: 14,
  );
  static TextStyle font10BlackRegular = TextStyle(
    color: AppColors.black.withOpacity(0.50),
    fontWeight: FontWeight.w400,
    fontSize: 10,
  );
  static TextStyle font24BlackMedium = TextStyle(
    color: AppColors.black,
    fontWeight: FontWeight.w500,
    fontSize: 24,
  );
  static TextStyle font14BlackRegular = TextStyle(
    color: AppColors.black.withOpacity(0.50),
    fontWeight: FontWeight.w400,
    fontSize: 14,
  );

  static BoxDecoration bottomNavigationBarBoxDecoration = BoxDecoration(
    border: Border(
      top: BorderSide(
        color: const Color(0xFF000000).withOpacity(0.1),
        width: 1,
      ),
    ),
  );
  static BoxDecoration specialPlanBoxDecoration = BoxDecoration(
    color: const Color(0xFFF7F7F7),
    borderRadius: BorderRadius.circular(8),
    border: Border.all(
      color: const Color(0xFF000000).withOpacity(0.05),
      width: 1,
    ),
  );
  static BoxDecoration customBtnBoxDecoration = BoxDecoration(
    color: AppColors.lightPrimary,
    borderRadius: BorderRadius.circular(32),
  );

  static BoxDecoration planCardBoxDecoration = BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(8),
    border: Border.all(
      color: const Color(0x1A000000),
      width: 1,
    ),
    boxShadow: const [
      BoxShadow(
        color: Color(0x0A090F1F),
        offset: Offset(0, 4),
        blurRadius: 5,
      ),
    ],
  );
  static BoxDecoration planViewsNumberBoxDecoration = BoxDecoration(
    color: const Color(0xFF3A813F).withOpacity(0.05),
    border: const Border(
      top: BorderSide(
        width: 1,
        color: Color(0xFF3A813F),
      ),
      right: BorderSide(
        width: 1,
        color: Color(0xFF3A813F),
      ),
      left: BorderSide(
        width: 1,
        color: Color(0xFF3A813F),
      ),
      bottom: BorderSide.none,
    ),
    borderRadius: const BorderRadius.only(
      topLeft: Radius.circular(32),
      topRight: Radius.circular(32),
    ),
  );
}
