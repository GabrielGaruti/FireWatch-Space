import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';

class RiskGauge extends StatefulWidget {
  final int value;
  final double size;

  const RiskGauge({super.key, required this.value, this.size = 140});

  @override
  State<RiskGauge> createState() => _RiskGaugeState();
}

class _RiskGaugeState extends State<RiskGauge> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 1500));
    _animation = Tween<double>(begin: 0, end: widget.value / 100).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Color _gaugeColor(int value) {
    if (value >= 75) return AppColors.riskHigh;
    if (value >= 50) return AppColors.riskMedium;
    return AppColors.riskLow;
  }

  String _riskLabel(int value) {
    if (value >= 75) return 'ALTO';
    if (value >= 50) return 'MÉDIO';
    return 'BAIXO';
  }

  @override
  Widget build(BuildContext context) {
    final color = _gaugeColor(widget.value);
    final label = _riskLabel(widget.value);

    return SizedBox(
      width: widget.size,
      height: widget.size,
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          return CustomPaint(
            painter: _GaugePainter(
              progress: _animation.value,
              color: color,
            ),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '${widget.value}%',
                    style: GoogleFonts.inter(
                      fontSize: widget.size * 0.18,
                      fontWeight: FontWeight.w700,
                      color: color,
                    ),
                  ),
                  Text(
                    label,
                    style: GoogleFonts.inter(
                      fontSize: widget.size * 0.07,
                      fontWeight: FontWeight.w700,
                      color: color,
                      letterSpacing: 1,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _GaugePainter extends CustomPainter {
  final double progress;
  final Color color;

  _GaugePainter({required this.progress, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final cx = size.width / 2;
    final cy = size.height / 2;
    final r = size.width * 0.38;
    final strokeWidth = size.width * 0.08;

    const startAngle = math.pi * 0.75;
    const sweepAngle = math.pi * 1.5;

    final trackPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..color = Colors.white.withOpacity(0.06);

    canvas.drawArc(
      Rect.fromCircle(center: Offset(cx, cy), radius: r),
      startAngle,
      sweepAngle,
      false,
      trackPaint,
    );

    if (progress > 0) {
      final fillPaint = Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth
        ..strokeCap = StrokeCap.round
        ..shader = SweepGradient(
          startAngle: startAngle,
          endAngle: startAngle + sweepAngle,
          colors: [color.withOpacity(0.4), color],
        ).createShader(Rect.fromCircle(center: Offset(cx, cy), radius: r));

      canvas.drawArc(
        Rect.fromCircle(center: Offset(cx, cy), radius: r),
        startAngle,
        sweepAngle * progress,
        false,
        fillPaint,
      );
    }

    final innerPaint = Paint()
      ..style = PaintingStyle.fill
      ..color = AppColors.card;
    canvas.drawCircle(Offset(cx, cy), r * 0.65, innerPaint);
  }

  @override
  bool shouldRepaint(covariant _GaugePainter old) =>
      old.progress != progress || old.color != color;
}
