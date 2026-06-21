import 'package:cosmetics_app/features/cart/presentation/cart_screen.dart';
import 'package:cosmetics_app/features/categories/presentation/categories_screen.dart';
import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/widgets/app_image.dart';
import '../home/presentation/home_screen.dart';
import '../profile/presentation/profile_screen.dart';

class MainLayoutScreen extends StatefulWidget {
  const MainLayoutScreen({super.key,});

  @override
  State<MainLayoutScreen> createState() => _MainLayoutScreenState();
}

class _MainLayoutScreenState extends State<MainLayoutScreen> {
  int currentIndex = 0;

  List<Widget> get screens => [
    const HomeScreen(),
    const CategoriesScreen(),
    const CartScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,

      body: screens[currentIndex],

      bottomNavigationBar: Container(
        margin: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
        padding: const EdgeInsets.symmetric(vertical: 15),
        decoration: BoxDecoration(
          color: AppColors.background,
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 6,
              offset: const Offset(-4, -4),
            ),
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 4,
              offset: const Offset(4, 4),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem(icon: "home_icon.svg", index: 0),
            _buildNavItem(icon: "categories_icon.svg", index: 1),
            _buildNavItem(icon: "cart_icon.svg", index: 2),
            _buildNavItem(icon: "profile_icon.svg", index: 3),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem({required String icon, required int index}) {
    bool isSelected = currentIndex == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          currentIndex = index;
        });
      },
      child: Container(
        color: Colors.transparent,
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        child: AppImage(
          icon,
          height: 24,
          width: 24,
          color: isSelected ? AppColors.primaryButton : AppColors.secondaryText,
        ),
      ),
    );
  }
}
