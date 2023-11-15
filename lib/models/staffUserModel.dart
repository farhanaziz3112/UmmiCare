class staffUserModel {
  final String staffId;
  late final String staffCreatedDate;
  late final String staffUserType;
  late final String staffFullName;
  late final String staffFirstName;
  late final String staffLastName;
  late final String staffEmail;
  late final String staffPhoneNumber;
  late final String staffSupportingDocumentLink;
  late final String staffProfileImg;
  late final String isVerified;

  staffUserModel({
    required this.staffId,
    required this.staffCreatedDate,
    required this.staffUserType,
    required this.staffFullName,
    required this.staffFirstName,
    required this.staffLastName,
    required this.staffEmail,
    required this.staffPhoneNumber,
    required this.staffSupportingDocumentLink,
    required this.staffProfileImg,
    required this.isVerified
  });

}
