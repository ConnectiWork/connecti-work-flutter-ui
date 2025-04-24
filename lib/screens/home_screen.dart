import 'package:flutter/material.dart';
import 'package:feather_icons/feather_icons.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';
import '../widgets/custom_card.dart';
import '../widgets/google_maps_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void _onLocationSelected(Map<String, dynamic> location) {
    // Location selection is now handled directly in the GoogleMapsWidget
    // which shows a bottom sheet with jobs for the selected city
    debugPrint(
      'Selected location: ${location['name']} with ${location['jobCount']} jobs',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Google Maps
          Positioned.fill(
            child: GoogleMapsWidget(onLocationSelected: _onLocationSelected),
          ),

          // Top Bar with User Stats
          Positioned(
            top: 50,
            left: 20,
            right: 20,
            child: CustomCard(
              elevation: 2,
              borderRadius: 16,
              backgroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: AppColors.primary, // Purple
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      FeatherIcons.user,
                      color: Colors.white,
                      size: 18,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Welcome, Ahmed',
                          style: AppTextStyles.bodyLarge.copyWith(
                            fontWeight: FontWeight.w600,
                            color: AppColors.dark, // Using dark color (#141619)
                          ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            const Icon(
                              FeatherIcons.briefcase,
                              color: AppColors.accent, // Green
                              size: 12,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              'Web Developer',
                              style: AppTextStyles.caption.copyWith(
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: AppColors.accent.withAlpha(
                        40,
                      ), // Green with opacity
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      FeatherIcons.bell,
                      color: AppColors.accent, // Green
                      size: 16,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Search Bar
          Positioned(
            top: 130,
            left: 20,
            right: 20,
            child: CustomCard(
              elevation: 1,
              borderRadius: 16,
              backgroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [
                  const Icon(
                    FeatherIcons.search,
                    color: AppColors.primary, // Purple
                    size: 18,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Search for jobs in Morocco',
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ),
                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: AppColors.dark.withAlpha(10), // Dark with opacity
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(
                      FeatherIcons.sliders,
                      color: AppColors.dark, // Dark
                      size: 16,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
