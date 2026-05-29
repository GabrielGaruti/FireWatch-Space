enum Intensity { alto, medio, baixo }

enum AlertType { foco, clima, alerta }

class FireFocus {
  final String id;
  final String region;
  final String state;
  final double lat;
  final double lon;
  final double temperature;
  final int humidity;
  final int windSpeed;
  final int aiConfidence;
  final Intensity intensity;
  final String detectedAt;
  final int area;
  final double mapX;
  final double mapY;

  const FireFocus({
    required this.id,
    required this.region,
    required this.state,
    required this.lat,
    required this.lon,
    required this.temperature,
    required this.humidity,
    required this.windSpeed,
    required this.aiConfidence,
    required this.intensity,
    required this.detectedAt,
    required this.area,
    required this.mapX,
    required this.mapY,
  });
}

class Alert {
  final String id;
  final String region;
  final String state;
  final Intensity risk;
  final String time;
  final String description;
  final AlertType type;
  final bool isNew;

  const Alert({
    required this.id,
    required this.region,
    required this.state,
    required this.risk,
    required this.time,
    required this.description,
    required this.type,
    required this.isNew,
  });
}

class WeeklyPoint {
  final String day;
  final int focos;
  const WeeklyPoint({required this.day, required this.focos});
}

class RegionData {
  final String region;
  final int focos;
  final int percentage;
  const RegionData({required this.region, required this.focos, required this.percentage});
}

class AiAnalysisItem {
  final String label;
  final int value;
  final String status;
  const AiAnalysisItem({required this.label, required this.value, required this.status});
}

class Stats {
  final int activeFoci;
  final int alertsSent;
  final int criticalRegions;
  final int airQuality;
  final int overallRisk;
  final String riskLevel;
  final double temperature;
  final int humidity;
  final int windSpeed;

  const Stats({
    required this.activeFoci,
    required this.alertsSent,
    required this.criticalRegions,
    required this.airQuality,
    required this.overallRisk,
    required this.riskLevel,
    required this.temperature,
    required this.humidity,
    required this.windSpeed,
  });
}
