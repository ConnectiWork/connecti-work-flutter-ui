import 'package:flutter/material.dart';
import 'package:card_swiper/card_swiper.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';
import '../widgets/custom_card.dart';
import '../widgets/custom_button.dart';

class SwipeScreen extends StatefulWidget {
  const SwipeScreen({super.key});

  @override
  State<SwipeScreen> createState() => _SwipeScreenState();
}

class _SwipeScreenState extends State<SwipeScreen> {
  final SwiperController _swiperController = SwiperController();
  int _currentIndex = 0;
  final int _totalJobs = 5;

  final List<Map<String, dynamic>> _jobs = [
    {
      'title': 'Event Server',
      'company': 'Marrakech Stadium',
      'location': 'Marrakech',
      'salary': '200 - 300 MAD/day',
      'level': 'Entry Level',
      'tags': ['Food Service', 'Customer Service', 'English Speaking'],
      'description':
          'Join our team serving food and beverages to fans during World Cup matches. Flexible shifts available throughout the tournament.',
      'postedTime': '5 hours ago',
      'color': AppColors.primary,
    },
    {
      'title': 'Security Staff',
      'company': 'World Cup Security',
      'location': 'Casablanca',
      'salary': '250 - 350 MAD/day',
      'level': 'Entry Level',
      'tags': ['Security', 'Crowd Management', 'Event Safety'],
      'description':
          'Help maintain safety and security at World Cup venues. Training provided. Multiple positions available for the tournament duration.',
      'postedTime': '8 hours ago',
      'color': AppColors.moroccanBlue,
    },
    {
      'title': 'Hospitality Assistant',
      'company': 'Royal Mansour Hotel',
      'location': 'Rabat',
      'salary': '220 - 320 MAD/day',
      'level': 'Entry Level',
      'tags': ['Hospitality', 'Customer Service', 'Multilingual'],
      'description':
          'Assist guests and provide exceptional service at one of the official World Cup hotels. Perfect for those with language skills.',
      'postedTime': '1 day ago',
      'color': AppColors.moroccanRed,
    },
    {
      'title': 'Tour Guide',
      'company': 'Morocco Experiences',
      'location': 'Fez',
      'salary': '300 - 400 MAD/day',
      'level': 'Intermediate',
      'tags': ['Tourism', 'Languages', 'Local Knowledge'],
      'description':
          'Lead tours for World Cup visitors wanting to explore Morocco between matches. Share your knowledge of local culture and attractions.',
      'postedTime': '2 days ago',
      'color': AppColors.moroccanGreen,
    },
    {
      'title': 'Event Coordinator',
      'company': 'World Cup Fan Zone',
      'location': 'Tangier',
      'salary': '350 - 450 MAD/day',
      'level': 'Intermediate',
      'tags': ['Event Management', 'Organization', 'Communication'],
      'description':
          'Help organize and run fan zone activities during the World Cup. Ensure smooth operations and great experiences for visitors.',
      'postedTime': '3 days ago',
      'color': AppColors.moroccanYellow,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'World Cup Jobs For You',
                    style: AppTextStyles.heading3.copyWith(
                      color: AppColors.dark, // Using dark color for main title
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(
                        43,
                        179,
                        99,
                        0.1,
                      ), // Consistent green color
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      children: [
                        Text(
                          '${_currentIndex + 1}/$_totalJobs',
                          style: AppTextStyles.bodyMedium.copyWith(
                            color: AppColors.accent,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Progress Indicator
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: LinearProgressIndicator(
                  value: (_currentIndex + 1) / _totalJobs,
                  backgroundColor: AppColors.divider,
                  valueColor: AlwaysStoppedAnimation<Color>(AppColors.accent),
                  minHeight: 6,
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Swiper
            Expanded(
              child: Swiper(
                itemBuilder: (BuildContext context, int index) {
                  return _buildJobCard(_jobs[index]);
                },
                itemCount: _jobs.length,
                controller: _swiperController,
                viewportFraction: 0.85,
                scale: 0.9,
                onIndexChanged: (index) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
              ),
            ),

            // Action Buttons
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildActionButton(
                    Icons.close,
                    AppColors.error,
                    'Not Now',
                    () {
                      _swiperController.next();
                    },
                  ),
                  _buildActionButton(
                    Icons.bookmark_border,
                    AppColors.primary, // Using purple primary color
                    'Save',
                    () {
                      // Save job logic
                    },
                  ),
                  _buildActionButton(
                    Icons.check,
                    AppColors.accent, // Using green accent color
                    'Apply',
                    () {
                      _swiperController.next();
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildJobCard(Map<String, dynamic> job) {
    return CustomCard(
      elevation: 4,
      borderRadius: 20,
      backgroundColor: Colors.white,
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Header
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Color.fromRGBO(
                43,
                179,
                99,
                0.1,
              ), // Using consistent green accent color
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      backgroundColor:
                          AppColors
                              .accent, // Using consistent green accent color
                      radius: 24,
                      child: const Icon(
                        Icons.event,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            job['title'],
                            style: AppTextStyles.heading3.copyWith(
                              color:
                                  AppColors
                                      .dark, // Using dark color for job title
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            job['company'],
                            style: AppTextStyles.bodyMedium.copyWith(
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(
                        Icons.more_vert,
                        color: AppColors.accent,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    const Icon(
                      Icons.location_on,
                      color: AppColors.accent,
                      size: 16,
                    ),
                    const SizedBox(width: 4),
                    Text(job['location'], style: AppTextStyles.bodyMedium),
                    const SizedBox(width: 16),
                    const Icon(
                      Icons.access_time,
                      color: AppColors.accent,
                      size: 16,
                    ),
                    const SizedBox(width: 4),
                    Text(job['postedTime'], style: AppTextStyles.bodyMedium),
                  ],
                ),
              ],
            ),
          ),

          // Body
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Job Details
                  _buildDetailItem('Salary', job['salary'], Icons.attach_money),
                  const SizedBox(height: 20),

                  // Tags
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children:
                        (job['tags'] as List<String>).map((tag) {
                          return Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: Color.fromRGBO(
                                43,
                                179,
                                99,
                                0.1,
                              ), // Consistent green color
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Text(
                              tag,
                              style: AppTextStyles.bodySmall.copyWith(
                                color: AppColors.accent,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          );
                        }).toList(),
                  ),
                  const SizedBox(height: 20),

                  // Description
                  Text(
                    'Job Description',
                    style: AppTextStyles.heading4.copyWith(
                      color:
                          AppColors.dark, // Using dark color for section title
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(job['description'], style: AppTextStyles.bodyMedium),
                  const SizedBox(height: 20),

                  // Match Percentage
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color.fromRGBO(
                            120,
                            73,
                            255,
                            0.15,
                          ), // Purple with transparency
                          Color.fromRGBO(
                            43,
                            179,
                            99,
                            0.1,
                          ), // Green with transparency
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Icon(
                            Icons.bolt,
                            color: AppColors.primary, // Using purple for icon
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Perfect Match',
                                style: AppTextStyles.bodyMedium.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Great fit for your skills',
                                style: AppTextStyles.bodySmall,
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(
                              120,
                              73,
                              255,
                              0.15,
                            ), // Purple background
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Text(
                            '85%',
                            style: AppTextStyles.bodyMedium.copyWith(
                              color: AppColors.primary, // Purple text
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
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

  Widget _buildDetailItem(String label, String value, IconData icon) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTextStyles.bodySmall.copyWith(color: AppColors.textLight),
        ),
        const SizedBox(height: 4),
        Row(
          children: [
            Icon(icon, color: AppColors.accent, size: 16),
            const SizedBox(width: 4),
            Expanded(
              child: Text(
                value,
                style: AppTextStyles.bodyMedium.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildActionButton(
    IconData icon,
    Color color,
    String label,
    VoidCallback onTap,
  ) {
    return Column(
      children: [
        Material(
          color: color,
          elevation: 0,
          shape: const CircleBorder(),
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            onTap: onTap,
            child: Ink(
              height: 64,
              width: 64,
              decoration: BoxDecoration(color: color, shape: BoxShape.circle),
              child: Icon(icon, color: Colors.white, size: 30),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: AppTextStyles.bodySmall.copyWith(
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    );
  }
}
