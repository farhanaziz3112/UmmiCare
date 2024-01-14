import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ummicare/models/academicCalendarModel.dart';
import 'package:ummicare/models/childModel.dart';
import 'package:ummicare/models/examinationModel.dart';
import 'package:ummicare/models/studentAttendanceModel.dart';
import 'package:ummicare/models/studentModel.dart';

String convertTimeToDateString(String timeInMilliseconds) {
  int temp = int.parse(timeInMilliseconds);
  DateTime date = DateTime.fromMillisecondsSinceEpoch(temp);
  return date.day.toString() +
      " / " +
      date.month.toString() +
      " / " +
      date.year.toString();
}

String convertTimeToDateWithStringMonth(String timeInMilliseconds) {
  int temp = int.parse(timeInMilliseconds);
  DateTime date = DateTime.fromMillisecondsSinceEpoch(temp);
  return date.day.toString() +
      " " +
      monthToString(date.month) +
      " " +
      date.year.toString();
}

String convertTimeToHoursMinute(String timeInMilliseconds) {
  int temp = int.parse(timeInMilliseconds);
  DateTime date = DateTime.fromMillisecondsSinceEpoch(temp);
  return date.hour.toString() + " : " + date.minute.toString();
}

String getTimeFormat(String timeInMilliseconds) {
  DateTime temp =
      DateTime.fromMillisecondsSinceEpoch(int.parse(timeInMilliseconds));
  return DateFormat.jm().format(temp);
}

String getTimeFormatWithDateTime(String timeInMilliseconds) {
  DateTime temp =
      DateTime.fromMillisecondsSinceEpoch(int.parse(timeInMilliseconds));
  return DateFormat.jm().format(temp);
}

TimeOfDay convertDateTimeToTimeofDay(String timeInMilliseconds) {
  DateTime temp =
      DateTime.fromMillisecondsSinceEpoch(int.parse(timeInMilliseconds));
  return TimeOfDay(hour: temp.hour, minute: temp.minute);
}

DateTime convertTimeToDate(String timeInMilliseconds) {
  int temp = int.parse(timeInMilliseconds);
  DateTime date = DateTime.fromMillisecondsSinceEpoch(temp);
  return date;
}

DateTime convertTimeOfDayToDateTime(TimeOfDay timeOfDay, DateTime dateTime) {
  return DateTime(dateTime.year, dateTime.month, dateTime.day, timeOfDay.hour,
      timeOfDay.minute);
}

String monthToString(int month) {
  List<String> months = [
    'Jan',
    'Feb',
    'Mac',
    'Apr',
    'May',
    'June',
    'July',
    'Aug',
    'Sept',
    'Oct',
    'Nov',
    'Dec'
  ];
  return months.elementAt(month - 1);
}

int getAge(String timeInMilliseconds) {
  int temp = int.parse(timeInMilliseconds);
  DateTime birthDate = DateTime.fromMillisecondsSinceEpoch(temp);
  DateTime currentDate = DateTime.now();
  DateTime from = DateTime(birthDate.year, birthDate.month, birthDate.day);
  DateTime to = DateTime(currentDate.year, currentDate.month, currentDate.day);
  return (to.difference(from).inDays / 365).round();
}

String getAgeCategory(int age) {
  if (age <= 3) {
    return 'Newborn to 3 years old';
  } else if (3 < age && age <= 6) {
    return '3 to 6 years old';
  } else if (6 < age && age <= 12) {
    return '7 to 12 years old';
  } else {
    return '13 years old and above';
  }
}

String getLastSignedInFormat(String timeInMilliSeconds) {
  int temp = int.parse(timeInMilliSeconds);
  DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(temp);
  String minute = '';
  if (dateTime.minute < 10) {
    minute = '0${dateTime.minute.toString()}';
  } else {
    minute = dateTime.minute.toString();
  }
  return dateTime.hour.toString() +
      ":" +
      minute +
      " " +
      dateTime.day.toString() +
      "/" +
      dateTime.month.toString() +
      "/" +
      dateTime.year.toString();
}

int getNoOfChildCategory(List<childModel> childList, String category) {
  int total = 0;
  for (int i = 0; i < childList.length; i++) {
    if (childList.elementAt(i).childAgeCategory == category) {
      total++;
    }
  }
  return total;
}

