class childModel {
  final String childId;
  late final String parentId;
  late final String childCreatedDate;
  late final String childName;
  late final String childFirstname;
  late final String childLastname;
  late final String childBirthday;
  late final int childCurrentAge;
  late final String childAgeCategory;
  late final String childProfileImg;
  late final String educationId;
  late final String healthId;

  childModel(
      {required this.childId,
      required this.parentId,
      required this.childCreatedDate,
      required this.childName,
      required this.childFirstname,
      required this.childLastname,
      required this.childBirthday,
      required this.childCurrentAge,
      required this.childAgeCategory,
      required this.childProfileImg,
      required this.educationId,
      required this.healthId});
}