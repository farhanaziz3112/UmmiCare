

import 'dart:ui';

class academicCalendarScheduleModel {

  final String academicCalendarScheduleId;
  final String title;
  final String date;
  final String from;
  final String to;
  final String academicCalendarId;
  final String eventId;
  final String type;

  academicCalendarScheduleModel({
    required this.academicCalendarScheduleId,
    required this.title,
    required this.date,
    required this.from,
    required this.to,
    required this.academicCalendarId,
    required this.eventId,
    required this.type
  });

}

class Meeting {
  Meeting(this.eventName, this.from, this.to, this.background, this.isAllDay);

  String eventName;
  DateTime from;
  DateTime to;
  Color background;
  bool isAllDay;
}