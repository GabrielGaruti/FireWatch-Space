import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import '../data/mock_data.dart';
import '../models/models.dart';
import '../theme/app_theme.dart';

class AiSection extends StatelessWidget {
  const AiSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  width: 7,
                  height: 7,
                  decoration: const BoxDecoration(
                    color: AppColors.accent,
                    shape: BoxShape.circle,
                  ),
                )
                    .animate(onPlay: (c) => c.repeat(reverse: true))
                    .fadeIn(duration: 600.ms)
                    .then()
                    .fadeOut(duration: 600.ms),
                const SizedBox(width: 7),
                Text(
                  'IA ANALISANDO DADOS CLIMÁTICOS…',
                  style: GoogleFonts.inter(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    color: AppColors.accent,
                    letterSpacing: 0.8,
                  ),
                ),
              ],
            ),
            const Icon(Icons.memory, size: 16, color: AppColors.accent),
          ],
        ),
        const SizedBox(height: 14),
        ...List.generate(aiAnalysis.length, (i) {
          final item = aiAnalysis[i];
          return _AiBar(item: item, index: i);
        }),
        const SizedBox(height: 14),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppColors.accent.withOpacity(0.03),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: AppColors.accent.withOpacity(0.18)),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.bolt, size: 13, color: AppColors.accent),
              const SizedBox(width: 8),
              Expanded(
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Previsão IA: ',
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: AppColors.accent,
                          height: 1.5,
                        ),
                      ),
                      TextSpan(
                        text:
                            'Risco MUITO ALTO nas próximas 48h para Mato Grosso e Amazônia. Probabilidade de propagação: 91%.',
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          color: AppColors.mutedForeground,
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _AiBar extends StatefulWidget {
  final AiAnalysisItem item;
  final int index;

  const _AiBar({required this.item, required this.index});

  @override
  State<_AiBar> createState() => _AiBarState();
}

class _AiBarState extends State<_AiBar> with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _anim;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
    _anim = Tween<double>(begin: 0, end: widget.item.value / 100).animate(
      CurvedAnimation(parent: _ctrl, curve: Curves.easeOut),
    );
    Future.delayed(Duration(milliseconds: widget.index * 180), () {
      if (mounted) _ctrl.forward();
    });
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  Color get _barColor {
    switch (widget.item.status) {
      case 'crítico': return AppColors.riskHigh;
      case 'alto': return AppColors.riskMedium;
      default: return AppColors.riskLow;
    }
  }

  @override
  Widget build(BuildContext context) {
    final color = _barColor;
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.item.label,
                style: GoogleFonts.inter(
                  fontSize: 11,
                  color: AppColors.mutedForeground,
                ),
              ),
              Text(
                '${widget.item.value}%',
                style: GoogleFonts.inter(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: color,
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          AnimatedBuilder(
            animation: _anim,
            builder: (ctx, _) => Container(
              height: 5,
              decoration: BoxDecoration(
                color: AppColors.muted,
                borderRadius: BorderRadius.circular(3),
              ),
              child: FractionallySizedBox(
                alignment: Alignment.centerLeft,
                widthFactor: _anim.value,
                child: Container(
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
