import 'package:flutter/material.dart';

class AppColors {
  // Primary colors - Purple #7849FF
  static const Color primary = Color(0xFF7849FF); // Purple #7849FF
  static const Color primaryLight = Color(
    0xFFEEE6FF,
  ); // Light purple background
  static const Color primaryDark = Color(0xFF5B35D5); // Darker purple

  // Background colors - iOS-inspired
  static const Color background = Color(0xFFF2F2F7); // iOS system background
  static const Color cardBackground = Colors.white;
  static const Color groupedBackground = Color(
    0xFFEFEFF4,
  ); // iOS grouped background

  // Text colors
  static const Color textPrimary = Color(0xFF1A1D1F);
  static const Color textSecondary = Color(0xFF6F767E);
  static const Color textLight = Color(0xFF9A9FA5);

  // Accent colors - Using green #2BB363 and dark #141619
  static const Color accent = Color(0xFF2BB363); // Green #2BB363
  static const Color success = Color(0xFF2BB363); // Green #2BB363
  static const Color warning = Color(0xFFFF9500); // Orange
  static const Color error = Color(0xFFFF3B30); // Red
  static const Color info = Color(0xFF7849FF); // Purple #7849FF
  static const Color dark = Color(0xFF141619); // Dark #141619
  static const Color teal = Color(
    0xFF00B8D4,
  ); // Teal that complements the purple
  static const Color indigo = Color(0xFF5B35D5); // Darker purple

  // Moroccan-inspired accent colors
  static const Color moroccanRed = Color(0xFFE63946);
  static const Color moroccanBlue = Color(0xFF457B9D);
  static const Color moroccanGreen = Color(0xFF2A9D8F);
  static const Color moroccanYellow = Color(0xFFF4A261);

  // Gradient colors - Using purple #7849FF
  static const List<Color> blueGradient = [
    Color(0xFF7849FF), // Purple #7849FF
    Color(0xFF9B7AFF), // Lighter purple
  ];

  static const List<Color> navyGradient = [
    Color(0xFF7849FF), // Purple #7849FF
    Color(0xFF5B35D5), // Darker purple
  ];

  // Green gradient
  static const List<Color> greenGradient = [
    Color(0xFF2BB363), // Green #2BB363
    Color(0xFF1D9A4D), // Darker green
  ];

  // UI element colors - iOS style
  static const Color divider = Color(0xFFC6C6C8); // iOS separator
  static const Color shadow = Color(0x1A000000); // iOS shadow
  static const Color shimmer = Color(0xFFE6EDFF); // Light blue background

  // Additional UI colors
  static const Color card = Colors.white;
  static const Color cardShadow = Color(0x0A000000); // Lighter iOS shadow
  static const Color tagBackground = Color(
    0xFFEEE6FF,
  ); // Light purple background
  static const Color activeTab = Color(0xFF7849FF); // Purple #7849FF
  static const Color inactiveTab = Color(0xFF8E8E93); // Gray

  // iOS-specific UI colors
  static const Color systemGray = Color(0xFF8E8E93);
  static const Color systemGray2 = Color(0xFFAEAEB2);
  static const Color systemGray3 = Color(0xFFC7C7CC);
  static const Color systemGray4 = Color(0xFFD1D1D6);
  static const Color systemGray5 = Color(0xFFE5E5EA);
  static const Color systemGray6 = Color(0xFFF2F2F7);
}
