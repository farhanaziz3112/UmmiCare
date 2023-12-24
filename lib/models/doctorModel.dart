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