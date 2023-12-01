
class teacherModel {
  final String teacherId;
  late final String teacherCreatedDate;
  late final String teacherFullName;
  late final String teacherFirstName;
  late final String teacherLastName;
  late final String teacherEmail;
  late final String teacherPhoneNumber;
  late final String teacherProfileImg;
  late final String schoolId;

  teacherModel({
    required this.teacherId,
    required this.teacherCreatedDate,
    required this.teacherFullName,
    required this.teacherFirstName,
    required this.teacherLastName,
    required this.teacherEmail,
    required this.teacherPhoneNumber,
    required this.teacherProfileImg,
    required this.schoolId,
  });

}

class teacherClassModel {
  final String classId;
  final String teacherId;

  teacherClassModel({
    required this.classId,
    required this.teacherId
  });
}
