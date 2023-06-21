class HealthModel {
  final String healthId;
  late final String childId;
  late final String healthStatusId;
  late final List<String> physicalList;

  HealthModel({
    required this.healthId,
    required this.childId,
    required this.healthStatusId,
    required this.physicalList,
  });
}

class PhysicalModel{
  final String physicalId;
  late final String currentHeight;
  late final String currentWeight;

  PhysicalModel({
    required this.physicalId,
    required this.currentHeight,
    required this.currentWeight,
  });
}

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

  HealthConditionModel({
    required this.healthConditionId,
    required this.currentSymptom,
    required this.currentIllness,
  });
}

class PhysicalConditionModel {
  final String physicalConditionModel;
  late final String currentInjury;
  late final String other;

  PhysicalConditionModel({
    required this.physicalConditionModel,
    required this.currentInjury,
    required this.other,
  });
}

class ChronicConditionModel {
  final String chronicConditionModel;
  late final String childAllergies;
  late final String childChronic;

  ChronicConditionModel({
    required this.chronicConditionModel,
    required this.childAllergies,
    required this.childChronic,
  });
}

class VaccincationAppointmentModel {
  final String vaccincationAppointmentModel;
  late final String vaccineType;
  late final String vaccineTime;
  late final String clinicId;
  late final String doctorId;
  late final String healthId;

  VaccincationAppointmentModel({
    required this.vaccincationAppointmentModel,
    required this.vaccineType,
    required this.vaccineTime,
    required this.clinicId,
    required this.doctorId,
    required this.healthId,
  });
}

class ClinicModel {
  final String clinicId;
  late final String clinicName;
  late final String clinicAddress;
  late final String clinicPhoneNumber;

  ClinicModel({
    required this.clinicId,
    required this.clinicName,
    required this.clinicAddress,
    required this.clinicPhoneNumber,
  });
}

class DoctorModel {
  final String doctorId;
  late final String doctorFullName;
  late final String doctorPhoneNumber;

  DoctorModel({
    required this.doctorId,
    required this.doctorFullName,
    required this.doctorPhoneNumber,
  });
}