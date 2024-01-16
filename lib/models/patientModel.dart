class patientModel{ 
  final String patientId;
  final String healthId;
  final String childId;
  final String clinicId;
  final String healthStatusId;
  final String vaccinationAppointmentId;
  final String patientProfileImage;
  final String patientName;
  final int patientCurrentAge;
  
  patientModel({
    required this.patientId,
    required this.healthId,
    required this.childId,
    required this.clinicId,
    required this.healthStatusId,
    required this.vaccinationAppointmentId,
    required this.patientProfileImage,
    required this.patientName,
    required this.patientCurrentAge,
  });

  get childProfileImage => null;
}

class VaccinationAppointmentModel {
  final String vaccinationAppointmentId;
  late final String vaccineType;
  late final String vaccineDate;
  late final String vaccineTime;
  late final String healthId;
  late final String clinicId;

  VaccinationAppointmentModel({
    required this.vaccinationAppointmentId,
    required this.vaccineType,
    required this.vaccineDate,
    required this.vaccineTime,
    required this.healthId,
    required this.clinicId,
  });
}