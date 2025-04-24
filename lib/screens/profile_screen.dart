import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';
import '../widgets/custom_card.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.dark,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Top Navigation Bar
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () {
                        // Handle back button
                      },
                    ),
                    IconButton(
                      icon: const Icon(
                        FeatherIcons.moreHorizontal,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        // Handle options menu
                      },
                    ),
                  ],
                ),
              ),

              // Profile Header
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    // Profile Picture
                    Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Image.network(
                          'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NHx8ZmFjZXxlbnwwfHwwfHx8MA%3D%3D&auto=format&fit=crop&w=800&q=60',
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return const CircleAvatar(
                              backgroundColor: Colors.white24,
                              child: Icon(
                                Icons.person,
                                size: 50,
                                color: Colors.white,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Name and Job Title
                    Text(
                      "Ahmed Khalid",
                      style: AppTextStyles.heading2.copyWith(
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.accent,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        'Event Staff • Waiter',
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Location only
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.location_on,
                          color: Colors.white70,
                          size: 16,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          'Casablanca, Morocco',
                          style: AppTextStyles.bodyMedium.copyWith(
                            color: Colors.white70,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    const SizedBox(height: 8),

                    // Removed the action buttons as requested
                    const SizedBox(height: 8),
                  ],
                ),
              ),

              // Profile Stats
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    Expanded(
                      child: _buildStatCard('12 jobs', [
                        'https://images.unsplash.com/photo-1517841905240-472988babdf9?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTJ8fHByb2ZpbGUlMjBwaWN0dXJlfGVufDB8fDB8fHww&auto=format&fit=crop&w=800&q=60',
                        'https://images.unsplash.com/photo-1539571696357-5a69c17a67c6?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Nnx8bWFufGVufDB8fDB8fHww&auto=format&fit=crop&w=800&q=60',
                        'https://images.unsplash.com/photo-1534528741775-53994a69daeb?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8cG9ydHJhaXR8ZW58MHx8MHx8fDA%3D&auto=format&fit=crop&w=800&q=60',
                      ]),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildRatingCard(
                        '4.8',
                        '24 reviews',
                        AppColors.accent,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(child: _buildSimpleStatCard('320 hrs', 'Worked')),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // White Card for Details
              Container(
                margin: const EdgeInsets.only(top: 16),
                padding: const EdgeInsets.only(top: 24),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(24),
                    topRight: Radius.circular(24),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Bio Section
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        children: [
                          const Icon(
                            FeatherIcons.info,
                            color: AppColors.textSecondary,
                            size: 18,
                          ),
                          const SizedBox(width: 8),
                          Text('Bio', style: AppTextStyles.heading3),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: AppColors.primary.withAlpha(
                            13,
                          ), // Light purple background
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: AppColors.primary.withAlpha(51),
                            width: 1,
                          ),
                        ),
                        child: Text(
                          'University student looking for event work during the 2030 World Cup.',
                          style: AppTextStyles.bodyMedium,
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Languages Section
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        children: [
                          const Icon(
                            FeatherIcons.globe,
                            color: AppColors.textSecondary,
                            size: 18,
                          ),
                          const SizedBox(width: 8),
                          Text('Languages', style: AppTextStyles.heading3),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          _buildLanguageTag('Arabic', 'Native'),
                          _buildLanguageTag('English', 'Fluent'),
                          _buildLanguageTag('French', 'Intermediate'),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Skills Section
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        children: [
                          const Icon(
                            FeatherIcons.award,
                            color: AppColors.textSecondary,
                            size: 18,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Skills & Experience',
                            style: AppTextStyles.heading3,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          _buildSkillTag('Restaurant Service'),
                          _buildSkillTag('Event Staff'),
                          _buildSkillTag('Customer Service'),
                          _buildSkillTag('Food Preparation'),
                          _buildSkillTag('Bartending'),
                          _buildSkillTag('Hospitality'),
                          _buildSkillTag('Team Player'),
                          _buildSkillTag('Multilingual'),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Job History Section
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        children: [
                          const Icon(
                            FeatherIcons.briefcase,
                            color: AppColors.textSecondary,
                            size: 18,
                          ),
                          const SizedBox(width: 8),
                          Text('Job History', style: AppTextStyles.heading3),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Job History Items
                    _buildJobHistoryItem(
                      jobTitle: 'Waiter',
                      employer: 'Café Maroc',
                      duration: 'June 2023 - August 2023',
                      location: 'Casablanca',
                      description:
                          'Served customers in a busy café during summer season. Managed orders and payments.',
                      color: AppColors.primary,
                    ),

                    _buildJobHistoryItem(
                      jobTitle: 'Event Staff',
                      employer: 'Casablanca Music Festival',
                      duration: 'May 2023',
                      location: 'Casablanca',
                      description:
                          'Worked as part of the event team for a 3-day music festival. Managed crowd control and assisted attendees.',
                      color: AppColors.accent,
                    ),

                    _buildJobHistoryItem(
                      jobTitle: 'Food Service Assistant',
                      employer: 'Royal Hotel',
                      duration: 'December 2022 - January 2023',
                      location: 'Rabat',
                      description:
                          'Assisted in food preparation and service for holiday events and conferences.',
                      color: AppColors.moroccanBlue,
                    ),

                    const SizedBox(height: 16),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        'Reviews from Employers',
                        style: AppTextStyles.heading3,
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Reviews
                    _buildReviewItem(
                      name: 'Yasmine Benali',
                      rating: 5.0,
                      comment:
                          'Ahmed was an excellent waiter at our café. Very professional and great with customers!',
                      ratingText: 'Excellent',
                      ratingColor: AppColors.accent,
                      imageUrl:
                          'https://images.unsplash.com/photo-1534528741775-53994a69daeb?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8cG9ydHJhaXR8ZW58MHx8MHx8fDA%3D&auto=format&fit=crop&w=800&q=60',
                    ),

                    _buildReviewItem(
                      name: 'Mohammed Tazi',
                      rating: 4.5,
                      comment:
                          'Reliable and hardworking staff member during our music festival. Would hire again for future events.',
                      ratingText: 'Great',
                      ratingColor: AppColors.primary,
                      imageUrl:
                          'https://images.unsplash.com/photo-1539571696357-5a69c17a67c6?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Nnx8bWFufGVufDB8fDB8fHww&auto=format&fit=crop&w=800&q=60',
                      backgroundColor: const Color(0xFFF3EEFF),
                    ),

                    _buildReviewItem(
                      name: 'Fatima Ouazzani',
                      rating: 4.8,
                      comment:
                          'Ahmed is punctual and has excellent customer service skills. He helped make our holiday events a success.',
                      ratingText: 'Excellent',
                      ratingColor: AppColors.accent,
                      imageUrl:
                          'https://images.unsplash.com/photo-1517841905240-472988babdf9?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTJ8fHByb2ZpbGUlMjBwaWN0dXJlfGVufDB8fDB8fHww&auto=format&fit=crop&w=800&q=60',
                    ),

                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Card with user avatars
  Widget _buildStatCard(String label, List<String> avatarUrls) {
    return CustomCard(
      padding: const EdgeInsets.all(16),
      borderRadius: 16,
      backgroundColor: const Color(0xFF2A2D30),
      child: Column(
        children: [
          // Stacked avatars
          SizedBox(
            height: 40,
            child: Stack(
              alignment: Alignment.center,
              children: [
                for (int i = 0; i < avatarUrls.length && i < 3; i++)
                  Positioned(
                    left: i * 20.0,
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: const Color(0xFF2A2D30),
                          width: 2,
                        ),
                      ),
                      child: CircleAvatar(
                        radius: 16,
                        backgroundImage: NetworkImage(avatarUrls[i]),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Text(
            label,
            style: AppTextStyles.bodyMedium.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  // Card with rating
  Widget _buildRatingCard(String rating, String label, Color color) {
    return CustomCard(
      padding: const EdgeInsets.all(16),
      borderRadius: 16,
      backgroundColor: const Color(0xFF2A2D30),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.star, color: color, size: 20),
              const SizedBox(width: 4),
              Text(
                rating,
                style: AppTextStyles.heading3.copyWith(color: Colors.white),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            label,
            style: AppTextStyles.bodyMedium.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  // Simple stat card
  Widget _buildSimpleStatCard(String value, String label) {
    return CustomCard(
      padding: const EdgeInsets.all(16),
      borderRadius: 16,
      backgroundColor: const Color(0xFF2A2D30),
      child: Column(
        children: [
          Text(
            value,
            style: AppTextStyles.heading3.copyWith(color: Colors.white),
          ),
          const SizedBox(height: 12),
          Text(
            label,
            style: AppTextStyles.bodyMedium.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  // Language tag widget
  Widget _buildLanguageTag(String language, String level) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.moroccanBlue.withAlpha(20),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppColors.moroccanBlue.withAlpha(50),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            language,
            style: AppTextStyles.bodySmall.copyWith(
              color: AppColors.moroccanBlue,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(width: 4),
          Container(
            width: 4,
            height: 4,
            decoration: BoxDecoration(
              color: AppColors.textSecondary,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 4),
          Text(
            level,
            style: AppTextStyles.bodySmall.copyWith(
              color: AppColors.textSecondary,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }

  // Skill tag widget
  Widget _buildSkillTag(String skill) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.primary.withAlpha(40),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        skill,
        style: AppTextStyles.bodySmall.copyWith(
          color: AppColors.primary,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  // Job history item
  Widget _buildJobHistoryItem({
    required String jobTitle,
    required String employer,
    required String duration,
    required String location,
    required String description,
    required Color color,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withAlpha(13), // 0.05 opacity
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withAlpha(51), width: 1), // 0.2 opacity
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  color: color.withAlpha(26), // 0.1 opacity
                  shape: BoxShape.circle,
                ),
                child: Icon(_getJobIcon(jobTitle), color: color, size: 20),
              ),
              const SizedBox(width: 12),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      jobTitle,
                      style: AppTextStyles.bodyLarge.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(employer, style: AppTextStyles.bodyMedium),
                  ],
                ),
              ),

              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: color.withAlpha(26), // 0.1 opacity
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  duration,
                  style: AppTextStyles.caption.copyWith(
                    color: color,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          Row(
            children: [
              Icon(Icons.location_on, color: AppColors.textSecondary, size: 14),
              const SizedBox(width: 4),
              Text(
                location,
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),

          Text(description, style: AppTextStyles.bodyMedium),
        ],
      ),
    );
  }

  // Helper to get appropriate icon for job type
  IconData _getJobIcon(String jobTitle) {
    jobTitle = jobTitle.toLowerCase();

    if (jobTitle.contains('waiter') ||
        jobTitle.contains('food') ||
        jobTitle.contains('restaurant')) {
      return Icons.restaurant;
    } else if (jobTitle.contains('event') || jobTitle.contains('staff')) {
      return Icons.event;
    } else if (jobTitle.contains('security')) {
      return Icons.security;
    } else if (jobTitle.contains('clean') ||
        jobTitle.contains('housekeeping')) {
      return Icons.cleaning_services;
    } else if (jobTitle.contains('driver') || jobTitle.contains('transport')) {
      return Icons.directions_car;
    } else if (jobTitle.contains('guide') || jobTitle.contains('tour')) {
      return Icons.tour;
    } else {
      return Icons.work;
    }
  }

  // Review item
  Widget _buildReviewItem({
    required String name,
    required double rating,
    required String comment,
    required String ratingText,
    required Color ratingColor,
    required String imageUrl,
    Color backgroundColor = const Color(0xFFEAF9EF),
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              // User avatar
              CircleAvatar(radius: 20, backgroundImage: NetworkImage(imageUrl)),
              const SizedBox(width: 12),

              // User name and rating
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          style: AppTextStyles.bodyLarge.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          ratingText,
                          style: AppTextStyles.bodySmall.copyWith(
                            color: ratingColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),

                    // Rating
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.star, color: ratingColor, size: 16),
                          const SizedBox(width: 4),
                          Text(
                            rating.toStringAsFixed(1),
                            style: AppTextStyles.bodyMedium.copyWith(
                              fontWeight: FontWeight.bold,
                              color: ratingColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Review text
          Text(comment, style: AppTextStyles.bodyMedium),
        ],
      ),
    );
  }
}
