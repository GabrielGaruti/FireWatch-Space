import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/models.dart';
import '../theme/app_theme.dart';

class RiskBadge extends StatelessWidget {
  final Intensity risk;
  final String size;

  const RiskBadge({super.key, required this.risk, this.size = 'md'});

  @override
  Widget build(BuildContext context) {
    final Color color;
    final String label;
    switch (risk) {
      case Intensity.alto:
        color = AppColors.riskHigh;
        label = 'ALTO';
        break;
      case Intensity.medio:
        color = AppColors.riskMedium;
        label = 'MÉDIO';
        break;
      case Intensity.baixo:
        color = AppColors.riskLow;
        label = 'BAIXO';
        break;
    }

    final double fontSize = size == 'sm' ? 9 : size == 'lg' ? 13 : 10;
    final double px = size == 'sm' ? 6 : size == 'lg' ? 12 : 8;
    final double py = size == 'sm' ? 2 : size == 'lg' ? 5 : 3;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: px, vertical: py),
      decoration: BoxDecoration(
        color: color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: color, width: 1),
      ),
      child: Text(
        label,
        style: GoogleFonts.inter(
          fontSize: fontSize,
          fontWeight: FontWeight.w700,
          color: color,
          letterSpacing: 0.8,
        ),
      ),
    );
  }
}
