class parentModel {
  final String parentId;
  late final String parentCreatedDate;
  late final String parentFullName;
  late final String parentFirstName;
  late final String parentLastName;
  late final String parentEmail;
  late final String parentPhoneNumber;
  late final String parentProfileImg;
  late final String advisorId;
  late final String noOfChild;

  parentModel(
      {required this.parentId,
      required this.parentCreatedDate,
      required this.parentFullName,
      required this.parentFirstName,
      required this.parentLastName,
      required this.parentEmail,
      required this.parentPhoneNumber,
      required this.parentProfileImg,
      required this.advisorId,
      required this.noOfChild});
}

class parentAdvisorModel {
  final String parentId;
  late final String assignedDate;

  parentAdvisorModel({
    required this.parentId,
    required this.assignedDate
  });
}

