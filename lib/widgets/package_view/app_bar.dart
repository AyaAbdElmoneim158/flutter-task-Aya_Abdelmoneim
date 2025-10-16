import 'package:flutter/material.dart';
import 'package:otex_app/helper/app_strings.dart';
import 'package:otex_app/helper/app_styles.dart';

class PackageViewAppBar extends StatelessWidget implements PreferredSizeWidget {
  const PackageViewAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(76);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      scrolledUnderElevation: 0,
      backgroundColor: Colors.white,
      toolbarHeight: 76,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(AppStrings.choosePackages, style: AppStyles.font24BlackMedium),
          Text(AppStrings.chooseFromPackages, style: AppStyles.font14BlackRegular),
        ],
      ),
    );
  }
}
