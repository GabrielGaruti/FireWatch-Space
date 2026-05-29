import '../models/models.dart';

const fireFocuses = [
  FireFocus(
    id: 'F001', region: 'Mato Grosso', state: 'MT',
    lat: -12.6819, lon: -56.9211,
    temperature: 38.4, humidity: 18, windSpeed: 24,
    aiConfidence: 96, intensity: Intensity.alto,
    detectedAt: '2024-01-15T08:32:00Z', area: 1240,
    mapX: 0.44, mapY: 0.52,
  ),
  FireFocus(
    id: 'F002', region: 'Amazônia', state: 'AM',
    lat: -3.4168, lon: -65.8561,
    temperature: 35.1, humidity: 22, windSpeed: 18,
    aiConfidence: 91, intensity: Intensity.alto,
    detectedAt: '2024-01-15T07:15:00Z', area: 860,
    mapX: 0.27, mapY: 0.30,
  ),
  FireFocus(
    id: 'F003', region: 'Pará', state: 'PA',
    lat: -3.1191, lon: -52.0,
    temperature: 36.8, humidity: 25, windSpeed: 15,
    aiConfidence: 88, intensity: Intensity.alto,
    detectedAt: '2024-01-15T06:50:00Z', area: 540,
    mapX: 0.52, mapY: 0.28,
  ),
  FireFocus(
    id: 'F004', region: 'Maranhão', state: 'MA',
    lat: -5.4209, lon: -45.4442,
    temperature: 34.2, humidity: 31, windSpeed: 12,
    aiConfidence: 79, intensity: Intensity.medio,
    detectedAt: '2024-01-15T09:05:00Z', area: 320,
    mapX: 0.64, mapY: 0.29,
  ),
  FireFocus(
    id: 'F005', region: 'Rondônia', state: 'RO',
    lat: -11.5057, lon: -63.5806,
    temperature: 37.0, humidity: 20, windSpeed: 21,
    aiConfidence: 93, intensity: Intensity.alto,
    detectedAt: '2024-01-15T05:40:00Z', area: 680,
    mapX: 0.33, mapY: 0.48,
  ),
  FireFocus(
    id: 'F006', region: 'Bahia', state: 'BA',
    lat: -12.5797, lon: -41.7007,
    temperature: 33.5, humidity: 28, windSpeed: 16,
    aiConfidence: 74, intensity: Intensity.medio,
    detectedAt: '2024-01-15T10:20:00Z', area: 190,
    mapX: 0.69, mapY: 0.50,
  ),
  FireFocus(
    id: 'F007', region: 'Tocantins', state: 'TO',
    lat: -10.1753, lon: -48.2982,
    temperature: 36.1, humidity: 23, windSpeed: 19,
    aiConfidence: 85, intensity: Intensity.alto,
    detectedAt: '2024-01-15T07:55:00Z', area: 430,
    mapX: 0.57, mapY: 0.43,
  ),
];

const alerts = [
  Alert(
    id: 'A001', region: 'Mato Grosso', state: 'MT', risk: Intensity.alto,
    time: 'Há 12 min',
    description: 'Foco de incêndio crítico detectado por satélite AQUA. Área estimada: 1.240 hectares.',
    type: AlertType.foco, isNew: true,
  ),
  Alert(
    id: 'A002', region: 'Amazônia', state: 'AM', risk: Intensity.alto,
    time: 'Há 48 min',
    description: 'Múltiplos focos detectados na região do Rio Solimões. Condições climáticas desfavoráveis.',
    type: AlertType.foco, isNew: true,
  ),
  Alert(
    id: 'A003', region: 'Pará', state: 'PA', risk: Intensity.alto,
    time: 'Há 1h 12min',
    description: 'Foco ativo próximo à Reserva Extrativista. Ventos favorecem propagação.',
    type: AlertType.alerta, isNew: true,
  ),
  Alert(
    id: 'A004', region: 'Rondônia', state: 'RO', risk: Intensity.alto,
    time: 'Há 2h 05min',
    description: 'Queimadas na região de Porto Velho. Umidade abaixo de 20%.',
    type: AlertType.foco, isNew: false,
  ),
  Alert(
    id: 'A005', region: 'Cerrado Central', state: 'GO', risk: Intensity.medio,
    time: 'Há 3h 30min',
    description: 'Clima favorável para queimadas detectado. Temperatura alta e baixa umidade.',
    type: AlertType.clima, isNew: false,
  ),
  Alert(
    id: 'A006', region: 'Maranhão', state: 'MA', risk: Intensity.medio,
    time: 'Há 4h 15min',
    description: 'Foco de queimada detectado na zona de transição Cerrado-Amazônia.',
    type: AlertType.foco, isNew: false,
  ),
  Alert(
    id: 'A007', region: 'Tocantins', state: 'TO', risk: Intensity.alto,
    time: 'Há 5h 20min',
    description: 'Alerta máximo emitido pelo INPE. Múltiplos satélites confirmam o foco.',
    type: AlertType.alerta, isNew: false,
  ),
  Alert(
    id: 'A008', region: 'Bahia', state: 'BA', risk: Intensity.medio,
    time: 'Há 6h',
    description: 'Foco de queimada na Chapada Diamantina. Brigadas mobilizadas.',
    type: AlertType.foco, isNew: false,
  ),
  Alert(
    id: 'A009', region: 'Sul do Pará', state: 'PA', risk: Intensity.baixo,
    time: 'Há 8h',
    description: 'Monitoramento preventivo ativo. Índice de risco em elevação.',
    type: AlertType.clima, isNew: false,
  ),
];

const weeklyData = [
  WeeklyPoint(day: 'Seg', focos: 142),
  WeeklyPoint(day: 'Ter', focos: 198),
  WeeklyPoint(day: 'Qua', focos: 176),
  WeeklyPoint(day: 'Qui', focos: 234),
  WeeklyPoint(day: 'Sex', focos: 287),
  WeeklyPoint(day: 'Sab', focos: 312),
  WeeklyPoint(day: 'Dom', focos: 268),
];

const regionalData = [
  RegionData(region: 'Amazônia', focos: 487, percentage: 38),
  RegionData(region: 'Cerrado', focos: 312, percentage: 24),
  RegionData(region: 'Mato Grosso', focos: 276, percentage: 21),
  RegionData(region: 'Nordeste', focos: 143, percentage: 11),
  RegionData(region: 'Outros', focos: 80, percentage: 6),
];

const appStats = Stats(
  activeFoci: 1298,
  alertsSent: 847,
  criticalRegions: 12,
  airQuality: 156,
  overallRisk: 82,
  riskLevel: 'ALTO',
  temperature: 36.4,
  humidity: 22,
  windSpeed: 19,
);

const aiAnalysis = [
  AiAnalysisItem(label: 'Análise de temperatura', value: 89, status: 'crítico'),
  AiAnalysisItem(label: 'Índice de umidade', value: 78, status: 'alto'),
  AiAnalysisItem(label: 'Velocidade do vento', value: 65, status: 'moderado'),
  AiAnalysisItem(label: 'Densidade de vegetação', value: 91, status: 'crítico'),
  AiAnalysisItem(label: 'Previsão 48h', value: 84, status: 'alto'),
];
