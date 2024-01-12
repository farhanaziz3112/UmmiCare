import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ummicare/models/schoolModel.dart';
import 'package:ummicare/models/studentModel.dart';
import 'package:ummicare/models/teacherModel.dart';
import 'package:ummicare/services/schoolDatabase.dart';
import 'package:ummicare/services/studentDatabase.dart';
import 'package:ummicare/services/teacherDatabase.dart';
import 'package:ummicare/shared/function.dart';

class educationRecord extends StatefulWidget {
  const educationRecord({super.key, required this.studentId});
  final String studentId;

  @override
  State<educationRecord> createState() => _educationRecordState();
}

class _educationRecordState extends State<educationRecord> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Education Records",
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        elevation: 3,
      ),
      body: SingleChildScrollView(
        child: StreamBuilder<studentModel>(
          stream: studentDatabase().studentData(widget.studentId),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              studentModel? student = snapshot.data;
              return StreamBuilder<List<studentAcademicCalendarModel>>(
                stream: studentDatabase()
                    .allStudentAcademicCalendar(student!.studentId),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<studentAcademicCalendarModel>? academicCalendarList =
                        snapshot.data;
                    return Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30.0, vertical: 30.0),
                      alignment: Alignment.center,
                      child: Column(
                        children: <Widget>[
                          ListView.builder(
                            shrinkWrap: true,
                            itemCount: academicCalendarList?.length,
                            itemBuilder: (context, index) {
                              studentAcademicCalendarModel currentData =
                                  academicCalendarList![index];
                              return Container(
                                padding: const EdgeInsets.fromLTRB(
                                    20.0, 10.0, 20.0, 10.0),
                                width: double.infinity,
                                alignment: Alignment.centerLeft,
                                decoration: const BoxDecoration(
                                    color: Color.fromARGB(255, 255, 255, 255),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey,
                                        spreadRadius: 0,
                                        blurRadius: 1,
                                      )
                                    ]),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    StreamBuilder<schoolModel>(
                                        stream: schoolDatabase()
                                            .schoolData(currentData.schoolId),
                                        builder: (context, snapshot) {
                                          if (snapshot.hasData) {
                                            return Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                const Text(
                                                  'School',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Text(snapshot.data!.schoolName)
                                              ],
                                            );
                                          } else {
                                            return Container();
                                          }
                                        }),
                                    const SizedBox(
                                      height: 5.0,
                                    ),
                                    StreamBuilder<classModel>(
                                        stream: schoolDatabase()
                                            .classData(currentData.classId),
                                        builder: (context, snapshot) {
                                          if (snapshot.hasData) {
                                            return Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                const Text(
                                                  'Class',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Text(
                                                    '${snapshot.data!.classYear} - ${snapshot.data!.className}')
                                              ],
                                            );
                                          } else {
                                            return Container();
                                          }
                                        }),
                                    const SizedBox(
                                      height: 5.0,
                                    ),
                                    StreamBuilder<teacherModel>(
                                        stream: teacherDatabase(
                                                teacherId:
                                                    currentData.teacherId)
                                            .teacherData,
                                        builder: (context, snapshot) {
                                          if (snapshot.hasData) {
                                            return Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                const Text(
                                                  'Teacher',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Text(snapshot
                                                    .data!.teacherFullName)
                                              ],
                                            );
                                          } else {
                                            return Container();
                                          }
                                        }),
                                    const SizedBox(
                                      height: 5.0,
                                    ),
                                    const Text(
                                      'Start Date',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(convertTimeToDateWithStringMonth(
                                        currentData.academicCalendarStartDate)),
                                    const SizedBox(
                                      height: 5.0,
                                    ),
                                    const Text(
                                      'End Date',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(convertTimeToDateWithStringMonth(
                                        currentData.academicCalendarEndDate))
                                  ],
                                ),
                              );
                            },
                          )
                        ],
                      ),
                    );
                  } else {
                    return Container();
                  }
                },
              );
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}
