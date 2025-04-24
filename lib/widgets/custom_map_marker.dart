import 'package:flutter/material.dart';
import 'package:feather_icons/feather_icons.dart';
import '../theme/app_colors.dart';

class CustomMapMarker extends StatelessWidget {
  final IconData icon;
  final Color color;
  final double size;
  final String label;

  const CustomMapMarker({
    super.key,
    required this.icon,
    this.color = Colors.purple,
    this.size = 40,
    this.label = '',
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Icon(
            icon,
            color: color,
            size: size,
          ),
        ),
        if (label.isNotEmpty)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            margin: const EdgeInsets.only(top: 4),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 3,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            child: Text(
              label,
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ),
      ],
    );
  }
}

// Factory methods for common marker types
class MapMarkers {
  // City marker with map-pin icon
  static Widget cityMarker(String cityName) {
    return CustomMapMarker(
      icon: FeatherIcons.mapPin,
      color: AppColors.primary,
      label: cityName,
    );
  }
  
  // Job marker with target icon
  static Widget jobMarker(String jobTitle) {
    return CustomMapMarker(
      icon: FeatherIcons.target,
      color: AppColors.primary,
      label: jobTitle,
    );
  }
}
