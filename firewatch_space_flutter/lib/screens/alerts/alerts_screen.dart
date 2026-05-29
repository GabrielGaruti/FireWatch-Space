import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../data/mock_data.dart';
import '../../models/models.dart';
import '../../theme/app_theme.dart';
import '../../widgets/alert_card.dart';

const _filters = [
  ('todos', 'Todos'),
  ('alto', 'Alto'),
  ('medio', 'Médio'),
  ('baixo', 'Baixo'),
];

class AlertsScreen extends StatefulWidget {
  const AlertsScreen({super.key});

  @override
  State<AlertsScreen> createState() => _AlertsScreenState();
}

class _AlertsScreenState extends State<AlertsScreen> {
  String _activeFilter = 'todos';

  List<Alert> get _filtered {
    if (_activeFilter == 'todos') return alerts;
    final intensity = _activeFilter == 'alto'
        ? Intensity.alto
        : _activeFilter == 'medio'
            ? Intensity.medio
            : Intensity.baixo;
    return alerts.where((a) => a.risk == intensity).toList();
  }

  int _countForFilter(String key) {
    if (key == 'todos') return alerts.length;
    final intensity = key == 'alto'
        ? Intensity.alto
        : key == 'medio'
            ? Intensity.medio
            : Intensity.baixo;
    return alerts.where((a) => a.risk == intensity).length;
  }

  @override
  Widget build(BuildContext context) {
    final top = MediaQuery.of(context).padding.top;
    final newCount = alerts.where((a) => a.isNew).length;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(16, top + 12, 16, 14),
            decoration: const BoxDecoration(
              border: Border(bottom: BorderSide(color: AppColors.border)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Alertas',
                      style: GoogleFonts.inter(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        color: AppColors.text,
                      ),
                    ),
                    Text(
                      '$newCount novos alertas hoje',
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        color: AppColors.mutedForeground,
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppColors.riskHigh.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: AppColors.riskHigh.withOpacity(0.25)),
                  ),
                  child: Text(
                    '${alerts.length}',
                    style: GoogleFonts.inter(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: AppColors.riskHigh,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 54,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              children: _filters.map((f) {
                final isActive = _activeFilter == f.$1;
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: GestureDetector(
                    onTap: () => setState(() => _activeFilter = f.$1),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
                      decoration: BoxDecoration(
                        color: isActive ? AppColors.primary : AppColors.card,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: isActive ? AppColors.primary : AppColors.border,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            f.$2,
                            style: GoogleFonts.inter(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: isActive ? Colors.white : AppColors.mutedForeground,
                            ),
                          ),
                          if (f.$1 != 'todos') ...[
                            const SizedBox(width: 5),
                            Text(
                              '${_countForFilter(f.$1)}',
                              style: GoogleFonts.inter(
                                fontSize: 12,
                                color: isActive
                                    ? Colors.white.withOpacity(0.6)
                                    : AppColors.mutedForeground.withOpacity(0.5),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          Expanded(
            child: _filtered.isEmpty
                ? Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.check_circle_outline, size: 40, color: AppColors.mutedForeground),
                        const SizedBox(height: 12),
                        Text(
                          'Nenhum alerta neste nível',
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            color: AppColors.mutedForeground,
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView(
                    padding: const EdgeInsets.fromLTRB(16, 12, 16, 100),
                    children: _filtered.map((a) => AlertCard(alert: a)).toList(),
                  ),
          ),
        ],
      ),
    );
  }
}
