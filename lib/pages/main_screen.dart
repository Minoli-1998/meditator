import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:meditator/pages/main_screens/create_custom_exercise_page.dart';
import 'package:meditator/pages/main_screens/custom_exercise_page.dart';
import 'package:meditator/pages/main_screens/home_page.dart';
import 'package:meditator/pages/main_screens/mindfull_exercise_page.dart';
import 'package:meditator/pages/main_screens/profile_page.dart';
import 'package:meditator/utils/colors.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _pageIndex = 0;

  static const List<Widget> _pages = [
    HomePage(),
    MindfullExercisePage(),
    CreateCustomExercisePage(),
    CustomExercisePage(),
    ProfilePage(),
  ];

  void _onClickPage(int index) {
    setState(() {
      _pageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadiusGeometry.circular(100),
        child: BottomNavigationBar(
          currentIndex: _pageIndex,
          onTap: _onClickPage,
          items: [
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/icons/home.svg',
                colorFilter: ColorFilter.mode(
                  _pageIndex == 0
                      ? AppColors.primaryPurple
                      : AppColors.primaryGrey,
                  BlendMode.srcIn,
                ),
                semanticsLabel: 'home svg',
              ),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/icons/brain.svg',
                colorFilter: ColorFilter.mode(
                  _pageIndex == 1
                      ? AppColors.primaryPurple
                      : AppColors.primaryGrey,
                  BlendMode.srcIn,
                ),
                semanticsLabel: 'Meditation svg',
              ),
              label: "Meditation",
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/icons/circle-plus.svg',
                colorFilter: ColorFilter.mode(
                  _pageIndex == 2
                      ? AppColors.primaryPurple
                      : AppColors.primaryGrey,
                  BlendMode.srcIn,
                ),
                semanticsLabel: "Create svg",
              ),
              label: "Create",
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/icons/file-plus-2.svg',
                colorFilter: ColorFilter.mode(
                  _pageIndex == 3
                      ? AppColors.primaryPurple
                      : AppColors.primaryGrey,
                  BlendMode.srcIn,
                ),
                semanticsLabel: "Cuustom svg",
              ),
              label: "Custom",
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/icons/user-round-cog.svg',
                colorFilter: ColorFilter.mode(
                  _pageIndex == 4
                      ? AppColors.primaryPurple
                      : AppColors.primaryGrey,
                  BlendMode.srcIn,
                ),
                semanticsLabel: "Profile svg",
              ),
              label: "Profile",
            ),
          ],
          selectedItemColor: AppColors.primaryPurple,
          unselectedItemColor: AppColors.primaryGrey,
        ),
      ),

      body: _pages[_pageIndex],
    );
  }
}