int getNoOfAttendanceStatus(List<studentAttendanceModel> list, String status) {
  int total = 0;
  if (status == 'present') {
    for (int i = 0; i < list.length; i++) {
      if (list.elementAt(i).attendanceStatus == "present") {
        total++;
      }
    }
  } else {
    for (int i = 0; i < list.length; i++) {
      if (list.elementAt(i).attendanceStatus == "absent") {
        total++;
      }
    }
  }
  return total;
}

int getNoOfChildEducationStatus(List<childModel> childList, bool status) {
  int total = 0;
  if (status == true) {
    for (int i = 0; i < childList.length; i++) {
      if (childList.elementAt(i).educationId != "") {
        total++;
      }
    }
  } else {
    for (int i = 0; i < childList.length; i++) {
      if (childList.elementAt(i).educationId == "") {
        total++;
      }
    }
  }
  return total;
}

int getNoOfChildHealthStatus(List<childModel> childList, bool status) {
  int total = 0;
  if (status == true) {
    for (int i = 0; i < childList.length; i++) {
      if (childList.elementAt(i).healthId != "") {
        total++;
      }
    }
  } else {
    for (int i = 0; i < childList.length; i++) {
      if (childList.elementAt(i).healthId == "") {
        total++;
      }
    }
  }
  return total;
}

int getNoOfChildStatus(List<childModel> childList, String status) {
  int total = 0;
  for (int i = 0; i < childList.length; i++) {
    if (childList.elementAt(i).overallStatus == status) {
      total++;
    }
  }
  return total;
}

double getPercentage(int subject, int total) {
  return double.parse(((subject / total) * 100).toStringAsFixed(2));
}

int getResultPassFailRate(List<subjectResultModel> results, String status) {
  int total = 0;
  for (int i = 0; i < results.length; i++) {
    if (results.elementAt(i).subjectGradeStatus != "" && results.elementAt(i).subjectGradeStatus == status) {
      total++;
    }
  }
  return total;
}

int getResultGradeTotal(List<subjectResultModel> results, String grade) {
  int total = 0;
  for (int i = 0; i < results.length; i++) {
    if (results.elementAt(i).subjectGrade != "" && results.elementAt(i).subjectGrade == grade) {
      total++;
    }
  }
  return total;
}

int getNoOfStudentStatus(List<studentModel>? studentList, String status) {
  int total = 0;
  for (int i = 0; i < studentList!.length; i++) {
    if (studentList.elementAt(i).activationStatus == status) {
      total++;
    }
  }
  return total;
}

int getNoOfStudentStatusBasedOnAcademicCalendar(List<studentModel> studentList,
    List<academicCalendarModel> academicCalendar, String status) {
  int total = 0;
  for (int i = 0; i < academicCalendar.length; i++) {
    for (int j = 0; j < studentList.length; j++) {
      if (studentList[j].academicCalendarId ==
          academicCalendar[i].academicCalendarId) {
        if (studentList[j].activationStatus == status) {
          total = total + 1;
        }
      }
    }
  }
  return total;
}

int getNoOfStudentAttendanceBasedOnAcademicCalendar(List<studentAttendanceModel> attendanceList,
    List<academicCalendarModel> academicCalendar, String status) {
  int total = 0;
  for (int i = 0; i < academicCalendar.length; i++) {
    for (int j = 0; j < attendanceList.length; j++) {
      if (attendanceList[j].academicCalendarId ==
          academicCalendar[i].academicCalendarId) {
        if (attendanceList[j].attendanceStatus == status) {
          total = total + 1;
        }
      }
    }
  }
  return total;
}

double getPercentageFromInt(int subject, int total) {
  return double.parse(((subject / total) * 100).toStringAsFixed(2));
}

String getGrade(String markInString) {
  int mark = int.parse(markInString);
  if (mark <= 100 && mark >= 80) {
    return 'A';
  } else if (mark >= 60 && mark < 80) {
    return 'B';
  } else if (mark >= 40 && mark < 60) {
    return 'C';
  } else if (mark >= 20 && mark < 40) {
    return 'D';
  } else {
    return 'E';
  }
}

String getGradeStatus(String grade) {
  if (grade == 'A' || grade == 'B' || grade == 'C') {
    return 'pass';
  } else {
    return 'fail';
  }
}
