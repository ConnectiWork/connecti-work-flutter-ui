import 'package:flutter/material.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';
import '../widgets/custom_card.dart';
import '../widgets/custom_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Map View (Placeholder)
          Container(
            color: const Color(0xFFE8F0FE),
            child: Stack(
              children: [
                // Center map icon
                const Center(
                  child: FaIcon(
                    FontAwesomeIcons.map,
                    size: 80,
                    color: AppColors.primary,
                  ),
                ),

                // Map location pins
                Positioned(
                  top: 150,
                  left: 100,
                  child: _buildMapPin(
                    'Casablanca',
                    '124 jobs',
                    AppColors.primary,
                  ),
                ),
                Positioned(
                  top: 200,
                  right: 120,
                  child: _buildMapPin(
                    'Rabat',
                    '87 jobs',
                    AppColors.moroccanBlue,
                  ),
                ),
                Positioned(
                  bottom: 250,
                  left: 150,
                  child: _buildMapPin(
                    'Marrakech',
                    '56 jobs',
                    AppColors.moroccanRed,
                  ),
                ),
                Positioned(
                  bottom: 300,
                  right: 80,
                  child: _buildMapPin(
                    'Tangier',
                    '42 jobs',
                    AppColors.moroccanYellow,
                  ),
                ),
              ],
            ),
          ),

          // These are duplicate pins for the background - we'll remove them
          // since we already have pins in the map placeholder

          // Top Bar with User Stats
          Positioned(
            top: 50,
            left: 20,
            right: 20,
            child: CustomCard(
              elevation: 4,
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 25,
                    backgroundColor: AppColors.primary,
                    child: Icon(
                      FeatherIcons.user,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Welcome, Ahmed', style: AppTextStyles.heading4),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            const FaIcon(
                              FontAwesomeIcons.solidStar,
                              color: AppColors.moroccanYellow,
                              size: 14,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '4.8',
                              style: AppTextStyles.bodyMedium.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(width: 12),
                            const Icon(
                              FeatherIcons.briefcase,
                              color: AppColors.primary,
                              size: 14,
                            ),
                            const SizedBox(width: 4),
                            Text('12 Jobs', style: AppTextStyles.bodyMedium),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withAlpha(25),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      FeatherIcons.bell,
                      color: AppColors.primary,
                      size: 20,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Filter Bar
          Positioned(
            top: 140,
            left: 20,
            right: 20,
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.shadow,
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  const SizedBox(width: 16),
                  const Icon(
                    FeatherIcons.search,
                    color: AppColors.primary,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Search for jobs in Morocco',
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.textLight,
                      ),
                    ),
                  ),
                  Container(height: 36, width: 1, color: AppColors.divider),
                  const SizedBox(width: 8),
                  const Icon(
                    FeatherIcons.sliders,
                    color: AppColors.primary,
                    size: 20,
                  ),
                  const SizedBox(width: 16),
                ],
              ),
            ),
          ),

          // Job Clusters
          Positioned(
            bottom: 100,
            left: 20,
            right: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Job Opportunities Nearby', style: AppTextStyles.heading4),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: _buildJobCluster(
                        'Casablanca',
                        '124 jobs',
                        AppColors.primary,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildJobCluster(
                        'Rabat',
                        '87 jobs',
                        AppColors.moroccanBlue,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: _buildJobCluster(
                        'Marrakech',
                        '56 jobs',
                        AppColors.moroccanRed,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildJobCluster(
                        'Tangier',
                        '42 jobs',
                        AppColors.moroccanGreen,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMapPin(String title, String subtitle, Color color) {
    return Column(
      children: [
        Container(
          height: 40,
          width: 40,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white, width: 2),
            boxShadow: [
              BoxShadow(
                color: color.withAlpha(102),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: const Icon(
            FeatherIcons.briefcase,
            color: Colors.white,
            size: 18,
          ),
        ),
        const SizedBox(height: 4),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
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
                title,
                style: AppTextStyles.bodySmall.copyWith(
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
              Text(subtitle, style: AppTextStyles.caption),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildJobCluster(String location, String jobCount, Color color) {
    return CustomCard(
      elevation: 2,
      borderRadius: 12,
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                height: 36,
                width: 36,
                decoration: BoxDecoration(
                  color: color.withAlpha(25),
                  shape: BoxShape.circle,
                ),
                child: Icon(FeatherIcons.mapPin, color: color, size: 18),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  location,
                  style: AppTextStyles.bodyLarge.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            jobCount,
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 8),
          CustomButton(
            text: 'View Jobs',
            onPressed: () {},
            type: ButtonType.secondary,
            height: 36,
            isFullWidth: true,
          ),
        ],
      ),
    );
  }
}
