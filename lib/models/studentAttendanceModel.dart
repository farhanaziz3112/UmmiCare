


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

class studentLeaveModel {
  final String studentLeaveId;
  final String studentId;
  final String reason;
  final String leaveDate;
  final String leaveProofImg;
  final String status;

  studentLeaveModel({
    required this.studentLeaveId,
    required this.studentId,
    required this.reason,
    required this.leaveDate,
    required this.leaveProofImg,
    required this.status
  });
}