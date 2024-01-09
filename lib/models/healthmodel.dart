class HealthModel {
  final String healthId;
  late final String childId;
  late final String healthStatusId;
  late final String patientId;

  HealthModel({
    required this.healthId,
    required this.childId,
    required this.healthStatusId,
    required this.patientId,
  });
}

class BmiModel {
  final String bmiId;
  late final String healthId;
  late final double currentHeight;
  late final double currentWeight;
  late final double bmiData;
  late final DateTime createdAt;

  BmiModel({
    required this.bmiId,
    required this.healthId,
    required this.currentHeight,
    required this.currentWeight,
    required this.bmiData,
    required this.createdAt
  });
}

class BmiHealthModel{
  final bmiId;
  late final double bmiData;

  BmiHealthModel({
    required this.bmiId,
    required this.bmiData
  });
}