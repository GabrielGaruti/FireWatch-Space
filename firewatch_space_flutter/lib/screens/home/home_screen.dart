import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../data/mock_data.dart';
import '../../theme/app_theme.dart';
import '../../widgets/glow_card.dart';
import '../../widgets/mock_map.dart';
import '../../widgets/stat_card.dart';
import '../../widgets/weekly_chart.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _showSplash = true;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 2800), () {
      if (mounted) setState(() => _showSplash = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    final top = MediaQuery.of(context).padding.top;
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(16, top + 16, 16, 100),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _Header(onAlertsTap: () => context.go('/alerts')),
                const SizedBox(height: 16),
                _RiskCard(),
                const SizedBox(height: 16),
                _MapSection(),
                const SizedBox(height: 16),
                Row(children: [
                  StatCard(
                    label: 'Focos Ativos',
                    value: '1.298',
                    icon: Icons.local_fire_department_rounded,
                    iconColor: AppColors.riskHigh,
                    trend: '+12% hoje',
                  ),
                  const SizedBox(width: 12),
                  StatCard(
                    label: 'Alertas Enviados',
                    value: '847',
                    icon: Icons.notifications_active_rounded,
                    iconColor: AppColors.secondary,
                    trend: '+34 hoje',
                  ),
                ]),
                const SizedBox(height: 12),
                Row(children: [
                  StatCard(
                    label: 'Regiões Críticas',
                    value: '12',
                    icon: Icons.location_on_rounded,
                    iconColor: AppColors.primary,
                  ),
                  const SizedBox(width: 12),
                  StatCard(
                    label: 'Qualidade do Ar',
                    value: '156 AQI',
                    icon: Icons.air,
                    iconColor: AppColors.amber,
                    trend: 'Muito Ruim',
                  ),
                ]),
                const SizedBox(height: 16),
                _WeatherCard(),
                const SizedBox(height: 16),
                _CtaButton(onTap: () => context.go('/alerts')),
              ],
            ),
          ),
          if (_showSplash) const _SplashOverlay(),
        ],
      ),
    );
  }
}

class _Header extends StatelessWidget {
  final VoidCallback onAlertsTap;
  const _Header({required this.onAlertsTap});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Bem-vindo ao',
              style: GoogleFonts.inter(
                fontSize: 12,
                color: AppColors.mutedForeground,
              ),
            ),
            Text(
              'FireWatch Space',
              style: GoogleFonts.inter(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: AppColors.text,
              ),
            ),
          ],
        ),
        Stack(
          children: [
            GestureDetector(
              onTap: onAlertsTap,
              child: Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: AppColors.card,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.border),
                ),
                child: const Icon(Icons.notifications_none_rounded, size: 18, color: AppColors.text),
              ),
            ),
            Positioned(
              top: 8,
              right: 8,
              child: Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _RiskCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GlowCard(
      glowColor: AppColors.riskHigh,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'NÍVEL DE RISCO GERAL',
                    style: GoogleFonts.inter(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      color: AppColors.mutedForeground,
                      letterSpacing: 1,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'ALTO',
                    style: GoogleFonts.inter(
                      fontSize: 32,
                      fontWeight: FontWeight.w700,
                      color: AppColors.riskHigh,
                    ),
                  ),
                  Text(
                    'Atualizado há 3 minutos',
                    style: GoogleFonts.inter(
                      fontSize: 11,
                      color: AppColors.mutedForeground,
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '${appStats.overallRisk}%',
                    style: GoogleFonts.inter(
                      fontSize: 42,
                      fontWeight: FontWeight.w700,
                      color: AppColors.riskHigh,
                    ),
                  ),
                  const SizedBox(height: 6),
                  SizedBox(
                    width: 100,
                    child: Container(
                      height: 5,
                      decoration: BoxDecoration(
                        color: AppColors.riskHigh.withOpacity(0.08),
                        borderRadius: BorderRadius.circular(3),
                      ),
                      child: FractionallySizedBox(
                        alignment: Alignment.centerLeft,
                        widthFactor: appStats.overallRisk / 100,
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppColors.riskHigh,
                            borderRadius: BorderRadius.circular(3),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Icon(Icons.radio_button_checked, size: 12, color: AppColors.riskHigh.withOpacity(0.44)),
              const SizedBox(width: 6),
              Text(
                'Satélite AQUA/TERRA · INPE · NASA FIRMS',
                style: GoogleFonts.inter(
                  fontSize: 10,
                  color: AppColors.riskHigh.withOpacity(0.44),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _MapSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Mapa de Focos Ativos',
              style: GoogleFonts.inter(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: AppColors.text,
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: AppColors.riskHigh.withOpacity(0.25)),
              ),
              child: Row(
                children: [
                  Container(
                    width: 6,
                    height: 6,
                    decoration: const BoxDecoration(
                      color: AppColors.riskHigh,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 5),
                  Text(
                    'LIVE',
                    style: GoogleFonts.inter(
                      fontSize: 9,
                      fontWeight: FontWeight.w700,
                      color: AppColors.riskHigh,
                      letterSpacing: 1,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        const MockMap(),
      ],
    );
  }
}

class _WeatherCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GlowCard(
      glowColor: AppColors.primary,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Condições Climáticas',
            style: GoogleFonts.inter(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: AppColors.text,
            ),
          ),
          const SizedBox(height: 14),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _WeatherItem(
                icon: Icons.thermostat,
                label: 'Temperatura',
                value: '${appStats.temperature}°C',
                color: AppColors.primary,
              ),
              _WeatherItem(
                icon: Icons.water_drop_outlined,
                label: 'Umidade',
                value: '${appStats.humidity}%',
                color: AppColors.neonBlue,
              ),
              _WeatherItem(
                icon: Icons.air,
                label: 'Vento',
                value: '${appStats.windSpeed} km/h',
                color: AppColors.accent,
              ),
            ],
          ),
          const SizedBox(height: 14),
          Divider(color: AppColors.border, height: 1),
          const SizedBox(height: 14),
          const WeeklyChart(),
        ],
      ),
    );
  }
}

class _WeatherItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;

  const _WeatherItem({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 38,
          height: 38,
          decoration: BoxDecoration(
            color: color.withOpacity(0.12),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, size: 16, color: color),
        ),
        const SizedBox(height: 5),
        Text(value, style: GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.w700, color: AppColors.text)),
        Text(label, style: GoogleFonts.inter(fontSize: 10, color: AppColors.mutedForeground)),
      ],
    );
  }
}

