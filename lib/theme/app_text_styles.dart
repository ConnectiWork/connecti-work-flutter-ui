import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTextStyles {
  // Headings - iOS style with SF Pro-like font
  static TextStyle heading1 = GoogleFonts.inter(
    fontSize: 34, // iOS large title
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
    height: 1.2,
    letterSpacing: -0.4,
  );

  static TextStyle heading2 = GoogleFonts.inter(
    fontSize: 28, // iOS title 1
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
    height: 1.2,
    letterSpacing: -0.3,
  );

  static TextStyle heading3 = GoogleFonts.inter(
    fontSize: 22, // iOS title 2
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
    height: 1.2,
    letterSpacing: -0.2,
  );

  static TextStyle heading4 = GoogleFonts.inter(
    fontSize: 20, // iOS title 3
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
    height: 1.2,
    letterSpacing: -0.1,
  );

  // Body text - iOS style
  static TextStyle bodyLarge = GoogleFonts.inter(
    fontSize: 17, // iOS body
    fontWeight: FontWeight.w400,
    color: AppColors.textPrimary,
    height: 1.4,
    letterSpacing: -0.1,
  );

  static TextStyle bodyMedium = GoogleFonts.inter(
    fontSize: 16, // iOS callout
    fontWeight: FontWeight.w400,
    color: AppColors.textPrimary,
    height: 1.4,
  );

  static TextStyle bodySmall = GoogleFonts.inter(
    fontSize: 15, // iOS subheadline
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
    height: 1.4,
  );

  static TextStyle footnote = GoogleFonts.inter(
    fontSize: 13, // iOS footnote
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
    height: 1.3,
  );

  // Button text - iOS style
  static TextStyle buttonLarge = GoogleFonts.inter(
    fontSize: 17, // iOS button
    fontWeight: FontWeight.w600,
    color: Colors.white,
    height: 1.3,
  );

  static TextStyle buttonMedium = GoogleFonts.inter(
    fontSize: 15, // iOS small button
    fontWeight: FontWeight.w600,
    color: Colors.white,
    height: 1.3,
  );

  // Caption text - iOS style
  static TextStyle caption = GoogleFonts.inter(
    fontSize: 12, // iOS caption
    fontWeight: FontWeight.w400,
    color: AppColors.systemGray,
    height: 1.3,
  );

  // Label text - iOS style
  static TextStyle label = GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.systemGray,
    height: 1.3,
    letterSpacing: -0.1,
  );

  // Special styles - iOS style
  static TextStyle price = GoogleFonts.inter(
    fontSize: 24,
    fontWeight: FontWeight.w700,
    color: AppColors.primary,
    height: 1.2,
    letterSpacing: -0.2,
  );

  static TextStyle tag = GoogleFonts.inter(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: AppColors.systemGray,
    height: 1.2,
  );

  static TextStyle cardTitle = GoogleFonts.inter(
    fontSize: 17,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
    height: 1.3,
    letterSpacing: -0.1,
  );

  // iOS-specific styles
  static TextStyle navTitle = GoogleFonts.inter(
    fontSize: 17,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
    height: 1.3,
    letterSpacing: -0.1,
  );

  static TextStyle navButton = GoogleFonts.inter(
    fontSize: 17,
    fontWeight: FontWeight.w400,
    color: AppColors.primary,
    height: 1.3,
  );
}
