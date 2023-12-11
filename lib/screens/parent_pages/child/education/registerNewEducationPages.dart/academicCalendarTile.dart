import 'package:flutter/material.dart';
import 'package:ummicare/models/academicCalendarModel.dart';
import 'package:ummicare/models/schoolModel.dart';
import 'package:ummicare/models/studentModel.dart';
import 'package:ummicare/models/teacherModel.dart';
import 'package:ummicare/screens/parent_pages/child/education/educationMain.dart';
import 'package:ummicare/services/academicCalendarDatabase.dart';
import 'package:ummicare/services/schoolDatabase.dart';
import 'package:ummicare/services/studentDatabase.dart';
import 'package:ummicare/services/teacherDatabase.dart';
import 'package:ummicare/shared/function.dart';

class academicCalendarTile extends StatefulWidget {
  const academicCalendarTile(
      {super.key, required this.academicCalendar, required this.studentId});
  final academicCalendarModel academicCalendar;
  final String studentId;

  @override
  State<academicCalendarTile> createState() => _academicCalendarTileState();
}

class _academicCalendarTileState extends State<academicCalendarTile> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<academicCalendarModel>(
        stream: academicCalendarDatabase()
            .academicCalendarData(widget.academicCalendar.academicCalendarId),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            academicCalendarModel? academicCalendar = snapshot.data;
            return Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: InkWell(
                onTap: (() {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        scrollable: true,
                        title: const Padding(
                          padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
                          child: Row(
                            children: [
                              Icon(Icons.school),
                              SizedBox(width: 10),
                              Text(
                                "Academic Calendar Registration",
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                                softWrap: true,
                              ),
                            ],
                          ),
                        ),
                        content: Padding(
                          padding: const EdgeInsets.fromLTRB(10, 10, 10, 20),
                          child: Column(
                            children: <Widget>[
                              Container(
                                alignment: Alignment.centerLeft,
                                child: const Text(
                                  'Class Name',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 5.0,
                              ),
                              StreamBuilder<classModel>(
                                  stream: schoolDatabase()
                                      .classData(academicCalendar.classId),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      return Container(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          '${snapshot.data!.classYear} - ${snapshot.data!.className}',
                                          textAlign: TextAlign.left,
                                          style: const TextStyle(
                                            fontSize: 15.0,
                                            color: Colors.black,
                                          ),
                                        ),
                                      );
                                    } else {
                                      return Container();
                                    }
                                  }),
                              const SizedBox(height: 20.0),
                              Container(
                                alignment: Alignment.centerLeft,
                                child: const Text(
                                  'Teacher',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 5.0,
                              ),
                              StreamBuilder<teacherModel>(
                                  stream: teacherDatabase(
                                          teacherId: academicCalendar.teacherId)
                                      .teacherData,
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      return Container(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          snapshot.data!.teacherFullName,
                                          textAlign: TextAlign.left,
                                          style: const TextStyle(
                                            fontSize: 15.0,
                                            color: Colors.black,
                                          ),
                                        ),
                                      );
                                    } else {
                                      return Container();
                                    }
                                  }),
                              const SizedBox(height: 20.0),
                              Container(
                                alignment: Alignment.centerLeft,
                                child: const Text(
                                  'REMINDER: Make user you choose the right class before proceed to register!',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontSize: 15.0,
                                    color: Colors.red,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        actions: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xffF29180),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5)),
                            ),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text("Cancel",
                                style: TextStyle(color: Colors.white)),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xff8290F0),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5)),
                            ),
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      scrollable: true,
                                      title: const Padding(
                                        padding: EdgeInsets.all(5.0),
                                        child: Text(
                                          'Registration Confirmation',
                                          style: TextStyle(fontSize: 20),
                                        ),
                                      ),
                                      content: const Padding(
                                        padding: EdgeInsets.all(5),
                                        child: Text(
                                          'Are you sure you want to register with this class?',
                                          style: TextStyle(fontSize: 13),
                                        ),
                                      ),
                                      actions: [
                                        ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                const Color(0xffF29180),
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5)),
                                          ),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: const Text("Cancel",
                                              style: TextStyle(
                                                  color: Colors.white)),
                                        ),
                                        StreamBuilder<studentModel>(
                                            stream: studentDatabase()
                                                .studentData(widget.studentId),
                                            builder: (context, snapshot) {
                                              if (snapshot.hasData) {
                                                studentModel? student =
                                                    snapshot.data;
                                                return ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        const Color(0xff8290F0),
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5)),
                                                  ),
                                                  onPressed: () {
                                                    studentDatabase()
                                                        .updateStudentData(
                                                            student!.studentId,
                                                            student.childId,
                                                            student.schoolId,
                                                            academicCalendar
                                                                .academicCalendarId,
                                                            academicCalendar
                                                                .classId,
                                                            student.feeId,
                                                            student
                                                                .activationStatus);

                                                    studentDatabase()
                                                        .updateStudentAcademicCalendarData(
                                                            student.studentId,
                                                            academicCalendar
                                                                .academicCalendarId,
                                                            academicCalendar
                                                                .schoolId,
                                                            academicCalendar
                                                                .classId,
                                                            academicCalendar
                                                                .teacherId,
                                                            academicCalendar
                                                                .academicCalendarStartDate,
                                                            academicCalendar
                                                                .academicCalendarEndDate,
                                                            'active');

                                                    academicCalendarDatabase().updateAcademicCalendarData(
                                                        academicCalendar
                                                            .academicCalendarId,
                                                        academicCalendar
                                                            .schoolId,
                                                        academicCalendar
                                                            .classId,
                                                        academicCalendar
                                                            .teacherId,
                                                        academicCalendar
                                                            .academicCalendarStartDate,
                                                        academicCalendar
                                                            .academicCalendarEndDate,
                                                        (int.parse(academicCalendar
                                                                    .noOfStudent) +
                                                                1)
                                                            .toString(),
                                                        academicCalendar
                                                            .registrationStatus);

                                                    Navigator.of(context)
                                                      ..pop()
                                                      ..pop()
                                                      ..pop()
                                                      ..pop()
                                                      ..pop()
                                                      ..pop();

                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                educationMain(
                                                                  studentId: student
                                                                      .studentId,
                                                                  childId: student
                                                                      .childId,
                                                                )));
                                                  },
                                                  child: const Text("Confirm",
                                                      style: TextStyle(
                                                          color: Colors.white)),
                                                );
                                              } else {
                                                return Container();
                                              }
                                            }),
                                      ],
                                    );
                                  });
                            },
                            child: const Text("Register",
                                style: TextStyle(color: Colors.white)),
                          )
                        ],
                      );
                    },
                  );
                }),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
                  decoration: BoxDecoration(
                    color: const Color(0xff8290F0),
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 5,
                        offset:
                            const Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Column(
                    children: <Widget>[
                      StreamBuilder<classModel>(
                          stream: schoolDatabase()
                              .classData(academicCalendar!.classId),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return Column(
                                children: [
                                  Row(
                                    children: <Widget>[
                                      const Expanded(
                                        flex: 1,
                                        child: Text(
                                          'Class Year: ',
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 15),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: Text(
                                          snapshot.data!.classYear,
                                          textAlign: TextAlign.start,
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 15),
                                        ),
                                      )
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  Row(
                                    children: <Widget>[
                                      const Expanded(
                                        flex: 1,
                                        child: Text(
                                          'Class Name: ',
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 15),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: Text(
                                          snapshot.data!.className,
                                          textAlign: TextAlign.start,
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 15),
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              );
                            } else {
                              return Container();
                            }
                          }),
                      const SizedBox(height: 10),
                      StreamBuilder<teacherModel>(
                          stream: teacherDatabase(
                                  teacherId: academicCalendar.teacherId)
                              .teacherData,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return Row(
                                children: <Widget>[
                                  const Expanded(
                                    flex: 1,
                                    child: Text(
                                      'Teacher: ',
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 15),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Text(
                                      snapshot.data!.teacherFullName,
                                      textAlign: TextAlign.start,
                                      style: const TextStyle(
                                          color: Colors.white, fontSize: 15),
                                    ),
                                  )
                                ],
                              );
                            } else {
                              return Container();
                            }
                          }),
                      const SizedBox(height: 10),
                      Row(
                        children: <Widget>[
                          const Expanded(
                            flex: 1,
                            child: Text(
                              'Start Date: ',
                              textAlign: TextAlign.start,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 15),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Text(
                              convertTimeToDateString(
                                  academicCalendar.academicCalendarStartDate),
                              textAlign: TextAlign.start,
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 15),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: <Widget>[
                          const Expanded(
                            flex: 1,
                            child: Text(
                              'End Date: ',
                              textAlign: TextAlign.start,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 15),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Text(
                              convertTimeToDateString(
                                  academicCalendar.academicCalendarEndDate),
                              textAlign: TextAlign.start,
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 15),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          } else {
            return Container();
          }
        });
  }
}
