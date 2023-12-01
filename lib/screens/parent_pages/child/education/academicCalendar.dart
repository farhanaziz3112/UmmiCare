import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';

class academicCalendar extends StatefulWidget {
  const academicCalendar({super.key});

  @override
  State<academicCalendar> createState() => _academicCalendarState();
}

class _academicCalendarState extends State<academicCalendar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: const Text(
          "Academic calendar",
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
          'Academic calendar',
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