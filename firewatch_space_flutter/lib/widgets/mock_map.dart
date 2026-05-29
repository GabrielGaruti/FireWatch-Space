import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../data/mock_data.dart';
import '../models/models.dart';
import '../theme/app_theme.dart';

class MockMap extends StatefulWidget {
  const MockMap({super.key});

  @override
  State<MockMap> createState() => _MockMapState();
}

class _MockMapState extends State<MockMap> with TickerProviderStateMixin {
  late List<AnimationController> _controllers;
  late List<Animation<double>> _animations;

  @override
  void initState() {
    super.initState();
    final rng = math.Random();
    _controllers = List.generate(fireFocuses.length, (i) {
      final ctrl = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 1000 + rng.nextInt(500)),
      );
      Future.delayed(Duration(milliseconds: i * 150), () {
        if (mounted) ctrl.repeat(reverse: true);
      });
      return ctrl;
    });
    _animations = _controllers
        .map((c) => Tween<double>(begin: 0, end: 1).animate(
              CurvedAnimation(parent: c, curve: Curves.easeInOut),
            ))
        .toList();
  }

  @override
  void dispose() {
    for (final c in _controllers) {
      c.dispose();
    }
    super.dispose();
  }

  Color _pinColor(Intensity intensity) {
    switch (intensity) {
      case Intensity.alto: return AppColors.riskHigh;
      case Intensity.medio: return AppColors.riskMedium;
      case Intensity.baixo: return AppColors.riskLow;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 280,
      decoration: BoxDecoration(
        color: const Color(0xFF070712),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.border),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(14),
        child: Stack(
          children: [
            CustomPaint(
              size: const Size(double.infinity, 280),
              painter: _MapPainter(),
            ),
            ...List.generate(fireFocuses.length, (i) {
              final f = fireFocuses[i];
              final color = _pinColor(f.intensity);
              return AnimatedBuilder(
                animation: _animations[i],
                builder: (context, child) {
                  return LayoutBuilder(
                    builder: (ctx, constraints) {
                      final w = constraints.maxWidth;
                      const h = 280.0;
                      final px = f.mapX * w;
                      final py = f.mapY * h;
                      final ringScale = 1.0 + _animations[i].value * 1.2;
                      final ringOpacity = (1 - _animations[i].value) * 0.7;
                      return Positioned(
                        left: px - 10,
                        top: py - 10,
                        child: SizedBox(
                          width: 20,
                          height: 20,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Transform.scale(
                                scale: ringScale,
                                child: Opacity(
                                  opacity: ringOpacity,
                                  child: Container(
                                    width: 20,
                                    height: 20,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(color: color, width: 1.5),
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                width: 8,
                                height: 8,
                                decoration: BoxDecoration(
                                  color: color,
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              );
            }),
            Positioned(
              top: 10,
              left: 10,
              child: _Tag(
                dot: AppColors.accent,
                text: 'SATÉLITE ATIVO',
              ),
            ),
            Positioned(
              top: 10,
              right: 10,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.6),
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: Colors.white.withOpacity(0.06)),
                ),
                child: Text(
                  '-15.7801° S  47.9292° O',
                  style: GoogleFonts.inter(
                    fontSize: 9,
                    color: Colors.white.withOpacity(0.5),
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 10,
              right: 10,
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.7),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.white.withOpacity(0.06)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _LegendItem(color: AppColors.riskHigh, label: 'Alto'),
                    const SizedBox(height: 4),
                    _LegendItem(color: AppColors.riskMedium, label: 'Médio'),
                    const SizedBox(height: 4),
                    _LegendItem(color: AppColors.riskLow, label: 'Baixo'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Tag extends StatelessWidget {
  final Color dot;
  final String text;
  const _Tag({required this.dot, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.6),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: AppColors.accent.withOpacity(0.18)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(color: dot, shape: BoxShape.circle),
          ),
          const SizedBox(width: 5),
          Text(
            text,
            style: GoogleFonts.inter(
              fontSize: 9,
              fontWeight: FontWeight.w700,
              color: AppColors.accent,
              letterSpacing: 1,
            ),
          ),
        ],
      ),
    );
  }
}

class _LegendItem extends StatelessWidget {
  final Color color;
  final String label;
  const _LegendItem({required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 7,
          height: 7,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 5),
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 9,
            color: Colors.white.withOpacity(0.6),
          ),
        ),
      ],
    );
  }
}

class _MapPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    final gridPaint = Paint()
      ..color = Colors.white.withOpacity(0.03)
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    for (int i = 0; i < 8; i++) {
      final y = i * 40.0;
      canvas.drawLine(Offset(0, y), Offset(w, y), gridPaint);
    }
    for (int i = 0; i < 12; i++) {
      final x = i * (w / 10);
      canvas.drawLine(Offset(x, 0), Offset(x, h), gridPaint);
    }

    final scaleX = w / 340.0;
    final scaleY = h / 280.0;

    final path = Path();
    final pts = [
      Offset(155, 18), Offset(178, 22), Offset(205, 28), Offset(228, 42),
      Offset(248, 58), Offset(262, 78), Offset(271, 100), Offset(268, 120),
      Offset(278, 138), Offset(290, 158), Offset(288, 178), Offset(276, 195),
      Offset(258, 210), Offset(238, 230), Offset(218, 252), Offset(198, 265),
      Offset(180, 270), Offset(162, 265), Offset(142, 252), Offset(122, 235),
      Offset(102, 218), Offset(84, 198), Offset(68, 175), Offset(58, 152),
      Offset(52, 128), Offset(56, 105), Offset(68, 85), Offset(82, 68),
      Offset(98, 54), Offset(116, 40), Offset(134, 28),
    ];

    path.moveTo(pts[0].dx * scaleX, pts[0].dy * scaleY);
    for (int i = 1; i < pts.length; i++) {
      path.lineTo(pts[i].dx * scaleX, pts[i].dy * scaleY);
    }
    path.close();

    canvas.drawPath(
      path,
      Paint()
        ..color = const Color(0xFF0D1528)
        ..style = PaintingStyle.fill,
    );
    canvas.drawPath(
      path,
      Paint()
        ..color = const Color(0xFF1E3050)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.5,
    );

    final textPainter = TextPainter(
      text: TextSpan(
        text: 'BRASIL',
        style: GoogleFonts.inter(
          fontSize: 8,
          fontWeight: FontWeight.w700,
          color: Colors.white.withOpacity(0.08),
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    textPainter.paint(
      canvas,
      Offset(158 * scaleX - textPainter.width / 2, 148 * scaleY),
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
