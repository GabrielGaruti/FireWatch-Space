import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../data/mock_data.dart';
import '../../models/models.dart';
import '../../theme/app_theme.dart';
import '../../widgets/glow_card.dart';
import '../../widgets/risk_badge.dart';
import '../../widgets/risk_gauge.dart';

class FocusDetailScreen extends StatelessWidget {
  final String id;
  const FocusDetailScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    final top = MediaQuery.of(context).padding.top;

    final focus = fireFocuses.where((f) => f.id == id).firstOrNull;
    final alert = alerts.where((a) => a.id == id).firstOrNull;

    final region = focus?.region ?? alert?.region ?? 'Região Desconhecida';
    final state = focus?.state ?? alert?.state ?? 'BR';
    final risk = focus?.intensity ?? alert?.risk ?? Intensity.alto;
    final temperature = focus?.temperature ?? 36.5;
    final humidity = focus?.humidity ?? 22;
    final windSpeed = focus?.windSpeed ?? 18;
    final aiConfidence = focus?.aiConfidence ?? 85;
    final area = focus?.area ?? 400;
    final lat = focus?.lat ?? -15.78;
    final lon = focus?.lon ?? -47.92;
    final focusId = focus?.id ?? alert?.id ?? id;

    final Color glowColor = risk == Intensity.alto
        ? AppColors.riskHigh
        : risk == Intensity.medio
            ? AppColors.riskMedium
            : AppColors.riskLow;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(16, top + 8, 16, 12),
            decoration: const BoxDecoration(
              border: Border(bottom: BorderSide(color: AppColors.border)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () => context.pop(),
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: AppColors.card,
                      borderRadius: BorderRadius.circular(11),
                      border: Border.all(color: AppColors.border),
                    ),
                    child: const Icon(Icons.arrow_back, size: 18, color: AppColors.text),
                  ),
                ),
                Text(
                  'Detalhes do Foco',
                  style: GoogleFonts.inter(
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                    color: AppColors.text,
                  ),
                ),
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: AppColors.card,
                    borderRadius: BorderRadius.circular(11),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: const Icon(Icons.share, size: 18, color: AppColors.primary),
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
              child: Column(
                children: [
                  _SatelliteImageCard(lat: lat, lon: lon, risk: risk),
                  const SizedBox(height: 14),

                  GlowCard(
                    glowColor: glowColor,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'ID: $focusId',
                                    style: GoogleFonts.inter(fontSize: 11, color: AppColors.mutedForeground, letterSpacing: 0.5),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(region,
                                      style: GoogleFonts.inter(fontSize: 20, fontWeight: FontWeight.w700, color: AppColors.text)),
                                  Text('Estado: $state · ${_fmt(area)} ha',
                                      style: GoogleFonts.inter(fontSize: 12, color: AppColors.mutedForeground)),
                                ],
                              ),
                            ),
                            RiskGauge(value: aiConfidence, size: 90),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Divider(color: AppColors.border, height: 1),
                        const SizedBox(height: 12),
                        RichText(
                          text: TextSpan(children: [
                            TextSpan(text: 'Confiança da IA: ', style: GoogleFonts.inter(fontSize: 12, color: AppColors.mutedForeground)),
                            TextSpan(text: '$aiConfidence%', style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w700, color: AppColors.accent)),
                          ]),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 14),

                  GlowCard(
                    glowColor: AppColors.primary,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Dados Climáticos', style: GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.w700, color: AppColors.text)),
                        const SizedBox(height: 14),
                        _DataRow(icon: Icons.thermostat, label: 'Temperatura', value: '${temperature}°C', color: AppColors.primary),
                        _DataRow(icon: Icons.water_drop_outlined, label: 'Umidade relativa', value: '$humidity%', color: AppColors.neonBlue),
                        _DataRow(icon: Icons.air, label: 'Velocidade do vento', value: '$windSpeed km/h', color: AppColors.accent),
                        _DataRow(icon: Icons.wb_sunny_outlined, label: 'Índice UV', value: '11 (Extremo)', color: AppColors.amber),
                        _DataRow(icon: Icons.cloud_outlined, label: 'Precipitação 24h', value: '0 mm', color: AppColors.mutedForeground),
                      ],
                    ),
                  ),
                  const SizedBox(height: 14),

                  GlowCard(
                    glowColor: AppColors.neonBlue,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Localização Precisa', style: GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.w700, color: AppColors.text)),
                        const SizedBox(height: 14),
                        _DataRow(icon: Icons.location_on_outlined, label: 'Latitude', value: '${lat.toStringAsFixed(6)}°', color: AppColors.neonBlue),
                        _DataRow(icon: Icons.location_on_outlined, label: 'Longitude', value: '${lon.toStringAsFixed(6)}°', color: AppColors.neonBlue),
                        _DataRow(icon: Icons.layers_outlined, label: 'Bioma', value: 'Amazônia / Cerrado', color: AppColors.accent),
                        _DataRow(icon: Icons.grid_on, label: 'Célula INPE', value: '10km × 10km', color: AppColors.mutedForeground),
                      ],
                    ),
                  ),
                  const SizedBox(height: 14),

                  GlowCard(
                    glowColor: AppColors.accent,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Análise da Inteligência Artificial',
                            style: GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.w700, color: AppColors.text)),
                        const SizedBox(height: 12),
                        _AiRow(label: 'Risco de propagação', value: 'MUITO ALTO', color: AppColors.riskHigh),
                        _AiRow(label: 'Velocidade estimada', value: '2.4 km/h', color: AppColors.secondary),
                        _AiRow(label: 'Direção prevista', value: 'Nordeste', color: AppColors.secondary),
                        _AiRow(label: 'Área em 12h (est.)', value: '${(area * 1.8).toStringAsFixed(0)} ha', color: AppColors.primary),
                        _AiRow(label: 'Probabilidade extinção', value: '8%', color: AppColors.accent, isLast: true),
                      ],
                    ),
                  ),
                  const SizedBox(height: 14),

                  SizedBox(
                    width: double.infinity,
                    child: TextButton.icon(
                      onPressed: () {},
                      style: TextButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                      ),
                      icon: const Icon(Icons.share, size: 18, color: Colors.white),
                      label: Text(
                        'Compartilhar Relatório',
                        style: GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.w700, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _fmt(int n) {
    if (n >= 1000) {
      return '${(n / 1000).toStringAsFixed(1).replaceAll('.', ',')}k';
    }
    return '$n';
  }
}

class _SatelliteImageCard extends StatelessWidget {
  final double lat;
  final double lon;
  final Intensity risk;

  const _SatelliteImageCard({required this.lat, required this.lon, required this.risk});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF0A1628), Color(0xFF081020), Color(0xFF050810)],
        ),
        border: Border.all(color: AppColors.border),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(14),
        child: Stack(
          children: [
            CustomPaint(
              size: const Size(double.infinity, 200),
              painter: _SatGridPainter(),
            ),
            Positioned(
              top: 10,
              left: 10,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.7),
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: AppColors.accent.withOpacity(0.18)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.radio_button_checked, size: 11, color: AppColors.accent),
                    const SizedBox(width: 5),
                    Text(
                      'IMAGEM SATELITAL — AQUA',
                      style: GoogleFonts.inter(
                        fontSize: 9,
                        fontWeight: FontWeight.w700,
                        color: AppColors.accent,
                        letterSpacing: 0.8,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 10,
              right: 10,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.7),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  '${lat.toStringAsFixed(4)}° S  ${lon.abs().toStringAsFixed(4)}° O',
                  style: GoogleFonts.inter(
                    fontSize: 9,
                    color: Colors.white.withOpacity(0.5),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 10,
              left: 10,
              child: RiskBadge(risk: risk, size: 'lg'),
            ),
            Center(
              child: Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: AppColors.riskHigh.withOpacity(0.15),
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.riskHigh.withOpacity(0.5), width: 1.5),
                ),
                child: const Icon(Icons.local_fire_department_rounded, size: 24, color: AppColors.riskHigh),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SatGridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.04)
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    for (int i = 0; i < 12; i++) {
      final y = i * (size.height / 10);
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
    for (int i = 0; i < 16; i++) {
      final x = i * (size.width / 12);
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter old) => false;
}

class _DataRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;

  const _DataRow({required this.icon, required this.label, required this.value, required this.color});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 9),
      child: Row(
        children: [
          Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              color: color.withOpacity(0.12),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, size: 15, color: color),
          ),
          const SizedBox(width: 10),
          Expanded(child: Text(label, style: GoogleFonts.inter(fontSize: 13, color: AppColors.mutedForeground))),
          Text(value, style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.text)),
        ],
      ),
    );
  }
}

class _AiRow extends StatelessWidget {
  final String label;
  final String value;
  final Color color;
  final bool isLast;

  const _AiRow({required this.label, required this.value, required this.color, this.isLast = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 9),
      decoration: BoxDecoration(
        border: isLast ? null : const Border(bottom: BorderSide(color: AppColors.border)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: GoogleFonts.inter(fontSize: 13, color: AppColors.mutedForeground)),
          Text(value, style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w700, color: color)),
        ],
      ),
    );
  }
}
