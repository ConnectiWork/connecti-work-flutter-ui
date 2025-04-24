import 'package:flutter/material.dart';
import 'package:feather_icons/feather_icons.dart';
import '../theme/app_colors.dart';

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
      height: 75, // Increased height for better visibility
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(
              20,
              22,
              25,
              0.1,
            ), // Dark color with 10% opacity
            blurRadius: 15,
            offset: const Offset(0, 3),
            spreadRadius: 2,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildNavItem(FeatherIcons.home, 'Home', 0),
            _buildNavItem(FeatherIcons.briefcase, 'Jobs', 1),
            _buildNavItem(FeatherIcons.messageCircle, 'Chat', 2),
            _buildNavItem(FeatherIcons.user, 'Profile', 3),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, int index) {
    final bool isSelected = currentIndex == index;

    // Determine colors based on selection state and index
    final Color iconColor =
        isSelected
            ? (index == 3 ? AppColors.accent : AppColors.primary)
            : AppColors.systemGray;

    final Color bgColor =
        isSelected
            ? (index == 3
                ? Color.fromRGBO(43, 179, 99, 0.15) // Green with 15% opacity
                : Color.fromRGBO(120, 73, 255, 0.15)) // Purple with 15% opacity
            : Colors.transparent;

    final Color textColor =
        isSelected
            ? (index == 3 ? AppColors.accent : AppColors.primary)
            : AppColors.systemGray;

    return InkWell(
      onTap: () => onTap(index),
      child: SizedBox(
        width: 75,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(8), // Increased padding
              decoration: BoxDecoration(
                color: bgColor,
                borderRadius: BorderRadius.circular(12), // Increased radius
              ),
              child: Icon(
                icon,
                color: iconColor,
                size: 22,
              ), // Increased icon size
            ),
            const SizedBox(height: 6), // Increased spacing
            Text(
              label,
              style: TextStyle(
                color: textColor,
                fontSize: 11, // Increased font size
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
