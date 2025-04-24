import 'package:flutter/material.dart';
import 'package:feather_icons/feather_icons.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const BottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow.withAlpha(10),
            blurRadius: 6,
            offset: const Offset(0, -1),
          ),
        ],
        border: Border(
          top: BorderSide(color: AppColors.systemGray5, width: 0.5),
        ),
      ),
      child: ClipRRect(
        child: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: onTap,
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          selectedItemColor: AppColors.primary,
          unselectedItemColor: AppColors.systemGray,
          selectedLabelStyle: AppTextStyles.caption.copyWith(
            fontWeight: FontWeight.w500,
            fontSize: 10, // iOS tab bar label size
          ),
          unselectedLabelStyle: AppTextStyles.caption.copyWith(
            fontWeight: FontWeight.w500,
            fontSize: 10, // iOS tab bar label size
          ),
          elevation: 0,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(FeatherIcons.home),
              activeIcon: Icon(FeatherIcons.home, color: AppColors.primary),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(FeatherIcons.briefcase),
              activeIcon: Icon(
                FeatherIcons.briefcase,
                color: AppColors.primary,
              ),
              label: 'Discover',
            ),
            BottomNavigationBarItem(
              icon: Icon(FeatherIcons.messageCircle),
              activeIcon: Icon(
                FeatherIcons.messageCircle,
                color: AppColors.primary,
              ),
              label: 'Messages',
            ),
            BottomNavigationBarItem(
              icon: Icon(FeatherIcons.user),
              activeIcon: Icon(FeatherIcons.user, color: AppColors.primary),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
