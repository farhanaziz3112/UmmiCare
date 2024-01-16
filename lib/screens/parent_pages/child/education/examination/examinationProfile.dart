import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:ummicare/models/examinationModel.dart';
import 'package:ummicare/models/scheduleModel.dart';
import 'package:ummicare/models/subjectModel.dart';
import 'package:ummicare/services/academicCalendarDatabase.dart';
import 'package:ummicare/services/examDatabase.dart';
import 'package:ummicare/services/scheduleDatabase.dart';
import 'package:ummicare/shared/calendar.dart';
import 'package:ummicare/shared/function.dart';
import 'package:ummicare/shared/loading.dart';

class examinationProfile extends StatefulWidget {
  const examinationProfile(
      {super.key,
      required this.studentId,
      required this.examId,
      required this.academicCalendarId});
  final String studentId;
  final String examId;
  final String academicCalendarId;

  @override
  State<examinationProfile> createState() => _examinationProfileState();
}

class _examinationProfileState extends State<examinationProfile> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<examModel>(
      stream: examDatabase().examData(widget.examId),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          examModel? exam = snapshot.data;
          return Scaffold(
            appBar: AppBar(
              title: Text(
                exam!.examTitle,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: const TextStyle(
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
                        padding:
                            const EdgeInsets.fromLTRB(20.0, 10.0, 10.0, 20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            const Row(
                              children: [
                                Icon(Icons.edit_note, size: 30),
                                SizedBox(width: 5),
                                Text(
                                  'Exam Details',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20.0,
                                      color: Colors.black),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 15.0,
                            ),
                            const Text(
                              'Exam Title',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              exam.examTitle,
                            ),
                            const SizedBox(
                              height: 5.0,
                            ),
                            const Text(
                              'Start Date',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              convertTimeToDateWithStringMonth(
                                  exam.examStartDate),
                            ),
                            const SizedBox(
                              height: 5.0,
                            ),
                            const Text(
                              'End Date',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              convertTimeToDateWithStringMonth(
                                  exam.examEndDate),
                            ),
                            const SizedBox(
                              height: 5.0,
                            ),
                            Row(
                              children: <Widget>[
                                Expanded(
                                  flex: 1,
                                  child: exam.examStatus == 'inactive'
                                      ? Container(
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            color: Colors.yellow[800],
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(5)),
                                          ),
                                          padding: const EdgeInsets.all(3),
                                          child: const Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              Icon(
                                                Icons.schedule,
                                                color: Colors.white,
                                              ),
                                              SizedBox(
                                                width: 3,
                                              ),
                                              Text(
                                                'Inactive',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 15),
                                              )
                                            ],
                                          ))
                                      : exam.examStatus == 'ongoing'
                                          ? Container(
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                color: Colors.green[800],
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(5)),
                                              ),
                                              padding: const EdgeInsets.all(3),
                                              child: const Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: <Widget>[
                                                  Icon(
                                                    Icons.check,
                                                    color: Colors.white,
                                                  ),
                                                  SizedBox(
                                                    width: 3,
                                                  ),
                                                  Text(
                                                    'Ongoing',
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 15),
                                                  )
                                                ],
                                              ))
                                          : Container(
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                color: Colors.red[800],
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(5)),
                                              ),
                                              padding: const EdgeInsets.all(3),
                                              child: const Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: <Widget>[
                                                  Icon(
                                                    Icons.cancel,
                                                    color: Colors.white,
                                                  ),
                                                  SizedBox(
                                                    width: 3,
                                                  ),
                                                  Text(
                                                    'Ended',
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 15),
                                                  )
                                                ],
                                              )),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Container(),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    const Row(
                      children: [
                        Icon(
                          Icons.calendar_month,
                          color: Colors.black,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Exam Schedule',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 25.0, color: Colors.black),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    StreamBuilder<List<academicCalendarScheduleModel>>(
                        stream: scheduleDatabase()
                            .scheduleDataWithAcademicCalendarIdExamId(
                                exam.academicCalendarId, exam.examId, 'exam'),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return SizedBox(
                              height: 500,
                              child: SfCalendar(
                                minDate: convertTimeToDate(exam.examStartDate)
                                    .subtract(const Duration(days: 1)),
                                maxDate: convertTimeToDate(exam.examEndDate)
                                    .add(const Duration(days: 1)),
                                view: CalendarView.schedule,
                                dataSource: scheduler(
                                    _getDataSource(snapshot.data)),
                                timeSlotViewSettings:
                                    const TimeSlotViewSettings(
                                        startHour: 6,
                                        endHour: 18,
                                        timeIntervalHeight: 30),
                                monthViewSettings: const MonthViewSettings(
                                    appointmentDisplayMode:
                                        MonthAppointmentDisplayMode
                                            .appointment),
                              ),
                            );
                          } else {
                            return const Loading();
                          }
                        }),
                    const SizedBox(
                      height: 40,
                    ),
                    const Row(
                      children: [
                        Icon(
                          Icons.description,
                          color: Colors.black,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Exam Result',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 25.0, color: Colors.black),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(
                          flex: 2,
                          child: Container(
                            alignment: Alignment.center,
                            constraints: const BoxConstraints(
                                minWidth: 100, maxWidth: 200),
                            child: const Text(
                              'Subject',
                              textAlign: TextAlign.center,
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 15),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(),
                        ),
                        Expanded(
                          flex: 2,
                          child: Container(
                            alignment: Alignment.center,
                            constraints: const BoxConstraints(
                                minWidth: 100, maxWidth: 200),
                            child: const Text(
                              'Mark',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 15),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(),
                        ),
                        Expanded(
                          flex: 2,
                          child: Container(
                            alignment: Alignment.center,
                            constraints: const BoxConstraints(
                                minWidth: 100, maxWidth: 200),
                            child: const Text(
                              'Grade',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 15),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    StreamBuilder<List<subjectResultModel>>(
                        stream: examDatabase()
                            .subjectResultDataWithStudentIdExamId(
                                widget.studentId, exam.examId),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            List<subjectResultModel>? results = snapshot.data;
                            return ListView.builder(
                              shrinkWrap: true,
                              itemCount: results!.length,
                              itemBuilder: ((context, index) {
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 5),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5, vertical: 5),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(1)),
                                      border: Border.all(color: Colors.grey),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          spreadRadius: 1,
                                          blurRadius: 1,
                                          offset: const Offset(0,
                                              0), // changes position of shadow
                                        ),
                                      ],
                                    ),
                                    child: Row(
                                      children: <Widget>[
                                        StreamBuilder<subjectModel>(
                                            stream: academicCalendarDatabase()
                                                .subjectData(
                                                    results[index].subjectId,
                                                    widget.academicCalendarId),
                                            builder: (context, snapshot) {
                                              if (snapshot.hasData) {
                                                return Expanded(
                                                  flex: 2,
                                                  child: Container(
                                                    alignment: Alignment.center,
                                                    constraints:
                                                        const BoxConstraints(
                                                            minWidth: 100,
                                                            maxWidth: 200),
                                                    child: Text(
                                                      snapshot
                                                          .data!.subjectName,
                                                      maxLines: 2,
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: const TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 13),
                                                    ),
                                                  ),
                                                );
                                              } else {
                                                return const Loading();
                                              }
                                            }),
                                        Expanded(
                                          flex: 1,
                                          child: Container(),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: Container(
                                            alignment: Alignment.center,
                                            constraints: const BoxConstraints(
                                                minWidth: 100, maxWidth: 200),
                                            child: results[index].subjectMark ==
                                                    ''
                                                ? const Text(
                                                    'no data',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        color: Colors.grey,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        fontSize: 10),
                                                  )
                                                : Text(
                                                    results[index].subjectMark,
                                                    textAlign: TextAlign.center,
                                                    style: const TextStyle(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        fontSize: 15),
                                                  ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Container(),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: Container(
                                            alignment: Alignment.center,
                                            constraints: const BoxConstraints(
                                                minWidth: 100, maxWidth: 200),
                                            child: results[index]
                                                        .subjectGrade ==
                                                    ''
                                                ? const Text(
                                                    'no data',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        color: Colors.grey,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        fontSize: 10),
                                                  )
                                                : Text(
                                                    results[index].subjectGrade,
                                                    textAlign: TextAlign.center,
                                                    style: const TextStyle(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        fontSize: 15),
                                                  ),
                                          ),
                                        ),
                                        results[index].subjectGradeStatus == ''
                                            ? Expanded(
                                                flex: 1,
                                                child: Container(),
                                              )
                                            : results[index]
                                                        .subjectGradeStatus ==
                                                    'pass'
                                                ? const Expanded(
                                                    flex: 1,
                                                    child: CircleAvatar(
                                                      backgroundColor:
                                                          Colors.green,
                                                      radius: 5,
                                                    ),
                                                  )
                                                : const Expanded(
                                                    flex: 1,
                                                    child: CircleAvatar(
                                                      backgroundColor:
                                                          Colors.red,
                                                      radius: 5,
                                                    ),
                                                  )
                                      ],
                                    ),
                                  ),
                                );
                              }),
                            );
                          } else {
                            return const Loading();
                          }
                        }),
                  ],
                ),
              ),
            ),
          );
        } else {
          return const Loading();
        }
      },
    );
  }

  List<Meeting> _getDataSource(List<academicCalendarScheduleModel>? examList) {
    final List<Color> _colorList = [
      Colors.orange,
      Colors.blueAccent,
      Colors.blueGrey,
      Colors.red,
      Colors.brown,
      Colors.green,
      Colors.orangeAccent,
      Colors.purple,
      Colors.teal,
      Colors.lightBlue
    ];
    final List<Meeting> meetings = <Meeting>[];
    for (int i = 0; i < examList!.length; i++) {
      meetings.add(Meeting(
          examList[i].title,
          convertTimeToDate(examList[i].from),
          convertTimeToDate(examList[i].to),
          i > 9 ? _colorList[i - 10] : _colorList[i],
          false));
    }
    return meetings;
  }
}
