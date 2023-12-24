class HealthStatusModel {
  final String healthStatusId;
  late final String currentTemperature;
  late final String currentHeartRate;
  late final String healthConditionId;
  late final String physicalConditionId;
  late final String chronicConditionId;

  HealthStatusModel({
    required this.healthStatusId,
    required this.currentTemperature,
    required this.currentHeartRate,
    required this.healthConditionId,
    required this.physicalConditionId,
    required this.chronicConditionId,
  });
}

class HealthConditionModel {
  final String healthConditionId;
  late final String currentSymptom;
  late final String currentIllness;
  late final String notes;

  HealthConditionModel({
    required this.healthConditionId,
    required this.currentSymptom,
    required this.currentIllness,
    required this.notes,
  });
}

class PhysicalConditionModel {
  final String physicalConditionId;
  late final String currentInjury;
  late final String details;

  PhysicalConditionModel({
    required this.physicalConditionId,
    required this.currentInjury,
    required this.details,
  });
}

class ChronicConditionModel {
  final String chronicConditionId;
  late final String childAllergies;
  late final String childChronic;

  ChronicConditionModel({
    required this.chronicConditionId,
    required this.childAllergies,
    required this.childChronic,
  });
}