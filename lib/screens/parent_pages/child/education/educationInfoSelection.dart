import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:ummicare/screens/parent_pages/child/education/educationInfo/educationInfo.dart';
import 'package:ummicare/screens/parent_pages/child/education/educationInfo/educationRecord.dart';
import 'package:ummicare/screens/parent_pages/child/education/educationInfo/requestClassWithdrawal.dart';

class educationInfoSelection extends StatefulWidget {
  const educationInfoSelection(
      {super.key, required this.studentId, required this.academicCalendarId});
  final String studentId;
  final String academicCalendarId;

  @override
  State<educationInfoSelection> createState() => _educationInfoSelectionState();
}

class _educationInfoSelectionState extends State<educationInfoSelection> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Education Information",
            style: TextStyle(
              color: Colors.black,
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          iconTheme: const IconThemeData(color: Colors.black),
          centerTitle: true,
          backgroundColor: const Color.fromARGB(255, 255, 255, 255),
          elevation: 3,
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
                      color: Color(0xff71CBCA),
                      borderRadius: BorderRadius.all(Radius.circular(10.0))),
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(10.0, 10.0, 0.0, 10.0),
                    child: Row(
                      children: <Widget>[
                        const Icon(
                          Icons.school,
                          size: 30.0,
                          color: Colors.black,
                        ),
                        const Text(
                          ' Current Education Information',
                          style: TextStyle(fontSize: 17.0, color: Colors.black),
                        ),
                        Flexible(
                          child: Container(
                            alignment: Alignment.centerRight,
                            child: IconButton(
                              icon: const Icon(
                                Icons.arrow_forward,
                                size: 25.0,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => educationInfo(
                                            academicCalendarId:
                                                widget.academicCalendarId,
                                            studentId: widget.studentId)));
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15.0,
                ),
                Container(
                  width: double.infinity,
                  alignment: Alignment.centerLeft,
                  decoration: const BoxDecoration(
                      color: Color(0xffF29180),
                      borderRadius: BorderRadius.all(Radius.circular(10.0))),
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(10.0, 10.0, 0.0, 10.0),
                    child: Row(
                      children: <Widget>[
                        const Icon(
                          Icons.logout,
                          size: 30.0,
                          color: Colors.black,
                        ),
                        const Text(
                          ' Request Class Withdrawal',
                          style: TextStyle(fontSize: 17.0, color: Colors.black),
                        ),
                        Flexible(
                          child: Container(
                            alignment: Alignment.centerRight,
                            child: IconButton(
                              icon: const Icon(
                                Icons.arrow_forward,
                                size: 25.0,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            requestClassWithdrawal(
                                                academicCalendarId:
                                                    widget.academicCalendarId,
                                                studentId: widget.studentId)));
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15.0,
                ),
                Container(
                  width: double.infinity,
                  alignment: Alignment.centerLeft,
                  decoration: const BoxDecoration(
                      color: Color(0xff8290F0),
                      borderRadius: BorderRadius.all(Radius.circular(10.0))),
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(10.0, 10.0, 0.0, 10.0),
                    child: Row(
                      children: <Widget>[
                        const Icon(
                          Icons.list,
                          size: 30.0,
                          color: Colors.black,
                        ),
                        const Text(
                          ' View Education Record',
                          style: TextStyle(fontSize: 17.0, color: Colors.black),
                        ),
                        Flexible(
                          child: Container(
                            alignment: Alignment.centerRight,
                            child: IconButton(
                              icon: const Icon(
                                Icons.arrow_forward,
                                size: 25.0,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => educationRecord(studentId: widget.studentId)));
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
