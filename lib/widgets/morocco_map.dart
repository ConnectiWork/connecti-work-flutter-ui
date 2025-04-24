import 'package:flutter/material.dart';
import 'package:feather_icons/feather_icons.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

// Custom painter for drawing a simplified Morocco map
class MoroccoMapPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint =
        Paint()
          ..color = const Color(0x19E6EDFF) // Light blue with alpha
          ..style = PaintingStyle.fill;

    final Paint borderPaint =
        Paint()
          ..color = const Color(0x4D1246FF) // Primary blue with alpha
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2.0;

    // Draw a simplified shape of Morocco
    final Path path = Path();

    // Starting from top-left
    path.moveTo(size.width * 0.2, size.height * 0.2);

    // Top border (Mediterranean coast)
    path.quadraticBezierTo(
      size.width * 0.3,
      size.height * 0.15,
      size.width * 0.7,
      size.height * 0.2,
    );

    // Right border (Algeria border)
    path.quadraticBezierTo(
      size.width * 0.8,
      size.height * 0.4,
      size.width * 0.75,
      size.height * 0.7,
    );

    // Bottom border (Western Sahara)
    path.quadraticBezierTo(
      size.width * 0.6,
      size.height * 0.8,
      size.width * 0.3,
      size.height * 0.75,
    );

    // Left border (Atlantic coast)
    path.quadraticBezierTo(
      size.width * 0.15,
      size.height * 0.5,
      size.width * 0.2,
      size.height * 0.2,
    );

    // Draw the shape
    canvas.drawPath(path, paint);
    canvas.drawPath(path, borderPaint);

    // Draw some decorative elements (mountains, etc.)
    final mountainPaint =
        Paint()
          ..color = const Color(0x331246FF) // Primary blue with 20% alpha
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.5;

    // Atlas mountains
    final mountainPath = Path();
    mountainPath.moveTo(size.width * 0.3, size.height * 0.4);
    mountainPath.lineTo(size.width * 0.35, size.height * 0.35);
    mountainPath.lineTo(size.width * 0.4, size.height * 0.4);
    mountainPath.lineTo(size.width * 0.45, size.height * 0.35);
    mountainPath.lineTo(size.width * 0.5, size.height * 0.4);
    mountainPath.lineTo(size.width * 0.55, size.height * 0.35);
    mountainPath.lineTo(size.width * 0.6, size.height * 0.4);

    canvas.drawPath(mountainPath, mountainPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

// A simplified map widget that doesn't use Google Maps
// This will help us avoid the crashes while still providing a visual representation
class MoroccoMap extends StatelessWidget {
  final Function(Map<String, dynamic>) onLocationSelected;

  const MoroccoMap({super.key, required this.onLocationSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFE8F0FE),
      child: Stack(
        children: [
          // Custom drawn map background
          Center(
            child: CustomPaint(
              size: Size(
                MediaQuery.of(context).size.width,
                MediaQuery.of(context).size.height,
              ),
              painter: MoroccoMapPainter(),
            ),
          ),

          // City markers
          Positioned(
            top: 150,
            left: 100,
            child: _buildMapPin(
              'Casablanca',
              '124 jobs',
              AppColors.primary,
              () => onLocationSelected({'name': 'Casablanca', 'jobCount': 124}),
            ),
          ),
          Positioned(
            top: 120,
            right: 120,
            child: _buildMapPin(
              'Rabat',
              '87 jobs',
              AppColors.accent,
              () => onLocationSelected({'name': 'Rabat', 'jobCount': 87}),
            ),
          ),
          Positioned(
            bottom: 200,
            left: 150,
            child: _buildMapPin(
              'Marrakech',
              '56 jobs',
              AppColors.moroccanRed,
              () => onLocationSelected({'name': 'Marrakech', 'jobCount': 56}),
            ),
          ),
          Positioned(
            top: 80,
            right: 80,
            child: _buildMapPin(
              'Tangier',
              '42 jobs',
              AppColors.moroccanGreen,
              () => onLocationSelected({'name': 'Tangier', 'jobCount': 42}),
            ),
          ),
          Positioned(
            bottom: 250,
            right: 100,
            child: _buildMapPin(
              'Fez',
              '38 jobs',
              AppColors.moroccanYellow,
              () => onLocationSelected({'name': 'Fez', 'jobCount': 38}),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMapPin(
    String title,
    String subtitle,
    Color color,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
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
                  color: color.withAlpha(100),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: const Icon(
              FeatherIcons.mapPin,
              color: Colors.white,
              size: 20,
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
      ),
    );
  }
}
