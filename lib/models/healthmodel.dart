class HealthModel {
  final String healthId;
  late final String childId;
  late final String healthStatusId;
  late final double currentHeight;
  late final double currentWeight;
  late final double bmi;
  late final DateTime createdAt;

  HealthModel({
    required this.healthId,
    required this.childId,
    required this.healthStatusId,
    required this.currentHeight,
    required this.currentWeight,
    required this.bmi,
    required this.createdAt
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

class VaccinationAppointmentModel {
  final String vaccinationAppointmentId;
  late final String vaccineType;
  late final String vaccineDate;
  late final String vaccineTime;
  late final String healthId;
  late final String clinicId;
  late final String doctorId;

  VaccinationAppointmentModel({
    required this.vaccinationAppointmentId,
    required this.vaccineType,
    required this.vaccineDate,
    required this.vaccineTime,
    required this.healthId,
    required this.clinicId,
    required this.doctorId,
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