import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:ummicare/models/academicCalendarModel.dart';
import 'package:ummicare/models/schoolModel.dart';
import 'package:ummicare/models/studentModel.dart';
import 'package:ummicare/models/teacherModel.dart';
import 'package:ummicare/screens/parent_pages/child/education/educationInfoSelection.dart';
import 'package:ummicare/screens/parent_pages/child/education/fee/feeMain.dart';
import 'package:ummicare/screens/parent_pages/child/education/registerNewEducationPages.dart/addSchool.dart';
import 'package:ummicare/services/academicCalendarDatabase.dart';
import 'package:ummicare/services/schoolDatabase.dart';
import 'package:ummicare/services/studentDatabase.dart';
import 'package:ummicare/services/teacherDatabase.dart';
import 'package:ummicare/shared/loading.dart';

class educationMain extends StatefulWidget {
  const educationMain(
      {super.key, required this.studentId, required this.childId});
  final String studentId;
  final String childId;

  @override
  State<educationMain> createState() => _educationMainState();
}

class _educationMainState extends State<educationMain> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<studentModel>(
        stream: studentDatabase().studentData(widget.studentId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Loading();
          } else {
            if (snapshot.hasData) {
              studentModel? student = snapshot.data;
              return Scaffold(
                appBar: AppBar(
                  title: const Text(
                    "Education Module",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 25,
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    const Icon(
                                      Icons.school,
                                      size: 30.0,
                                      color: Colors.black,
                                    ),
                                    const SizedBox(width: 5),
                                    const Text(
                                      'School & Class Information',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 18.0, color: Colors.black),
                                    ),
                                    student!.activationStatus == 'active'
                                        ? Flexible(
                                            child: Container(
                                              alignment: Alignment.centerRight,
                                              child: IconButton(
                                                icon: Icon(
                                                  Icons.edit,
                                                  size: 25.0,
                                                  color: Colors.grey[800],
                                                ),
                                                onPressed: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            educationInfoSelection(
                                                                childId: widget
                                                                    .childId),
                                                      ));
                                                },
                                              ),
                                            ),
                                          )
                                        : Container()
                                  ],
                                ),
                                const SizedBox(
                                  height: 5.0,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    const Text(
                                      'School Name',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    StreamBuilder<schoolModel>(
                                      stream: schoolDatabase()
                                          .schoolData(student.schoolId),
                                      builder: (context, snapshot) {
                                        if (snapshot.connectionState ==
                                            ConnectionState.waiting) {
                                          return const Loading();
                                        } else {
                                          if (snapshot.hasData) {
                                            return Text(
                                              snapshot.data!.schoolName,
                                              overflow: TextOverflow.ellipsis,
                                            );
                                          } else {
                                            return Container();
                                          }
                                        }
                                      },
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 5.0,
                                ),
                                StreamBuilder<classModel>(
                                    stream: schoolDatabase()
                                        .classData(student.classId),
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        return Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Text(
                                              'Class Year',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(snapshot.data!.classYear),
                                            const SizedBox(
                                              height: 5.0,
                                            ),
                                            const Text(
                                              'Class Name',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                              snapshot.data!.className,
                                            )
                                          ],
                                        );
                                      } else {
                                        return Container();
                                      }
                                    }),
                                const SizedBox(
                                  height: 3.0,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    const Text(
                                      'Teacher',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    StreamBuilder<academicCalendarModel>(
                                      stream: academicCalendarDatabase()
                                          .academicCalendarData(
                                              student.academicCalendarId),
                                      builder: (context, snapshot) {
                                        if (snapshot.hasData) {
                                          academicCalendarModel?
                                              academicCalendar = snapshot.data;
                                          return StreamBuilder<teacherModel>(
                                            stream: teacherDatabase(
                                                    teacherId: academicCalendar!
                                                        .teacherId)
                                                .teacherData,
                                            builder: (context, snapshot) {
                                              if (snapshot.connectionState ==
                                                  ConnectionState.waiting) {
                                                return const SizedBox();
                                              } else {
                                                if (snapshot.hasData) {
                                                  return Text(
                                                    snapshot
                                                        .data!.teacherFullName,
                                                  );
                                                } else {
                                                  return Container();
                                                }
                                              }
                                            },
                                          );
                                        } else {
                                          return Container();
                                        }
                                      },
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 3.0,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Status',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(student.activationStatus),
                                    const SizedBox(
                                      height: 5.0,
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        student.activationStatus == 'active'
                            ? Column(
                                children: <Widget>[
                                  const Row(
                                    children: [
                                      Icon(
                                        Icons.campaign,
                                        color: Colors.black,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        'Announcement',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 20.0, color: Colors.black),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  const Row(
                                    children: [
                                      Icon(
                                        Icons.event,
                                        color: Colors.black,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        'Upcoming Events',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 20.0, color: Colors.black),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => feeMain(
                                                academicCalendarId:
                                                    student.academicCalendarId,
                                                    studentId: student.studentId,),
                                          ));
                                    },
                                    child: Container(
                                      width: double.maxFinite,
                                      padding: const EdgeInsets.all(10),
                                      decoration: const BoxDecoration(
                                          color: Color(0xff71CBCA),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10.0))),
                                      child: const Row(
                                        children: <Widget>[
                                          Expanded(
                                            flex: 1,
                                            child: Icon(
                                              Icons.attach_money,
                                              size: 40.0,
                                              color: Colors.white,
                                            ),
                                          ),
                                          Expanded(
                                            flex: 4,
                                            child: Text(
                                              'Fee Payment',
                                              style: TextStyle(
                                                  fontSize: 17.0,
                                                  color: Colors.white),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Icon(
                                              Icons.arrow_forward,
                                              color: Colors.white,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10.0,
                                  ),
                                  InkWell(
                                    onTap: () {},
                                    child: Container(
                                      width: double.maxFinite,
                                      padding: const EdgeInsets.all(10),
                                      decoration: const BoxDecoration(
                                          color: Color(0xff8290F0),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10.0))),
                                      child: const Row(
                                        children: <Widget>[
                                          Expanded(
                                            flex: 1,
                                            child: Icon(
                                              Icons.fact_check,
                                              size: 40.0,
                                              color: Colors.white,
                                            ),
                                          ),
                                          Expanded(
                                            flex: 4,
                                            child: Text(
                                              'Attendance',
                                              style: TextStyle(
                                                  fontSize: 17.0,
                                                  color: Colors.white),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Icon(
                                              Icons.arrow_forward,
                                              color: Colors.white,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10.0,
                                  ),
                                  InkWell(
                                    onTap: () {},
                                    child: Container(
                                      width: double.maxFinite,
                                      padding: const EdgeInsets.all(10),
                                      decoration: const BoxDecoration(
                                          color: Color(0xffF29180),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10.0))),
                                      child: const Row(
                                        children: <Widget>[
                                          Expanded(
                                            flex: 1,
                                            child: Icon(
                                              Icons.edit_note,
                                              size: 40.0,
                                              color: Colors.white,
                                            ),
                                          ),
                                          Expanded(
                                            flex: 4,
                                            child: Text(
                                              'Examination',
                                              style: TextStyle(
                                                  fontSize: 17.0,
                                                  color: Colors.white),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Icon(
                                              Icons.arrow_forward,
                                              color: Colors.white,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10.0,
                                  ),
                                ],
                              )
                            : Container(
                                padding: const EdgeInsets.all(10),
                                width: double.infinity,
                                alignment: Alignment.center,
                                decoration: const BoxDecoration(
                                    color: Color(0xffF29180),
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(10.0))),
                                child: const Row(
                                  children: [
                                    Expanded(flex: 1, child: Icon(Icons.error)),
                                    Expanded(
                                      flex: 4,
                                      child: Text(
                                          'The student registration is not yet approved by the teacher. Please wait until the registration is approved.'),
                                    ),
                                  ],
                                ),
                              )
                      ],
                    ),
                  ),
                ),
              );
            } else {
              return Scaffold(
                  appBar: AppBar(
                    title: const Text(
                      "Education",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    iconTheme: const IconThemeData(color: Colors.black),
                    centerTitle: true,
                    backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                  ),
                  body: Center(
                      child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xff8290F0)),
                    child: const Text(
                      'Register New Education Module',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                addSchool(childId: widget.childId),
                          ));
                    },
                  )));
            }
          }
        });
  }
}
