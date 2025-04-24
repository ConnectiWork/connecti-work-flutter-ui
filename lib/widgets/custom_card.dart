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

  const CustomCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(16),
    this.borderRadius = 16,
    this.backgroundColor = Colors.white,
    this.elevation = 2,
    this.onTap,
    this.hasBorder = false,
    this.borderColor = AppColors.divider,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: backgroundColor,
      elevation: elevation,
      shadowColor: AppColors.shadow,
      clipBehavior: Clip.antiAlias,
      shape:
          hasBorder
              ? RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(borderRadius),
                side: BorderSide(color: borderColor, width: 1),
              )
              : RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(borderRadius),
              ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(borderRadius),
        child: Padding(padding: padding, child: child),
      ),
    );
  }
}
