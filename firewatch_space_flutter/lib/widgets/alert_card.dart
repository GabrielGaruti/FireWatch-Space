import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/models.dart';
import '../theme/app_theme.dart';
import 'risk_badge.dart';

class AlertCard extends StatelessWidget {
  final Alert alert;

  const AlertCard({super.key, required this.alert});

  Color get _borderColor {
    switch (alert.risk) {
      case Intensity.alto: return AppColors.riskHigh;
      case Intensity.medio: return AppColors.riskMedium;
      case Intensity.baixo: return AppColors.riskLow;
    }
  }

  IconData get _typeIcon {
    switch (alert.type) {
      case AlertType.foco: return Icons.warning_amber_rounded;
      case AlertType.clima: return Icons.air;
      case AlertType.alerta: return Icons.radio_button_checked;
    }
  }

  @override
  Widget build(BuildContext context) {
    final color = _borderColor;
    return GestureDetector(
      onTap: () => context.push('/focus/${alert.id}'),
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          color: AppColors.card,
          borderRadius: BorderRadius.circular(14),
          border: Border(
            top: BorderSide(color: color.withOpacity(0.18), width: 1),
            right: BorderSide(color: color.withOpacity(0.18), width: 1),
            bottom: BorderSide(color: color.withOpacity(0.18), width: 1),
            left: BorderSide(color: color, width: 3),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: color.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(11),
                ),
                child: Icon(_typeIcon, size: 20, color: color),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          alert.region,
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: AppColors.text,
                          ),
                        ),
                        if (alert.isNew) ...[
                          const SizedBox(width: 6),
                          Container(
                            width: 7,
                            height: 7,
                            decoration: const BoxDecoration(
                              color: AppColors.accent,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ],
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      alert.description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        color: AppColors.mutedForeground,
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RiskBadge(risk: alert.risk, size: 'sm'),
                        Text(
                          alert.time,
                          style: GoogleFonts.inter(
                            fontSize: 11,
                            color: AppColors.mutedForeground,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 4),
              Icon(Icons.chevron_right, size: 16, color: AppColors.mutedForeground),
            ],
          ),
        ),
      ),
    );
  }
}
