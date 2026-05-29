import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../data/mock_data.dart';
import '../theme/app_theme.dart';

const _barColors = [
  Color(0xFFFF4500),
  Color(0xFFFF6A00),
  Color(0xFFFF8C00),
  Color(0xFFFFB300),
  Color(0xFF00FF88),
];

class RegionChart extends StatelessWidget {
  const RegionChart({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(regionalData.length, (i) {
        final d = regionalData[i];
        final color = i < _barColors.length ? _barColors[i] : AppColors.primary;
        return Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Row(
            children: [
              SizedBox(
                width: 80,
                child: Text(
                  d.region,
                  style: GoogleFonts.inter(
                    fontSize: 11,
                    color: AppColors.mutedForeground,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Container(
                  height: 8,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.06),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: FractionallySizedBox(
                    alignment: Alignment.centerLeft,
                    widthFactor: d.percentage / 100,
                    child: Container(
                      decoration: BoxDecoration(
                        color: color,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              SizedBox(
                width: 34,
                child: Text(
                  '${d.focos}',
                  textAlign: TextAlign.right,
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: AppColors.text,
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
