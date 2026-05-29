import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class GlowCard extends StatelessWidget {
  final Widget child;
  final Color? glowColor;
  final EdgeInsetsGeometry? padding;
  final double borderRadius;

  const GlowCard({
    super.key,
    required this.child,
    this.glowColor,
    this.padding,
    this.borderRadius = 16,
  });

  @override
  Widget build(BuildContext context) {
    final glow = glowColor ?? AppColors.primary;
    return Container(
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(color: glow.withOpacity(0.25), width: 1),
        boxShadow: [
          BoxShadow(
            color: glow.withOpacity(0.18),
            blurRadius: 18,
            spreadRadius: 0,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius - 1),
        child: Padding(
          padding: padding ?? const EdgeInsets.all(16),
          child: child,
        ),
      ),
    );
  }
}
