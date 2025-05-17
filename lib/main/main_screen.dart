import 'package:bookia/core/constants/assets_manager.dart';
import 'package:bookia/core/utils/app_colors.dart';
import 'package:bookia/feature/cart/presentation/page/cart_screen.dart';
import 'package:bookia/feature/home/presentation/page/home_screen.dart';
import 'package:bookia/feature/profile/presentation/page/profile_screen.dart';
import 'package:bookia/feature/wishlist/presentation/page/wishlist_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class MainAppScreen extends StatefulWidget {
  const MainAppScreen({super.key});

  @override
  State<MainAppScreen> createState() => _MainAppScreenState();
}

class _MainAppScreenState extends State<MainAppScreen> {
  int currentIndex = 0;
  List<Widget> screens = [
    HomeScreen(),
    WishlistScreen(),
    CartScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: AppColors.accentColor,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset(AssetsManager.home),
            activeIcon: SvgPicture.asset(
              AssetsManager.home,
              colorFilter: const ColorFilter.mode(
                AppColors.primaryColor,
                BlendMode.srcIn,
              ),
            ),
            label: 'home',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(AssetsManager.bookmark),
            activeIcon: SvgPicture.asset(
              AssetsManager.bookmark,
              colorFilter: const ColorFilter.mode(
                AppColors.primaryColor,
                BlendMode.srcIn,
              ),
            ),
            label: 'bookmark',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(AssetsManager.category),
            activeIcon: SvgPicture.asset(
              AssetsManager.category,
              colorFilter: const ColorFilter.mode(
                AppColors.primaryColor,
                BlendMode.srcIn,
              ),
            ),
            label: 'category',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(AssetsManager.profile),
            activeIcon: SvgPicture.asset(
              AssetsManager.profile,
              colorFilter: const ColorFilter.mode(
                AppColors.primaryColor,
                BlendMode.srcIn,
              ),
            ),
            label: 'profile',
          ),
        ],
      ),
    );
  }
}
