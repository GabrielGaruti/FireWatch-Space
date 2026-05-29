import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../data/mock_data.dart';
import '../theme/app_theme.dart';

class WeeklyChart extends StatelessWidget {
  const WeeklyChart({super.key});

  @override
  Widget build(BuildContext context) {
    final max = weeklyData.map((d) => d.focos).reduce((a, b) => a > b ? a : b);
    const chartH = 80.0;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: List.generate(weeklyData.length, (i) {
        final d = weeklyData[i];
        final isToday = i == weeklyData.length - 2;
        final ratio = d.focos / max;
        final barH = (ratio * chartH).clamp(4.0, chartH);
        final barColor = isToday ? AppColors.primary : AppColors.primary.withOpacity(0.38);
        final textColor = isToday ? AppColors.primary : AppColors.mutedForeground;

        return Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '${d.focos}',
                style: GoogleFonts.inter(
                  fontSize: 9,
                  fontWeight: FontWeight.w500,
                  color: textColor,
                ),
              ),
              const SizedBox(height: 4),
              SizedBox(
                height: chartH,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      width: double.infinity,
                      height: barH,
                      margin: const EdgeInsets.symmetric(horizontal: 2),
                      decoration: BoxDecoration(
                        color: barColor,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 4),
              Text(
                d.day,
                style: GoogleFonts.inter(
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                  color: textColor,
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
