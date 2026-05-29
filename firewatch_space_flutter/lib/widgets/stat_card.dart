import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';
import 'glow_card.dart';

class StatCard extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color? iconColor;
  final String? trend;

  const StatCard({
    super.key,
    required this.label,
    required this.value,
    required this.icon,
    this.iconColor,
    this.trend,
  });

  @override
  Widget build(BuildContext context) {
    final color = iconColor ?? AppColors.primary;
    return Expanded(
      child: GlowCard(
        glowColor: color,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: color.withOpacity(0.15),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, size: 18, color: color),
            ),
            const SizedBox(height: 10),
            Text(
              value,
              style: GoogleFonts.inter(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: AppColors.text,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: GoogleFonts.inter(
                fontSize: 11,
                color: AppColors.mutedForeground,
                letterSpacing: 0.3,
              ),
            ),
            if (trend != null) ...[
              const SizedBox(height: 4),
              Text(
                trend!,
                style: GoogleFonts.inter(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: AppColors.accent,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
