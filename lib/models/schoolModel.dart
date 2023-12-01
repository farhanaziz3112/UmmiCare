class schoolModel {
  final String schoolId;
  late final String schoolName;
  late final String schoolAddress;
  late final String schoolEmail;
  late final String schoolPhoneNumber;

  schoolModel({
    required this.schoolId,
    required this.schoolName,
    required this.schoolAddress,
    required this.schoolEmail,
    required this.schoolPhoneNumber,
  });
}

class classModel {
  late final String classId;
  late final String schoolId;
  late final String className;
  late final String classYear;
  late final String classStatus;

  classModel({
    required this.classId,
    required this.schoolId,
    required this.className,
    required this.classYear,
    required this.classStatus
  });
}

