import 'package:flutter/material.dart';
import 'package:card_swiper/card_swiper.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';
import '../widgets/custom_card.dart';

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
      'title': 'UI/UX Designer',
      'company': 'Tech Solutions',
      'location': 'Casablanca',
      'salary': '\$1,000 - \$2,000',
      'level': 'Intermediate',
      'tags': ['UI/UX Design', 'Figma', 'Adobe XD'],
      'description':
          'We are looking for a talented UI/UX Designer to create amazing user experiences.',
      'postedTime': '5 hours ago',
      'color': AppColors.primary,
    },
    {
      'title': 'Frontend Developer',
      'company': 'Web Experts',
      'location': 'Rabat',
      'salary': '\$1,200 - \$2,500',
      'level': 'Senior',
      'tags': ['React', 'JavaScript', 'CSS'],
      'description':
          'Join our team to build responsive and interactive web applications.',
      'postedTime': '8 hours ago',
      'color': AppColors.moroccanBlue,
    },
    {
      'title': 'Digital Marketing Specialist',
      'company': 'Marketing Pro',
      'location': 'Marrakech',
      'salary': '\$800 - \$1,500',
      'level': 'Junior',
      'tags': ['Social Media', 'SEO', 'Content'],
      'description':
          'Help us grow our online presence through effective digital marketing strategies.',
      'postedTime': '1 day ago',
      'color': AppColors.moroccanRed,
    },
    {
      'title': 'Mobile App Developer',
      'company': 'App Innovators',
      'location': 'Tangier',
      'salary': '\$1,500 - \$3,000',
      'level': 'Senior',
      'tags': ['Flutter', 'React Native', 'iOS/Android'],
      'description':
          'Develop cutting-edge mobile applications for our diverse client base.',
      'postedTime': '2 days ago',
      'color': AppColors.moroccanGreen,
    },
    {
      'title': 'Data Analyst',
      'company': 'Data Insights',
      'location': 'Fez',
      'salary': '\$1,100 - \$2,200',
      'level': 'Intermediate',
      'tags': ['SQL', 'Python', 'Tableau'],
      'description':
          'Turn data into actionable insights to drive business decisions.',
      'postedTime': '3 days ago',
      'color': AppColors.moroccanYellow,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('AI-Suggested Jobs', style: AppTextStyles.heading3),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      children: [
                        Text(
                          '${_currentIndex + 1}/$_totalJobs',
                          style: AppTextStyles.bodyMedium.copyWith(
                            color: AppColors.primary,
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
                  valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
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
                    'Reject',
                    () {
                      _swiperController.next();
                    },
                  ),
                  _buildActionButton(
                    Icons.bookmark_border,
                    AppColors.moroccanYellow,
                    'Save',
                    () {
                      // Save job logic
                    },
                  ),
                  _buildActionButton(
                    Icons.check,
                    AppColors.accent,
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
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Header
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: job['color'].withOpacity(0.1),
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
                      backgroundColor: job['color'],
                      radius: 24,
                      child: const Icon(
                        Icons.business,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(job['title'], style: AppTextStyles.heading3),
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
                      child: Icon(Icons.more_vert, color: job['color']),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Icon(Icons.location_on, color: job['color'], size: 16),
                    const SizedBox(width: 4),
                    Text(job['location'], style: AppTextStyles.bodyMedium),
                    const SizedBox(width: 16),
                    Icon(Icons.access_time, color: job['color'], size: 16),
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
                  Row(
                    children: [
                      Expanded(
                        child: _buildDetailItem(
                          'Salary',
                          job['salary'],
                          Icons.attach_money,
                        ),
                      ),
                      Expanded(
                        child: _buildDetailItem(
                          'Level',
                          job['level'],
                          Icons.trending_up,
                        ),
                      ),
                    ],
                  ),
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
                              color: job['color'].withOpacity(0.1),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Text(
                              tag,
                              style: AppTextStyles.bodySmall.copyWith(
                                color: job['color'],
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          );
                        }).toList(),
                  ),
                  const SizedBox(height: 20),

                  // Description
                  Text('Job Description', style: AppTextStyles.heading4),
                  const SizedBox(height: 8),
                  Text(job['description'], style: AppTextStyles.bodyMedium),
                  const SizedBox(height: 20),

                  // Match Percentage
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(0.1),
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
                            color: AppColors.primary,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'AI Match Score',
                                style: AppTextStyles.bodyMedium.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'This job matches 85% of your skills and preferences',
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
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Text(
                            '85%',
                            style: AppTextStyles.bodyMedium.copyWith(
                              color: AppColors.primary,
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
            Icon(icon, color: AppColors.primary, size: 16),
            const SizedBox(width: 4),
            Text(
              value,
              style: AppTextStyles.bodyMedium.copyWith(
                fontWeight: FontWeight.bold,
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
        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(30),
          child: Container(
            height: 60,
            width: 60,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: color.withOpacity(0.3),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
              border: Border.all(color: color, width: 2),
            ),
            child: Icon(icon, color: color, size: 30),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: AppTextStyles.bodySmall.copyWith(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
