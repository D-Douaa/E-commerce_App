
import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

class AppBottomNavbar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const AppBottomNavbar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  static const List<IconData> icons = [
    Icons.home_outlined,
    Icons.search,
    Icons.shopping_cart_outlined,
    Icons.local_offer_outlined,
    Icons.person_outline,
  ];

  static const List<String> labels = [
    'Home',
    'Explore',
    'Cart',
    'Offer',
    'Account',
  ];

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      type: BottomNavigationBarType.fixed,
      backgroundColor: AppColors.background,
      selectedItemColor: AppColors.primary,
      unselectedItemColor: AppColors.textSecondary,
      selectedFontSize: 10,
      unselectedFontSize: 10,
      showSelectedLabels: true,
      showUnselectedLabels: true,
      elevation: 2,
      items: List.generate(
        icons.length,
        (index) => BottomNavigationBarItem(
          icon: Icon(icons[index]),
          label: labels[index],
        ),
      ),
    );
  }
}
