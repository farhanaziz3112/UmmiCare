class HealthModel {
  final String healthId;
  late final String childId;
  late final String healthStatusId;
  late final String bmiId;

  HealthModel({
    required this.healthId,
    required this.childId,
    required this.healthStatusId,
    required this.bmiId,
  });
}

class BmiModel {
  final String bmiId;
  late final double currentHeight;
  late final double currentWeight;
  late final double bmiData;
  late final DateTime createdAt;

  BmiModel({
    required this.bmiId,
    required this.currentHeight,
    required this.currentWeight,
    required this.bmiData,
    required this.createdAt
  });
}