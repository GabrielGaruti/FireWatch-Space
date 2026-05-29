# FireWatch Space — Flutter

**Monitoramento Inteligente de Queimadas**  
Projeto FIAP Global Solution — Migração completa de React Native/Expo para Flutter.

---

## Como executar

```bash
cd firewatch_space_flutter
flutter pub get
flutter run
```

## Telas

| Tela | Rota |
|------|------|
| Splash Screen | Overlay na Home (auto-dismiss 2.8s) |
| Home Dashboard | `/` |
| Alertas | `/alerts` |
| Analytics | `/analytics` |
| Perfil | `/profile` |
| Detalhes do Foco | `/focus/:id` |

## Stack

- **Flutter** + **Dart**
- **go_router** — navegação declarativa
- **google_fonts** — tipografia Inter
- **flutter_animate** — animações de IA e splash
- **fl_chart** — incluído no pubspec
- **provider** — incluído no pubspec
- Material Design 3 com tema escuro customizado

## Estrutura

```
lib/
├── main.dart                  # Entry point + roteamento go_router
├── theme/
│   └── app_theme.dart         # Cores (AppColors) e ThemeData escuro
├── models/
│   └── models.dart            # FireFocus, Alert, WeeklyPoint, RegionData…
├── data/
│   └── mock_data.dart         # Dados mockados (focos, alertas, estatísticas)
├── widgets/
│   ├── glow_card.dart         # Card com borda e glow colorido
│   ├── risk_badge.dart        # Badge ALTO/MÉDIO/BAIXO
│   ├── risk_gauge.dart        # Medidor circular animado (CustomPainter)
│   ├── stat_card.dart         # Card de estatística com ícone
│   ├── alert_card.dart        # Card de alerta com navegação
│   ├── mock_map.dart          # Mapa do Brasil com pins pulsantes (CustomPainter)
│   ├── weekly_chart.dart      # Gráfico de barras semanal
│   ├── region_chart.dart      # Distribuição por região (barras horizontais)
│   └── ai_section.dart        # Seção de IA com barras animadas
└── screens/
    ├── home/home_screen.dart
    ├── alerts/alerts_screen.dart
    ├── analytics/analytics_screen.dart
    ├── focus/focus_detail_screen.dart
    └── profile/profile_screen.dart
```

## Identidade Visual

- **Background:** `#08080F` — preto espacial
- **Card:** `#0D0D1A` — cinza escuro
- **Primary:** `#FF4500` — laranja queimado
- **Risk High:** `#FF2040` — vermelho
- **Accent:** `#00FF88` — verde neon
- **Fonte:** Inter (Google Fonts)

## Funcionalidades

- Splash animado com loading dots e fade-out
- Mapa do Brasil com 7 focos de incêndio pulsantes
- Dashboard com nível de risco 82%, estatísticas e condições climáticas
- Gráfico semanal de focos (Seg–Dom)
- Filtro de alertas por criticidade (Todos / Alto / Médio / Baixo)
- Dashboard analítico com gauge, região, indicadores ambientais e AQI
- Simulação de IA com barras de progresso animadas e previsão 48h
- Tela de detalhes com dados climáticos, localização e análise IA
- Perfil com toggles de notificações, localização e aparência
- Navegação completa via bottom nav + go_router
