import 'package:flutter/material.dart';
import 'package:otex_app/helper/app_assets.dart';
import 'package:otex_app/helper/app_colors.dart';
import 'package:otex_app/helper/app_strings.dart';
import 'package:otex_app/helper/app_styles.dart';
import 'package:otex_app/views/package_view.dart';
import 'package:otex_app/views/home_view.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Root extends StatefulWidget {
  const Root({super.key});

  @override
  State<Root> createState() => _RootState();
}

class _RootState extends State<Root> {
  late PageController controller;
  late List<Widget> screens;
  int currentScreen = 0;

  @override
  void initState() {
    screens = [
      HomeView(),
      Scaffold(backgroundColor: Colors.white, body: Center(child: Text(AppStrings.home))),
      Scaffold(backgroundColor: Colors.white, body: Center(child: Text(AppStrings.addAd))),
      Scaffold(backgroundColor: Colors.white, body: Center(child: Text(AppStrings.myAds))),
      PackageView(),
    ];
    controller = PageController(initialPage: currentScreen);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: controller,
        physics: NeverScrollableScrollPhysics(),
        children: screens,
      ),
      bottomNavigationBar: Container(
        decoration: AppStyles.bottomNavigationBarBoxDecoration,
        child: BottomNavigationBar(
          elevation: 0,
          backgroundColor: Colors.white,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: AppColors.black,
          unselectedItemColor: Colors.grey.shade500.withOpacity(0.7),
          currentIndex: currentScreen,
          selectedLabelStyle: TextStyle(color: currentScreen == 2 ? AppColors.primary : AppColors.black),
          unselectedLabelStyle: TextStyle(color: currentScreen == 2 ? AppColors.primary : AppColors.gray),
          showSelectedLabels: true,
          onTap: (index) {
            setState(() => currentScreen = index);
            controller.jumpToPage(currentScreen);
          },
          items: [
            BottomNavigationBarItem(icon: SvgPicture.asset(AppAssets.bungalow), label: AppStrings.home),
            BottomNavigationBarItem(icon: SvgPicture.asset(AppAssets.chat), label: AppStrings.chat),
            BottomNavigationBarItem(icon: SvgPicture.asset(AppAssets.addBox), label: AppStrings.addAd),
            BottomNavigationBarItem(icon: SvgPicture.asset(AppAssets.dataset), label: AppStrings.myAds),
            BottomNavigationBarItem(icon: SvgPicture.asset(AppAssets.accountCircle), label: AppStrings.myAccount),
          ],
        ),
      ),
    );
  }
}
