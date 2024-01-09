class patientModel{ 
  final String patientId;
  late final String healthId;
  late final String childId;
  late final String clinicId;
  late final String healthStatusId;
  late final String vaccinationAppointmentId;
  late final String patientProfileImage;
  late final String patientName;
  late final int patientCurrentAge;
  
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
  late final String medicalStaffId;

  VaccinationAppointmentModel({
    required this.vaccinationAppointmentId,
    required this.vaccineType,
    required this.vaccineDate,
    required this.vaccineTime,
    required this.healthId,
    required this.clinicId,
    required this.medicalStaffId,
  });
}