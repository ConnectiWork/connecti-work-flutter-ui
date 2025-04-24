import 'package:flutter/material.dart';
import '../models/job_location.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

class SimpleMap extends StatelessWidget {
  final List<JobLocation> locations;
  final String selectedLocationId;
  final Function(String) onLocationSelected;

  const SimpleMap({
    super.key,
    required this.locations,
    required this.selectedLocationId,
    required this.onLocationSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFE8F0FE),
      child: Stack(
        children: [
          // Morocco map outline (simplified)
          Center(
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                color: AppColors.primary.withAlpha(20),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Center(
                child: Text(
                  "Morocco",
                  style: TextStyle(
                    color: AppColors.primary,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),

          // Location pins
          ...locations.map((location) => _buildLocationPin(
                context,
                location,
                isSelected: location.id == selectedLocationId,
                onTap: () => onLocationSelected(location.id),
              )),
        ],
      ),
    );
  }

  Widget _buildLocationPin(
    BuildContext context,
    JobLocation location, {
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    // Calculate position based on screen size and coordinates
    // This is a simplified approach - in a real app, you'd use proper geo mapping
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // Morocco's approximate bounds
    const double northLat = 35.9;
    const double southLat = 27.7;
    const double westLng = -13.2;
    const double eastLng = -1.0;

    // Calculate position as percentage of screen
    final double latRange = northLat - southLat;
    final double lngRange = eastLng - westLng;

    final double x = ((location.position.longitude - westLng) / lngRange) * screenWidth;
    final double y = ((northLat - location.position.latitude) / latRange) * screenHeight;

    return Positioned(
      left: x,
      top: y,
      child: GestureDetector(
        onTap: onTap,
        child: Column(
          children: [
            Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                color: location.color,
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.white,
                  width: 2,
                ),
                boxShadow: [
                  BoxShadow(
                    color: location.color.withAlpha(102),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: const Icon(
                Icons.location_on,
                color: Colors.white,
                size: 24,
              ),
            ),
            const SizedBox(height: 4),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 4,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withAlpha(20),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Text(
                    location.city,
                    style: AppTextStyles.bodySmall.copyWith(
                      fontWeight: FontWeight.bold,
                      color: location.color,
                    ),
                  ),
                  Text(
                    location.jobCount,
                    style: AppTextStyles.caption,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
