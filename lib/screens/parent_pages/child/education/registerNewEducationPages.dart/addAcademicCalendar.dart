import 'package:flutter/material.dart';
import 'package:ummicare/models/academicCalendarModel.dart';
import 'package:ummicare/screens/parent_pages/child/education/registerNewEducationPages.dart/academicCalendarList.dart';
import 'package:ummicare/services/academicCalendarDatabase.dart';

class addAcademicCalendar extends StatefulWidget {
  const addAcademicCalendar({super.key, required this.studentId, required this.schoolId});
  final String studentId;
  final String schoolId;

  @override
  State<addAcademicCalendar> createState() => _addAcademicCalendarState();
}

class _addAcademicCalendarState extends State<addAcademicCalendar> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<academicCalendarModel>>(
      stream: academicCalendarDatabase().allOpenAcademicCalendarDataWithSchoolId(widget.schoolId),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<academicCalendarModel>? list = snapshot.data;
          return Scaffold(
            appBar: AppBar(
                title: const Text(
                  'Add New Academic Calendar',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                elevation: 3,
                iconTheme: const IconThemeData(color: Colors.black),
                centerTitle: true,
                backgroundColor: const Color.fromARGB(255, 255, 255, 255),
              ),
            body: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.symmetric(
                      horizontal: 30.0, vertical: 30.0),
                  alignment: Alignment.center,
                child: Column(
                  children: <Widget>[
                    const Text(
                        'Choose your academic calendar:',
                        style: TextStyle(fontSize: 17),
                      ),
                    const SizedBox(height: 30),
                    academicCalendarList(list: list!, studentId: widget.studentId)
                  ],
                ),
              ),
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }
}