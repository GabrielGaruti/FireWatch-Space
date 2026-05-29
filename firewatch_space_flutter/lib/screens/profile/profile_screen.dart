import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../theme/app_theme.dart';
import '../../widgets/glow_card.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _notifEnabled = true;
  bool _darkMode = true;
  bool _locationEnabled = true;
  bool _highRiskOnly = false;

  @override
  Widget build(BuildContext context) {
    final top = MediaQuery.of(context).padding.top;
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(16, top + 12, 16, 100),
        child: Column(
          children: [
            _AvatarSection(),
            const SizedBox(height: 14),
            _StatsRow(),
            const SizedBox(height: 14),

            GlowCard(
              glowColor: AppColors.secondary,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _GroupTitle('NOTIFICAÇÕES'),
                  _SettingRow(
                    icon: Icons.notifications_active_outlined,
                    label: 'Notificações ativas',
                    iconColor: AppColors.secondary,
                    toggle: true,
                    toggleValue: _notifEnabled,
                    onToggle: (v) => setState(() => _notifEnabled = v),
                  ),
                  _SettingRow(
                    icon: Icons.warning_amber_rounded,
                    label: 'Apenas risco alto',
                    iconColor: AppColors.riskHigh,
                    toggle: true,
                    toggleValue: _highRiskOnly,
                    onToggle: (v) => setState(() => _highRiskOnly = v),
                  ),
                  _SettingRow(
                    icon: Icons.access_time,
                    label: 'Frequência de alertas',
                    iconColor: AppColors.secondary,
                    value: 'Em tempo real',
                    isLast: true,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 14),

            GlowCard(
              glowColor: AppColors.neonBlue,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _GroupTitle('APARÊNCIA'),
                  _SettingRow(
                    icon: Icons.dark_mode_outlined,
                    label: 'Modo escuro',
                    iconColor: AppColors.neonBlue,
                    toggle: true,
                    toggleValue: _darkMode,
                    onToggle: (v) => setState(() => _darkMode = v),
                  ),
                  _SettingRow(
                    icon: Icons.layers_outlined,
                    label: 'Tema',
                    iconColor: AppColors.neonBlue,
                    value: 'FireWatch Dark',
                    isLast: true,
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
                  _GroupTitle('LOCALIZAÇÃO E DADOS'),
                  _SettingRow(
                    icon: Icons.location_on_outlined,
                    label: 'Localização automática',
                    iconColor: AppColors.accent,
                    toggle: true,
                    toggleValue: _locationEnabled,
                    onToggle: (v) => setState(() => _locationEnabled = v),
                  ),
                  _SettingRow(
                    icon: Icons.public,
                    label: 'Satélite preferido',
                    iconColor: AppColors.accent,
                    value: 'AQUA/TERRA',
                  ),
                  _SettingRow(
                    icon: Icons.refresh,
                    label: 'Intervalo de atualização',
                    iconColor: AppColors.accent,
                    value: '5 minutos',
                    isLast: true,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 14),

            GlowCard(
              glowColor: AppColors.mutedForeground,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _GroupTitle('SOBRE O APP'),
                  _SettingRow(icon: Icons.info_outline, label: 'Versão', value: '1.0.0 (MVP)', iconColor: AppColors.mutedForeground),
                  _SettingRow(icon: Icons.code, label: 'Plataforma', value: 'FireWatch Space', iconColor: AppColors.mutedForeground),
                  _SettingRow(icon: Icons.storage_outlined, label: 'Fonte de dados', value: 'INPE · NASA FIRMS', iconColor: AppColors.mutedForeground),
                  _SettingRow(icon: Icons.emoji_events_outlined, label: 'Projeto', value: 'FIAP Global Solution', iconColor: AppColors.mutedForeground, isLast: true),
                ],
              ),
            ),
            const SizedBox(height: 14),

            GestureDetector(
              onTap: () {},
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 14),
                decoration: BoxDecoration(
                  color: AppColors.riskHigh.withOpacity(0.06),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: AppColors.riskHigh.withOpacity(0.18)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.logout, size: 16, color: AppColors.riskHigh),
                    const SizedBox(width: 10),
                    Text(
                      'Sair da conta',
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.riskHigh,
                      ),
                    ),
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

class _AvatarSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 90,
          height: 90,
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(28),
            border: Border.all(color: AppColors.primary.withOpacity(0.3), width: 2),
          ),
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.12),
              borderRadius: BorderRadius.circular(22),
            ),
            child: const Icon(Icons.person_outline, size: 36, color: AppColors.primary),
          ),
        ),
        const SizedBox(height: 10),
        Text(
          'Pesquisador FIAP',
          style: GoogleFonts.inter(fontSize: 20, fontWeight: FontWeight.w700, color: AppColors.text),
        ),
        const SizedBox(height: 4),
        Text(
          'fiap.gs@firewatch.space',
          style: GoogleFonts.inter(fontSize: 12, color: AppColors.mutedForeground),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: AppColors.accent.withOpacity(0.12),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppColors.accent.withOpacity(0.25)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.shield_outlined, size: 11, color: AppColors.accent),
              const SizedBox(width: 5),
              Text(
                'Analista Certificado',
                style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w600, color: AppColors.accent),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _StatsRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final stats = [
      ('Alertas', '847'),
      ('Focos', '1.298'),
      ('Relatórios', '36'),
    ];
    return Row(
      children: stats.map((s) {
        final isLast = s == stats.last;
        return Expanded(
          child: Container(
            margin: EdgeInsets.only(right: isLast ? 0 : 10),
            padding: const EdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(
              color: AppColors.card,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.border),
            ),
            child: Column(
              children: [
                Text(s.$2, style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.w700, color: AppColors.primary)),
                const SizedBox(height: 2),
                Text(s.$1, style: GoogleFonts.inter(fontSize: 10, color: AppColors.mutedForeground)),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}

class _GroupTitle extends StatelessWidget {
  final String title;
  const _GroupTitle(this.title);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Text(
        title,
        style: GoogleFonts.inter(
          fontSize: 10,
          fontWeight: FontWeight.w700,
          color: AppColors.mutedForeground,
          letterSpacing: 1,
        ),
      ),
    );
  }
}

class _SettingRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color iconColor;
  final String? value;
  final bool toggle;
  final bool? toggleValue;
  final ValueChanged<bool>? onToggle;
  final bool isLast;

  const _SettingRow({
    required this.icon,
    required this.label,
    required this.iconColor,
    this.value,
    this.toggle = false,
    this.toggleValue,
    this.onToggle,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 11),
      decoration: isLast
          ? null
          : const BoxDecoration(border: Border(bottom: BorderSide(color: AppColors.border))),
      child: Row(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.12),
              borderRadius: BorderRadius.circular(9),
            ),
            child: Icon(icon, size: 16, color: iconColor),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              label,
              style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w500, color: AppColors.text),
            ),
          ),
          if (toggle && onToggle != null)
            Switch(
              value: toggleValue ?? false,
              onChanged: onToggle,
              activeColor: iconColor,
              activeTrackColor: iconColor.withOpacity(0.38),
              inactiveTrackColor: AppColors.muted,
              inactiveThumbColor: AppColors.mutedForeground,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            )
          else if (value != null)
            Text(value!, style: GoogleFonts.inter(fontSize: 12, color: AppColors.mutedForeground))
          else
            const Icon(Icons.chevron_right, size: 16, color: AppColors.mutedForeground),
        ],
      ),
    );
  }
}
