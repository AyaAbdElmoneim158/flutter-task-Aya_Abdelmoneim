import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:otex_app/helper/app_assets.dart';
import 'package:otex_app/helper/app_colors.dart';
import 'package:otex_app/helper/app_strings.dart';
import 'package:otex_app/helper/app_styles.dart';
import 'package:otex_app/views/filter_view.dart';

class ExploreOffers extends StatelessWidget {
  const ExploreOffers({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(AppStrings.exploreOffers, style: AppStyles.font16BlackMedium),
        GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const FilterView()));
          },
          child: Row(
            children: [
              Text(AppStrings.all, style: AppStyles.font16GrayBold),
              SvgPicture.asset(
                AppAssets.arrowBack,
                width: 16,
                color: AppColors.gray,
              ),
            ],
          ),
        )
      ],
    );
  }
}
