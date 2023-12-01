class studentModel {
  final String studentId;
  final String childId;
  final String schoolId;
  final String academicCalendarId;
  final String classId;
  final String feeId;
  final String activationStatus;

  studentModel(
      {required this.studentId,
      required this.childId,
      required this.schoolId,
      required this.academicCalendarId,
      required this.classId,
      required this.feeId,
      required this.activationStatus});
}

class studentAcademicCalendarModel {
  final String studentAcademicCalendarId;
  final String academicCalendarId;
  final String schoolId;
  final String classId;
  final String teacherId;
  final String academicCalendarStartDate;
  final String academicCalendarEndDate;
  final String currentStatus;

  studentAcademicCalendarModel({
    required this.studentAcademicCalendarId,
    required this.academicCalendarId,
    required this.schoolId,
    required this.classId,
    required this.teacherId,
    required this.academicCalendarStartDate,
    required this.academicCalendarEndDate,
    required this.currentStatus
  });
}


