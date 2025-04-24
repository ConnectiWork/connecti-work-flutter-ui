import 'package:flutter/material.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow.withAlpha(20),
            blurRadius: 10,
            offset: const Offset(0, 2),
            spreadRadius: 1,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: onTap,
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          selectedItemColor: AppColors.primary,
          unselectedItemColor: AppColors.systemGray,
          selectedLabelStyle: AppTextStyles.caption.copyWith(
            fontWeight: FontWeight.w600,
            fontSize: 11,
          ),
          unselectedLabelStyle: AppTextStyles.caption.copyWith(
            fontWeight: FontWeight.w500,
            fontSize: 10,
          ),
          elevation: 0,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          landscapeLayout: BottomNavigationBarLandscapeLayout.centered,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(FeatherIcons.home),
              activeIcon: Icon(FeatherIcons.home, color: AppColors.primary),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.briefcase, size: 20),
              activeIcon: Icon(
                FontAwesomeIcons.briefcase,
                color: AppColors.primary,
                size: 20,
              ),
              label: 'Jobs',
            ),
            BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.solidComment, size: 20),
              activeIcon: Icon(
                FontAwesomeIcons.solidComment,
                color: AppColors.primary,
                size: 20,
              ),
              label: 'Chat',
            ),
            BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.solidUser, size: 20),
              activeIcon: Icon(
                FontAwesomeIcons.solidUser,
                color: AppColors.primary,
                size: 20,
              ),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