class _CtaButton extends StatelessWidget {
  final VoidCallback onTap;
  const _CtaButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: AppColors.riskHigh,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.notifications_active_rounded, size: 18, color: Colors.white),
            const SizedBox(width: 10),
            Text(
              'Ver Alertas Ativos',
              style: GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.w700, color: Colors.white),
            ),
            const SizedBox(width: 10),
            const Icon(Icons.arrow_forward, size: 18, color: Colors.white),
          ],
        ),
      ),
    );
  }
}

class _SplashOverlay extends StatefulWidget {
  const _SplashOverlay();

  @override
  State<_SplashOverlay> createState() => _SplashOverlayState();
}

class _SplashOverlayState extends State<_SplashOverlay> with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _fade;
  late Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 2800));
    _fade = TweenSequence([
      TweenSequenceItem(tween: Tween<double>(begin: 0, end: 1), weight: 30),
      TweenSequenceItem(tween: ConstantTween<double>(1), weight: 50),
      TweenSequenceItem(tween: Tween<double>(begin: 1, end: 0), weight: 20),
    ]).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut));
    _scale = Tween<double>(begin: 0.85, end: 1).animate(
      CurvedAnimation(parent: _ctrl, curve: const Interval(0, 0.4, curve: Curves.easeOut)),
    );
    _ctrl.forward();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _ctrl,
      builder: (ctx, child) => Opacity(
        opacity: _fade.value,
        child: Container(
          color: AppColors.background,
          child: Center(
            child: Transform.scale(
              scale: _scale.value,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(0.08),
                      borderRadius: BorderRadius.circular(28),
                      border: Border.all(color: AppColors.primary.withOpacity(0.25), width: 1.5),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primary.withOpacity(0.3),
                          blurRadius: 24,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        const Icon(Icons.public, size: 42, color: AppColors.primary),
                        Positioned(
                          bottom: 14,
                          right: 14,
                          child: Container(
                            padding: const EdgeInsets.all(3),
                            decoration: BoxDecoration(
                              color: AppColors.secondary,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Icon(Icons.bolt, size: 14, color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'FireWatch Space',
                    style: GoogleFonts.inter(
                      fontSize: 26,
                      fontWeight: FontWeight.w700,
                      color: AppColors.text,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Monitoramento Inteligente de Queimadas',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                      fontSize: 13,
                      color: AppColors.mutedForeground,
                    ),
                  ),
                  const SizedBox(height: 32),
                  _LoadingDots(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _LoadingDots extends StatefulWidget {
  @override
  State<_LoadingDots> createState() => _LoadingDotsState();
}

class _LoadingDotsState extends State<_LoadingDots> with TickerProviderStateMixin {
  late List<AnimationController> _ctrls;
  late List<Animation<double>> _anims;

  @override
  void initState() {
    super.initState();
    _ctrls = List.generate(3, (i) {
      final c = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 500),
      );
      Future.delayed(Duration(milliseconds: i * 180), () {
        if (mounted) c.repeat(reverse: true);
      });
      return c;
    });
    _anims = _ctrls
        .map((c) => Tween<double>(begin: 0.3, end: 1.0).animate(c))
        .toList();
  }

  @override
  void dispose() {
    for (final c in _ctrls) c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(3, (i) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: AnimatedBuilder(
            animation: _anims[i],
            builder: (ctx, _) => Opacity(
              opacity: _anims[i].value,
              child: Transform.scale(
                scale: 0.8 + _anims[i].value * 0.4,
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: AppColors.primary,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
