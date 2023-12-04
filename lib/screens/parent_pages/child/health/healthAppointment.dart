import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class healthAppointment extends StatefulWidget {
  const healthAppointment({super.key, required this.childId});
  final String childId;

  @override
  State<healthAppointment> createState() => _healthCalendarState();
}

class _healthCalendarState extends State<healthAppointment> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  Map<DateTime, List<String>> _events = {
    DateTime.now(): ['Meeting at 10 AM', 'Lunch with Client'],
    DateTime.now().add(Duration(days: 2)): ['Team Huddle'],
    DateTime.now().add(Duration(days: 5)): ['Conference Call'],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: const Text(
          "Health Appointment",
          style: TextStyle(
            color: Colors.black,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xffe1eef5),
      ),
      body: const Center(
        child: Text(
          'Health Appointment',
          style: TextStyle(
          color: Colors.black,
          fontSize: 40,
          fontWeight: FontWeight.bold,
        ),
        ),
      ),
    );
  }
}