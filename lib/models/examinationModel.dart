
class examModel {

  final String examId;
  final String academicCalendarId;
  final String examTitle;
  final String examStartDate;
  final String examEndDate;
  final String examStatus;

  examModel({
    required this.examId,
    required this.academicCalendarId,
    required this.examTitle,
    required this.examStartDate,
    required this.examEndDate,
    required this.examStatus
  });

}

class examResultModel {

  final String examResultId;
  final String examId;
  final String academicCalendarId;
  final String studentId;
  final String examOverallResult;
  
  examResultModel({
    required this.examResultId,
    required this.examId,
    required this.academicCalendarId,
    required this.studentId,
    required this.examOverallResult
  });

}

class subjectResultModel {

  final String subjectResultId;
  final String subjectId;
  final String examId;
  final String examResultId;
  final String studentId;
  final String academicCalendarId;
  final String subjectMark;
  final String subjectGrade;
  final String subjectGradeStatus;

  subjectResultModel({
    required this.subjectResultId,
    required this.subjectId,
    required this.examId,
    required this.examResultId,
    required this.studentId,
    required this.academicCalendarId,
    required this.subjectMark,
    required this.subjectGrade,
    required this.subjectGradeStatus
  });

}