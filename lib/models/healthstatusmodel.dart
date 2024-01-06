class HealthStatusModel {
  final String healthStatusId;
  late final String healthConditionId;
  late final String physicalConditionId;
  late final String chronicConditionId;
  late final String patientId;

  HealthStatusModel({
    required this.healthStatusId,
    required this.healthConditionId,
    required this.physicalConditionId,
    required this.chronicConditionId,
    required this.patientId,
  });
}

class HealthConditionModel {
  final String healthConditionId;
  late final String currentTemperature;
  late final String currentHeartRate;
  late final String currentSymptom;
  late final String currentIllness;
  late final String notes;
  late final String patientId;

  HealthConditionModel({
    required this.healthConditionId,
    required this.currentTemperature,
    required this.currentHeartRate,
    required this.currentSymptom,
    required this.currentIllness,
    required this.notes,
    required this.patientId,
  });
}

class PhysicalConditionModel {
  final String physicalConditionId;
  late final String currentInjury;
  late final String details;
  late final String patientId;

  PhysicalConditionModel({
    required this.physicalConditionId,
    required this.currentInjury,
    required this.details,
    required this.patientId,
  });
}

class ChronicConditionModel {
  final String chronicConditionId;
  late final String childAllergies;
  late final String childChronic;
  late final String patientId;

  ChronicConditionModel({
    required this.chronicConditionId,
    required this.childAllergies,
    required this.childChronic,
    required this.patientId,
  });
}