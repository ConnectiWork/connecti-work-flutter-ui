import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class CustomCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;
  final double borderRadius;
  final Color backgroundColor;
  final double elevation;
  final VoidCallback? onTap;
  final bool hasBorder;
  final Color borderColor;
  final bool isHighlighted;

  const CustomCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(16),
    this.borderRadius = 12, // iOS card radius
    this.backgroundColor = Colors.white,
    this.elevation = 0.5, // iOS subtle elevation
    this.onTap,
    this.hasBorder = false,
    this.borderColor = AppColors.divider,
    this.isHighlighted = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(borderRadius),
        border: hasBorder ? Border.all(color: borderColor, width: 1) : null,
        boxShadow: [
          BoxShadow(
            color:
                isHighlighted
                    ? AppColors.primary.withAlpha(25)
                    : AppColors.cardShadow,
            blurRadius: elevation * 4,
            spreadRadius: elevation,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        clipBehavior: Clip.antiAlias,
        borderRadius: BorderRadius.circular(borderRadius),
        child: InkWell(
          onTap: onTap,
          splashColor: AppColors.primary.withAlpha(13),
          highlightColor: AppColors.primary.withAlpha(13),
          borderRadius: BorderRadius.circular(borderRadius),
          child: Padding(padding: padding, child: child),
        ),
      ),
    );
  }
}
