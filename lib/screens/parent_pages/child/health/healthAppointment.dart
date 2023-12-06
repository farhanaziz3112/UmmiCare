import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:ummicare/models/healthmodel.dart';
import 'package:ummicare/services/healthDatabase.dart';

class healthAppointment extends StatefulWidget {
  const healthAppointment({super.key, required this.childId, required this.healthId, required this.vaccincationAppointmentId});
  final String childId;
  final String healthId;
  final String vaccincationAppointmentId;

  @override
  State<healthAppointment> createState() => _healthCalendarState();
}

class _healthCalendarState extends State<healthAppointment> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  Map<DateTime, List<String>> _events = {};

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
      body: Column(
        children: [
          TableCalendar(
            firstDay: DateTime(2000),
            lastDay: DateTime(2050),
            focusedDay: _focusedDay,
            calendarFormat: _calendarFormat,
            onFormatChanged: (format) {
              setState(() {
                _calendarFormat = format;
              });
            },
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
              });
            },
            eventLoader: (day) {
              return _events[day] ?? [];
            },
          ),
          SizedBox(height: 20),
          if (_selectedDay != null)
            StreamBuilder<VaccinationAppointmentModel>(
              stream: HealthDatabaseService(childId: widget.childId).vaccincationAppointmentData,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  final vaccinationAppointmentData = snapshot.data;
                  return Column(
                    children: [
                      Text(
                        'Health Appointments on ${_selectedDay!.toLocal()}',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      if (vaccinationAppointmentData != null)
                        Text(
                          'Appointments: $vaccinationAppointmentData',
                          style: TextStyle(fontSize: 16),
                        )
                      else
                        Text('No health appointments for this day.'),
                    ],
                  );
                }
              },
            ),
        ],
      ),
    );
  }
}