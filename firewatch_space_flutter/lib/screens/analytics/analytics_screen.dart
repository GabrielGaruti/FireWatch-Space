import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../data/mock_data.dart';
import '../../theme/app_theme.dart';
import '../../widgets/ai_section.dart';
import '../../widgets/glow_card.dart';
import '../../widgets/region_chart.dart';
import '../../widgets/risk_gauge.dart';
import '../../widgets/weekly_chart.dart';

class AnalyticsScreen extends StatelessWidget {
  const AnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final top = MediaQuery.of(context).padding.top;
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(16, top + 12, 16, 100),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Dashboard Analítico',
                style: GoogleFonts.inter(fontSize: 24, fontWeight: FontWeight.w700, color: AppColors.text)),
            const SizedBox(height: 2),
            Text('Monitoramento em tempo real — INPE / NASA FIRMS',
                style: GoogleFonts.inter(fontSize: 12, color: AppColors.mutedForeground)),
            const SizedBox(height: 16),

            GlowCard(
              glowColor: AppColors.riskHigh,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Índice de Risco Geral',
                      style: GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.w700, color: AppColors.text)),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      RiskGauge(value: appStats.overallRisk, size: 150),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          children: [
                            _GaugeStat(label: 'Focos ativos', value: '1.298', color: AppColors.riskHigh),
                            Divider(color: AppColors.border, height: 16),
                            _GaugeStat(label: 'Alertas hoje', value: '${appStats.alertsSent}', color: AppColors.secondary),
                            Divider(color: AppColors.border, height: 16),
                            _GaugeStat(label: 'Regiões críticas', value: '${appStats.criticalRegions}', color: AppColors.primary),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 14),

            GlowCard(
              glowColor: AppColors.secondary,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Evolução Semanal de Focos',
                      style: GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.w700, color: AppColors.text)),
                  const SizedBox(height: 2),
                  Text('Focos detectados por dia',
                      style: GoogleFonts.inter(fontSize: 11, color: AppColors.mutedForeground)),
                  const SizedBox(height: 12),
                  const WeeklyChart(),
                ],
              ),
            ),
            const SizedBox(height: 14),

            GlowCard(
              glowColor: AppColors.primary,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Focos por Região',
                      style: GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.w700, color: AppColors.text)),
                  const SizedBox(height: 2),
                  Text('Distribuição de focos ativos',
                      style: GoogleFonts.inter(fontSize: 11, color: AppColors.mutedForeground)),
                  const SizedBox(height: 14),
                  const RegionChart(),
                ],
              ),
            ),
            const SizedBox(height: 14),

            GlowCard(
              glowColor: AppColors.neonBlue,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Indicadores Ambientais',
                      style: GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.w700, color: AppColors.text)),
                  const SizedBox(height: 14),
                  _EnvStat(label: 'Temperatura média', value: '${appStats.temperature.toStringAsFixed(1)}', unit: '°C',
                      color: AppColors.primary, barPercent: appStats.temperature / 50),
                  const SizedBox(height: 10),
                  _EnvStat(label: 'Umidade relativa do ar', value: '${appStats.humidity}', unit: '%',
                      color: AppColors.neonBlue, barPercent: appStats.humidity / 100),
                  const SizedBox(height: 10),
                  _EnvStat(label: 'Velocidade do vento', value: '${appStats.windSpeed}', unit: 'km/h',
                      color: AppColors.accent, barPercent: appStats.windSpeed / 60),
                  const SizedBox(height: 10),
                  _EnvStat(label: 'Qualidade do ar (AQI)', value: '${appStats.airQuality}', unit: 'AQI',
                      color: AppColors.amber, barPercent: appStats.airQuality / 300),
                ],
              ),
            ),
            const SizedBox(height: 14),

            GlowCard(
              glowColor: AppColors.amber,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Qualidade do Ar Detalhada',
                      style: GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.w700, color: AppColors.text)),
                  const SizedBox(height: 12),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Text(
                            '${appStats.airQuality}',
                            style: GoogleFonts.inter(fontSize: 48, fontWeight: FontWeight.w700, color: AppColors.amber),
                          ),
                          Text('AQI',
                              style: GoogleFonts.inter(
                                  fontSize: 12, fontWeight: FontWeight.w700, color: AppColors.amber, letterSpacing: 1)),
                        ],
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          children: [
                            _AqiItem(label: 'PM2.5', value: '84 μg/m³', color: AppColors.riskHigh),
                            const SizedBox(height: 8),
                            _AqiItem(label: 'PM10', value: '128 μg/m³', color: AppColors.secondary),
                            const SizedBox(height: 8),
                            _AqiItem(label: 'O₃', value: '62 μg/m³', color: AppColors.amber),
                            const SizedBox(height: 8),
                            _AqiItem(label: 'CO', value: '2.4 ppm', color: AppColors.accent),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 14),

            GlowCard(
              glowColor: AppColors.accent,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Inteligência Artificial',
                      style: GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.w700, color: AppColors.text)),
                  const SizedBox(height: 14),
                  const AiSection(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _GaugeStat extends StatelessWidget {
  final String label;
  final String value;
  final Color color;
  const _GaugeStat({required this.label, required this.value, required this.color});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: GoogleFonts.inter(fontSize: 10, color: AppColors.mutedForeground)),
        Text(value, style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.w700, color: color)),
      ],
    );
  }
}

class _EnvStat extends StatelessWidget {
  final String label;
  final String value;
  final String unit;
  final Color color;
  final double barPercent;
  const _EnvStat({required this.label, required this.value, required this.unit, required this.color, required this.barPercent});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label, style: GoogleFonts.inter(fontSize: 12, color: AppColors.mutedForeground)),
            RichText(
              text: TextSpan(children: [
                TextSpan(text: value, style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w700, color: color)),
                TextSpan(text: ' $unit', style: GoogleFonts.inter(fontSize: 11, color: AppColors.mutedForeground)),
              ]),
            ),
          ],
        ),
        const SizedBox(height: 5),
        Container(
          height: 5,
          decoration: BoxDecoration(color: AppColors.muted, borderRadius: BorderRadius.circular(3)),
          child: FractionallySizedBox(
            alignment: Alignment.centerLeft,
            widthFactor: barPercent.clamp(0.0, 1.0),
            child: Container(decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(3))),
          ),
        ),
      ],
    );
  }
}

class _AqiItem extends StatelessWidget {
  final String label;
  final String value;
  final Color color;
  const _AqiItem({required this.label, required this.value, required this.color});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(width: 8, height: 8, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
        const SizedBox(width: 7),
        SizedBox(width: 36, child: Text(label, style: GoogleFonts.inter(fontSize: 11, color: AppColors.mutedForeground))),
        Text(value, style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.text)),
      ],
    );
  }
}
