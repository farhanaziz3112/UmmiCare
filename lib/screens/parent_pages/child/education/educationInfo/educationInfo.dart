import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ummicare/models/academicCalendarModel.dart';
import 'package:ummicare/models/schoolModel.dart';
import 'package:ummicare/models/subjectModel.dart';
import 'package:ummicare/models/teacherModel.dart';
import 'package:ummicare/services/academicCalendarDatabase.dart';
import 'package:ummicare/services/schoolDatabase.dart';
import 'package:ummicare/services/teacherDatabase.dart';

class educationInfo extends StatefulWidget {
  const educationInfo(
      {super.key, required this.academicCalendarId, required this.studentId});
  final String studentId;
  final String academicCalendarId;

  @override
  State<educationInfo> createState() => _educationInfoState();
}

class _educationInfoState extends State<educationInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Current Education Information",
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
      body: StreamBuilder<academicCalendarModel>(
        stream: academicCalendarDatabase()
            .academicCalendarData(widget.academicCalendarId),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            academicCalendarModel? academicCalendar = snapshot.data;
            return StreamBuilder<schoolModel>(
              stream: schoolDatabase().schoolData(academicCalendar!.schoolId),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  schoolModel? school = snapshot.data;
                  return StreamBuilder<classModel>(
                    stream:
                        schoolDatabase().classData(academicCalendar.classId),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        classModel? classDetail = snapshot.data;
                        return SingleChildScrollView(
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 30.0, vertical: 30.0),
                            alignment: Alignment.center,
                            child: Column(
                              children: <Widget>[
                                Container(
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
                                  child: Container(
                                    padding: const EdgeInsets.fromLTRB(
                                        20.0, 10.0, 10.0, 20.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        const Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Text(
                                              'School Information',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontSize: 20.0,
                                                  color: Colors.black),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 5.0,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            const Text(
                                              'School Name',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(school!.schoolName)
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 5.0,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            const Text(
                                              'Email',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(school.schoolEmail)
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 5.0,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            const Text(
                                              'Address',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(school.schoolAddress)
                                          ],
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            const Text(
                                              'Contact',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(school.schoolPhoneNumber)
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Container(
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
                                  child: Container(
                                    padding: const EdgeInsets.fromLTRB(
                                        20.0, 10.0, 10.0, 20.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        const Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Text(
                                              'Class Information',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontSize: 20.0,
                                                  color: Colors.black),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 5.0,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            const Text(
                                              'Class Name',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(classDetail!.className)
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 5.0,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            const Text(
                                              'Year',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(classDetail.classYear)
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                StreamBuilder<teacherModel>(
                                    stream: teacherDatabase(
                                            teacherId:
                                                academicCalendar.teacherId)
                                        .teacherData,
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        teacherModel? teacher = snapshot.data;
                                        return Container(
                                          width: double.infinity,
                                          alignment: Alignment.centerLeft,
                                          decoration: const BoxDecoration(
                                              color: Color.fromARGB(
                                                  255, 255, 255, 255),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey,
                                                  spreadRadius: 0,
                                                  blurRadius: 1,
                                                )
                                              ]),
                                          child: Container(
                                            padding: const EdgeInsets.fromLTRB(
                                                20.0, 10.0, 10.0, 20.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                const Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: <Widget>[
                                                    Text(
                                                      'Class Teacher',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          fontSize: 20.0,
                                                          color: Colors.black),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(
                                                  height: 5.0,
                                                ),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    const Text(
                                                      'Teacher Name',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    Text(teacher!
                                                        .teacherFullName)
                                                  ],
                                                ),
                                                const SizedBox(
                                                  height: 5.0,
                                                ),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    const Text(
                                                      'Email',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    Text(teacher.teacherEmail)
                                                  ],
                                                ),
                                                const SizedBox(
                                                  height: 5.0,
                                                ),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    const Text(
                                                      'Contact Number',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    Text(teacher
                                                        .teacherPhoneNumber)
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      } else {
                                        return Container();
                                      }
                                    }),
                                    const SizedBox(
                                  height: 10,
                                ),
                                StreamBuilder<List<subjectModel>>(
                                    stream: academicCalendarDatabase()
                                        .allSubjectData(academicCalendar
                                            .academicCalendarId),
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        List<subjectModel>? subjects =
                                            snapshot.data;
                                        return Container(
                                          width: double.infinity,
                                          alignment: Alignment.centerLeft,
                                          decoration: const BoxDecoration(
                                              color: Color.fromARGB(
                                                  255, 255, 255, 255),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey,
                                                  spreadRadius: 0,
                                                  blurRadius: 1,
                                                )
                                              ]),
                                          child: Container(
                                            padding: const EdgeInsets.fromLTRB(
                                                20.0, 10.0, 10.0, 20.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                const Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: <Widget>[
                                                    Text(
                                                      'Subjects',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          fontSize: 20.0,
                                                          color: Colors.black),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(
                                                  height: 5.0,
                                                ),
                                                ListView.builder(
                                                  shrinkWrap: true,
                                                  itemCount: subjects?.length,
                                                  itemBuilder:
                                                      (context, index) {
                                                    return Text(subjects![index]
                                                        .subjectName);
                                                  },
                                                )
                                              ],
                                            ),
                                          ),
                                        );
                                      } else {
                                        return Container();
                                      }
                                    }),
                                const SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
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
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
