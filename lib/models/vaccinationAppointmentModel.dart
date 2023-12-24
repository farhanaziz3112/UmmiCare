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