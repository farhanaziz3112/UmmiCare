class medicalStaffModel {
  final String medicalStaffId;
  late final String medicalStaffCreatedDate;
  late final String medicalStaffFullName;
  late final String medicalStaffFirstName;
  late final String medicalStaffLastName;
  late final String medicalStaffEmail;
  late final String medicalStaffPhoneNumber;
  late final String medicalStaffProfileImg;
  late final String clinicId;

  medicalStaffModel({
    required this.medicalStaffId,
    required this.medicalStaffCreatedDate,
    required this.medicalStaffFullName,
    required this.medicalStaffFirstName,
    required this.medicalStaffLastName,
    required this.medicalStaffEmail,
    required this.medicalStaffPhoneNumber,
    required this.medicalStaffProfileImg,
    required this.clinicId,
  });

}

class ClinicModel {
  final String clinicId;
  late final String clinicName;
  late final String clinicAddress;
  late final String clinicEmail;
  late final String clinicPhoneNumber;

  ClinicModel({
    required this.clinicId,
    required this.clinicName,
    required this.clinicAddress,
    required this.clinicEmail,
    required this.clinicPhoneNumber,
  });
}