


class studentAttendanceModel {
  final String studentAttendanceId;
  final String studentId;
  final String academicCalendarId;
  final String attendanceDateDay;
  final String attendanceDateMonth;
  final String attendanceDateYear;
  final String recordedTime;
  final String attendanceStatus;
  final String description;

  studentAttendanceModel({
    required this.studentAttendanceId,
    required this.studentId,
    required this.academicCalendarId,
    required this.attendanceDateDay,
    required this.attendanceDateMonth,
    required this.attendanceDateYear,
    required this.recordedTime,
    required this.attendanceStatus,
    required this.description
  });
}