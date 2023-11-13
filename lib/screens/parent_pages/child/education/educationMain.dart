import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:ummicare/models/educationmodel.dart';
import 'package:ummicare/screens/parent_pages/child/education/addNewEduCalendar.dart';
import 'package:ummicare/screens/parent_pages/child/education/educationInfoSelection.dart';

import '../../../../services/eduDatabase.dart';

class educationMain extends StatefulWidget {
  const educationMain({super.key, required this.childId});
  final String childId;

  @override
  State<educationMain> createState() => _educationMainState();
}

class _educationMainState extends State<educationMain> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<EducationModel>>(
        stream: EduDatabaseService(childId: widget.childId).educationData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: SpinKitPulse(
                color: Colors.black,
                size: 20.0,
              ),
            );
          } else {
            List<EducationModel> educationModelData = [];
            if (snapshot.hasData) {
              educationModelData = snapshot.data!;
            }
            if (educationModelData.isEmpty) {
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
                                addNewEduCalendar(childId: widget.childId),
                          ));
                    },
                  )));
            } else {
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
                  iconTheme: const IconThemeData(color: Colors.black),
                  centerTitle: true,
                  backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                ),
                body: SingleChildScrollView(
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 30.0, vertical: 30.0),
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
                            padding:
                                const EdgeInsets.fromLTRB(20.0, 10.0, 10.0, 20.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    const Icon(
                                      Icons.school,
                                      size: 30.0,
                                      color: Colors.black,
                                    ),
                                    const Text(
                                      ' Education Information',
                                      style: TextStyle(
                                          fontSize: 20.0, color: Colors.black),
                                    ),
                                    Flexible(
                                      child: Container(
                                        alignment: Alignment.centerRight,
                                        child: IconButton(
                                          icon: const Icon(
                                            Icons.edit,
                                            size: 25.0,
                                            color: Color.fromARGB(255, 0, 0, 0),
                                          ),
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      educationInfoSelection(childId: widget.childId),
                                                ));
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 5.0,
                                ),
                                Row(
                                  children: <Widget>[
                                    Text(
                                      'Current Year: ',
                                      style: TextStyle(
                                        color: Colors.grey[600]
                                      ),
                                    ),
                                    Text(
                                      '${educationModelData[0].currentYear}'
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 3.0,
                                ),
                                Row(
                                  children: <Widget>[
                                    Text(
                                      'School Name: ',
                                      style: TextStyle(
                                        color: Colors.grey[600]
                                      ),
                                    ),
                                    StreamBuilder<SchoolModel>(
                                      stream: EduDatabaseService(
                                              childId: widget.childId,
                                              schoolId:
                                                  educationModelData[0].schoolId)
                                          .schoolData,
                                      builder: (context, snapshot) {
                                        if (snapshot.connectionState ==
                                            ConnectionState.waiting) {
                                          return const SizedBox();
                                        } else {
                                          return Flexible(
                                            child: Text(
                                              '${snapshot.data!.schoolName}',
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          );
                                        }
                                      },
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 3.0,
                                ),
                                Row(
                                  children: <Widget>[
                                    Text(
                                      'Class Name: ',
                                      style: TextStyle(
                                        color: Colors.grey[600]
                                      ),
                                    ),
                                    StreamBuilder<ClassModel>(
                                      stream: EduDatabaseService(
                                              childId: widget.childId,
                                              classId:
                                                  educationModelData[0].classId)
                                          .classData,
                                      builder: (context, snapshot) {
                                        if (snapshot.connectionState ==
                                            ConnectionState.waiting) {
                                          return const SizedBox();
                                        } else {
                                          return Text(
                                            '${snapshot.data!.className}',
                                          );
                                        }
                                      },
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 3.0,
                                ),
                                Row(
                                  children: <Widget>[
                                    Text(
                                      'Class Name: ',
                                      style: TextStyle(
                                        color: Colors.grey[600]
                                      ),
                                    ),
                                    StreamBuilder<TeacherModel>(
                                      stream: EduDatabaseService(
                                              childId: widget.childId,
                                              teacherId:
                                                  educationModelData[0].classTeacherId)
                                          .teacherData,
                                      builder: (context, snapshot) {
                                        if (snapshot.connectionState ==
                                            ConnectionState.waiting) {
                                          return const SizedBox();
                                        } else {
                                          return Text(
                                            '${snapshot.data!.teacherName}',
                                          );
                                        }
                                      },
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Container(
                          width: double.infinity,
                          alignment: Alignment.center,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Expanded(
                                child: Container(
                                  decoration: const BoxDecoration(
                                    color: Color(0xff71CBCA),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10.0))),
                                  child: Column(
                                    children: <Widget>[
                                      Container(
                                        height: 10.0,
                                        alignment: Alignment.centerRight,
                                        child: IconButton(
                                          icon: Transform.scale(
                                            scaleX: -1,
                                            child: const Icon(
                                              Icons.arrow_back,
                                              size: 25.0,
                                              color: Colors.white,
                                            ),
                                          ),
                                          onPressed: () {},
                                        ),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.fromLTRB(15.0, 5.0, 15.0, 15.0),
                                        child: Column(
                                          children: <Widget>[
                                            const Icon(
                                              Icons.attach_money,
                                              size: 50.0,
                                              color: Colors.white,
                                            ),
                                            const Text(
                                              'Fee Payment',
                                              style: TextStyle(
                                                fontSize: 17.0,
                                                color: Colors.white
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 10.0,
                                            ),
                                            Text(
                                              'Next Fee Payment Deadline:',
                                              style: TextStyle(
                                                fontSize: 10.0,
                                                color: Colors.grey[200]
                                              ),
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 10.0,
                              ),
                              Expanded(
                                child: Container(
                                  decoration: const BoxDecoration(
                                  color: Color(0xff8290F0),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0))),
                                  child: Column(
                                    children: <Widget>[
                                      Container(
                                        height: 10.0,
                                        alignment: Alignment.centerRight,
                                        child: IconButton(
                                          icon: Transform.scale(
                                            scaleX: -1,
                                            child: const Icon(
                                              Icons.arrow_back,
                                              size: 25.0,
                                              color: Colors.white,
                                            ),
                                          ),
                                          onPressed: () {},
                                        ),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.fromLTRB(15.0, 5.0, 15.0, 15.0),
                                        child: Column(
                                          children: <Widget>[
                                            const Icon(
                                              Icons.menu_book_rounded,
                                              size: 50.0,
                                              color: Colors.white,
                                            ),
                                            const Text(
                                              'Homework',
                                              style: TextStyle(
                                                fontSize: 17.0,
                                                color: Colors.white
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 10.0,
                                            ),
                                            Text(
                                              'Next Homework Deadline:',
                                              style: TextStyle(
                                                fontSize: 10.0,
                                                color: Colors.grey[200]
                                              ),
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Container(
                          width: double.infinity,
                          alignment: Alignment.center,
                          decoration: const BoxDecoration(
                            color: Color(0xffF29180),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0))),
                          child: Column(
                            children: <Widget>[
                              Container(
                                height: 10.0,
                                alignment: Alignment.centerRight,
                                child: IconButton(
                                  icon: Transform.scale(
                                    scaleX: -1,
                                    child: const Icon(
                                      Icons.arrow_back,
                                      size: 25.0,
                                      color: Colors.white,
                                    ),
                                  ),
                                  onPressed: () {},
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.fromLTRB(15.0, 5.0, 15.0, 15.0),
                                alignment: Alignment.centerLeft,
                                child: const Row(
                                  children: <Widget>[
                                    Icon(
                                      Icons.library_books,
                                      size: 50.0,
                                      color: Colors.white,
                                    ),
                                    Text(
                                      ' Examination',
                                      style: TextStyle(
                                        fontSize: 23.0,
                                        color: Colors.white
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Upcoming Examination:',
                                  style: TextStyle(
                                    color: Colors.grey[200],
                                    fontSize: 15.0
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 2.0,
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                                alignment: Alignment.centerLeft,
                                child: const Text(
                                  'Exam Midyear - 22 June 2023',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15.0
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 20.0,
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Current Performance',
                                  style: TextStyle(
                                    color: Colors.grey[200],
                                    fontSize: 15.0
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 25.0,
                              ),
                              Container(
                                padding: const EdgeInsets.fromLTRB(15.0, 0, 15.0, 15.0),
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Examination Results',
                                  style: TextStyle(
                                    color: Colors.grey[200],
                                    fontSize: 15.0
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 35.0,
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            }
          }
        });
  }
}
