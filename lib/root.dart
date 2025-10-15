import 'package:flutter/material.dart';
import 'package:otex_app/helper/app_assets.dart';
import 'package:otex_app/helper/app_colors.dart';
import 'package:otex_app/views/account_view.dart';
import 'package:otex_app/views/filter_view.dart';
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
      // FilterView(),
      HomeView(),
      AccountView(),

      Scaffold(backgroundColor: Colors.white, body: Center(child: Text("محادثة"))),
      Scaffold(backgroundColor: Colors.white, body: Center(child: Text("أضف أعلان"))),
      Scaffold(backgroundColor: Colors.white, body: Center(child: Text("أعلاناتى"))),
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
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(color: const Color(0xFF000000).withOpacity(0.1), width: 1),
          ),
        ),
        child: BottomNavigationBar(
          elevation: 0,
          // enableFeedback: false,
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
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                AppAssets.bungalow,
                color: currentScreen == 0 ? AppColors.black : AppColors.gray,
              ),
              label: 'الرئيسية',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                AppAssets.chat,
                color: currentScreen == 1 ? AppColors.black : AppColors.gray,
              ),
              label: 'محادثة',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                AppAssets.addBox,
                color: AppColors.primary,
              ),
              label: 'أضف أعلان',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                AppAssets.dataset,
                color: currentScreen == 3 ? AppColors.black : AppColors.gray,
              ),
              label: 'أعلاناتى',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                AppAssets.accountCircle,
                color: currentScreen == 4 ? AppColors.black : AppColors.gray,
              ),
              label: 'حسابى',
            ),
          ],
        ),
      ),
    );
  }
}
