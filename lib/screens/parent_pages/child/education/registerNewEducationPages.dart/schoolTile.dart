import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ummicare/models/childModel.dart';
import 'package:ummicare/models/schoolModel.dart';
import 'package:ummicare/screens/parent_pages/child/education/registerNewEducationPages.dart/addAcademicCalendar.dart';
import 'package:ummicare/services/childDatabase.dart';
import 'package:ummicare/services/schoolDatabase.dart';
import 'package:ummicare/services/studentDatabase.dart';

class schoolTile extends StatefulWidget {
  const schoolTile(
      {super.key, required this.schoolDetail, required this.childId});
  final schoolModel schoolDetail;
  final String childId;

  @override
  State<schoolTile> createState() => _schoolTileState();
}

class _schoolTileState extends State<schoolTile> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<schoolModel>(
      stream: schoolDatabase().schoolData(widget.schoolDetail.schoolId),
      builder: ((context, snapshot) {
        if (snapshot.hasData) {
          schoolModel? school = snapshot.data;
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
                              "School Registration",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
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
                                'School Name',
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
                            Container(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                school.schoolName,
                                textAlign: TextAlign.left,
                                style: const TextStyle(
                                  fontSize: 15.0,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            const SizedBox(height: 20.0),
                            Container(
                              alignment: Alignment.centerLeft,
                              child: const Text(
                                'School Email',
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
                            Container(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                school.schoolEmail,
                                textAlign: TextAlign.left,
                                style: const TextStyle(
                                  fontSize: 15.0,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            const SizedBox(height: 20.0),
                            Container(
                              alignment: Alignment.centerLeft,
                              child: const Text(
                                'School Address',
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
                            Container(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                school.schoolAddress,
                                textAlign: TextAlign.left,
                                style: const TextStyle(
                                  fontSize: 15.0,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            const SizedBox(height: 20.0),
                            Container(
                              alignment: Alignment.centerLeft,
                              child: const Text(
                                'School Contact Number',
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
                            Container(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                school.schoolPhoneNumber,
                                textAlign: TextAlign.left,
                                style: const TextStyle(
                                  fontSize: 15.0,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20.0,
                            ),
                            Container(
                              alignment: Alignment.centerLeft,
                              child: const Text(
                                'REMINDER: Make user you choose the right school before proceed to register!',
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
                                    content: Padding(
                                      padding: const EdgeInsets.all(5),
                                      child: Column(
                                        children: [
                                          const Text(
                                            'Are you sure you want to register with:',
                                            style: TextStyle(fontSize: 13),
                                          ),
                                          Text(
                                            '${school.schoolName}?',
                                            textAlign: TextAlign.left,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15),
                                          ),
                                        ],
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
                                            style:
                                                TextStyle(color: Colors.white)),
                                      ),
                                      StreamBuilder<childModel>(
                                          stream: childDatabase(
                                                  childId: widget.childId)
                                              .childData,
                                          builder: (context, snapshot) {
                                            if (snapshot.hasData) {
                                              childModel? child = snapshot.data;
                                              return ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor:
                                                      const Color(0xff8290F0),
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5)),
                                                ),
                                                onPressed: () {
                                                  final studentDocument =
                                                      FirebaseFirestore.instance
                                                          .collection('Student')
                                                          .doc();
                                                  studentDatabase()
                                                      .updateStudentData(
                                                          studentDocument.id,
                                                          widget.childId,
                                                          school.schoolId,
                                                          '',
                                                          '',
                                                          '',
                                                          'inactive');
                                                  childDatabase(
                                                          childId:
                                                              widget.childId)
                                                      .updateChildData(
                                                          child!.childId,
                                                          child.parentId,
                                                          child
                                                              .childCreatedDate,
                                                          child.childName,
                                                          child.childFirstname,
                                                          child.childLastname,
                                                          child.childBirthday,
                                                          child.childCurrentAge,
                                                          child
                                                              .childAgeCategory,
                                                          child.childProfileImg,
                                                          studentDocument.id,
                                                          child.healthId);

                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              addAcademicCalendar(
                                                                studentId: studentDocument.id,
                                                                schoolId: school.schoolId,
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
                      offset: const Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        const Expanded(
                          flex: 1,
                          child: Text(
                            'Name: ',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white, fontSize: 15),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Text(
                            school!.schoolName,
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
                            'Address: ',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white, fontSize: 15),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Text(
                            school.schoolAddress,
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
                            'Email: ',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white, fontSize: 15),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Text(
                            school.schoolEmail,
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
                            'Contact: ',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white, fontSize: 15),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Text(
                            school.schoolPhoneNumber,
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
      }),
    );
  }
}
