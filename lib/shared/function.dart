import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ummicare/models/childModel.dart';
import 'package:ummicare/models/studentModel.dart';


final String timeZone = "UTC";

String convertTimeToDateString(String timeInMilliseconds) {
  int temp = int.parse(timeInMilliseconds);
  DateTime date = DateTime.fromMillisecondsSinceEpoch(temp);
  return "${date.day} / ${date.month} / ${date.year}";
}

String convertTimeToDateWithStringMonth(String timeInMilliseconds) {
  int temp = int.parse(timeInMilliseconds);
  DateTime date = DateTime.fromMillisecondsSinceEpoch(temp);
  return "${date.day} ${monthToString(date.month)} ${date.year}";
}

String convertTimeToHoursMinute(String timeInMilliseconds) {
  int temp = int.parse(timeInMilliseconds);
  DateTime date = DateTime.fromMillisecondsSinceEpoch(temp);
  return "${date.hour} : ${date.minute}";
}

String getTimeFormat(String timeInMilliseconds) {
  DateTime temp = DateTime.fromMillisecondsSinceEpoch(int.parse(timeInMilliseconds));
  return DateFormat.jm().format(temp);
}

String getTimeFormatWithDateTime(String timeInMilliseconds) {
  DateTime temp = DateTime.fromMillisecondsSinceEpoch(int.parse(timeInMilliseconds));
  return DateFormat.jm().format(temp);
}

TimeOfDay convertDateTimeToTimeofDay(String timeInMilliseconds) {
  DateTime temp = DateTime.fromMillisecondsSinceEpoch(int.parse(timeInMilliseconds));
  return TimeOfDay(hour: temp.hour, minute: temp.minute);
}

DateTime convertTimeToDate(String timeInMilliseconds) {
  int temp = int.parse(timeInMilliseconds);
  DateTime date = DateTime.fromMillisecondsSinceEpoch(temp);
  return date;
}

DateTime convertTimeOfDayToDateTime(TimeOfDay timeOfDay, DateTime dateTime) {
  return DateTime(dateTime.year, dateTime.month, dateTime.day, timeOfDay.hour, timeOfDay.minute);
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
  return months.elementAt(month-1);
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
  return "${dateTime.hour}:${dateTime.minute} ${dateTime.day}/${dateTime.month}/${dateTime.year}";
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

int getNoOfStudentStatus(List<studentModel>? studentList, String status) {
  int total = 0;
  for (int i = 0; i < studentList!.length; i++) {
    if (studentList.elementAt(i).activationStatus == status) {
      total++;
    }
  }
  return total;
}


String getGrade(String markInString) {
    int mark = int.parse(markInString);
    if (mark <= 100 && mark >= 80) {
      return 'A';
    }  else if (mark >= 60 && mark < 80) {
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
