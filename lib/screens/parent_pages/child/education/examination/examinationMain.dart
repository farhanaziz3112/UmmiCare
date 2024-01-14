import 'package:flutter/material.dart';
import 'package:ummicare/models/examinationModel.dart';
import 'package:ummicare/screens/charts/childExaminationGradePercentage.dart';
import 'package:ummicare/screens/charts/childExaminationPassRate.dart';
import 'package:ummicare/screens/charts/childExaminationProgress.dart';
import 'package:ummicare/screens/parent_pages/child/education/examination/examinationProfile.dart';
import 'package:ummicare/services/examDatabase.dart';
import 'package:ummicare/shared/constant.dart';
import 'package:ummicare/shared/function.dart';
import 'package:ummicare/shared/loading.dart';

class examinationMain extends StatefulWidget {
  const examinationMain(
      {super.key, required this.academicCalendarId, required this.studentId});
  final String academicCalendarId;
  final String studentId;

  @override
  State<examinationMain> createState() => _examinationMainState();
}

class _examinationMainState extends State<examinationMain> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<examModel>>(
        stream: examDatabase()
            .allExamDataWithAcademicCalendarId(widget.academicCalendarId),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<examModel>? examList = snapshot.data;
            if (examList!.isEmpty) {
              return Scaffold(
                appBar: AppBar(
                  title: const Text(
                    "Examination",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  elevation: 3,
                  iconTheme: const IconThemeData(color: Colors.black),
                  centerTitle: true,
                  backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                ),
                body: Container(
                    alignment: Alignment.center,
                    child: noData('There is no exam at the moment...')),
              );
            }
            examList.sort((a, b) => a.examStartDate.compareTo(b.examStartDate));
            return Scaffold(
              appBar: AppBar(
                title: const Text(
                  "Examination",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 17,
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
                            'Upcoming Exam',
                            textAlign: TextAlign.center,
                            style:
                                TextStyle(fontSize: 20.0, color: Colors.black),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        height: 270,
                        width: double.maxFinite,
                        child: GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithMaxCrossAxisExtent(
                                  maxCrossAxisExtent: 250,
                                  childAspectRatio: 1.1,
                                  crossAxisSpacing: 70,
                                  mainAxisSpacing: 10),
                          itemCount: examList.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: ((context, index) {
                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            examinationProfile(
                                                studentId: widget.studentId,
                                                examId: examList[index].examId,
                                                academicCalendarId: widget
                                                    .academicCalendarId)));
                              },
                              child: Container(
                                alignment: Alignment.topLeft,
                                height: double.maxFinite,
                                width: double.maxFinite,
                                padding: const EdgeInsets.all(15),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10)),
                                  border:
                                      Border.all(color: Colors.black, width: 1),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 1,
                                      blurRadius: 5,
                                      offset: const Offset(
                                          0, 3), // changes position of shadow
                                    ),
                                  ],
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Expanded(
                                          flex: 1,
                                          child: Container(),
                                        ),
                                        Expanded(
                                          flex: 10,
                                          child: Container(
                                            alignment: Alignment.center,
                                            child: Text(
                                              examList[index].examTitle,
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                              textAlign: TextAlign.center,
                                              maxLines: 1,
                                            ),
                                          ),
                                        ),
                                        const Expanded(
                                          flex: 1,
                                          child: Icon(Icons.arrow_forward),
                                        )
                                      ],
                                    ),
                                    const SizedBox(height: 20),
                                    const Text(
                                      'Exam Start Date',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15),
                                      textAlign: TextAlign.start,
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      convertTimeToDateWithStringMonth(
                                          examList[index].examStartDate),
                                      style: const TextStyle(fontSize: 15),
                                    ),
                                    const SizedBox(height: 10),
                                    const Text(
                                      'Exam End Date',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15),
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                        convertTimeToDateWithStringMonth(
                                            examList[index].examEndDate),
                                        style: const TextStyle(fontSize: 15)),
                                    const SizedBox(height: 10),
                                    const Text(
                                      'Status',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15),
                                    ),
                                    const SizedBox(height: 5),
                                    Row(
                                      children: <Widget>[
                                        Expanded(
                                          flex: 1,
                                          child: examList[index].examStatus ==
                                                  'inactive'
                                              ? Container(
                                                  alignment: Alignment.center,
                                                  decoration: BoxDecoration(
                                                    color: Colors.yellow[800],
                                                    borderRadius:
                                                        const BorderRadius.all(
                                                            Radius.circular(5)),
                                                  ),
                                                  padding:
                                                      const EdgeInsets.all(3),
                                                  child: const Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
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
                                              : examList[index].examStatus ==
                                                      'ongoing'
                                                  ? Container(
                                                      alignment:
                                                          Alignment.center,
                                                      decoration: BoxDecoration(
                                                        color:
                                                            Colors.green[800],
                                                        borderRadius:
                                                            const BorderRadius
                                                                .all(
                                                                Radius.circular(
                                                                    5)),
                                                      ),
                                                      padding:
                                                          const EdgeInsets.all(
                                                              3),
                                                      child: const Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
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
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 15),
                                                          )
                                                        ],
                                                      ))
                                                  : Container(
                                                      alignment:
                                                          Alignment.center,
                                                      decoration: BoxDecoration(
                                                        color: Colors.red[800],
                                                        borderRadius:
                                                            const BorderRadius
                                                                .all(
                                                                Radius.circular(
                                                                    5)),
                                                      ),
                                                      padding:
                                                          const EdgeInsets.all(
                                                              3),
                                                      child: const Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
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
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 15),
                                                          )
                                                        ],
                                                      )),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Container(),
                                        )
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                  ],
                                ),
                              ),
                            );
                          }),
                        ),
                      ),
                      const SizedBox(height: 50),
                      const Row(
                        children: [
                          Icon(
                            Icons.analytics,
                            color: Colors.black,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Statistics',
                            textAlign: TextAlign.center,
                            style:
                                TextStyle(fontSize: 20.0, color: Colors.black),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      StreamBuilder<List<subjectResultModel>>(
                        stream: examDatabase()
                            .allSubjectResultDataWithAcademicCalendarAndStudentId(
                                widget.studentId, widget.academicCalendarId),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            List<subjectResultModel>? results = snapshot.data;
                            if (results!.isEmpty) {
                              return Center(
                                child: noData('Oops! Nothing here..'),
                              );
                            } else {
                              int pass = getResultPassFailRate(results, 'pass');
                              int fail = getResultPassFailRate(results, 'fail');
                              int A = getResultGradeTotal(results, 'A');
                              int B = getResultGradeTotal(results, 'B');
                              int C = getResultGradeTotal(results, 'C');
                              int D = getResultGradeTotal(results, 'D');
                              int E = getResultGradeTotal(results, 'E');

                              int total = A + B + C + D + E;
                              return Column(
                                children: <Widget>[
                                  Container(
                                      height: 200,
                                      alignment: Alignment.topLeft,
                                      padding: const EdgeInsets.all(15),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(10)),
                                        border: Border.all(
                                            color: Colors.grey, width: 1),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.5),
                                            spreadRadius: 1,
                                            blurRadius: 5,
                                            offset: const Offset(0,
                                                3), // changes position of shadow
                                          ),
                                        ],
                                      ),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: childExaminationPassRate(
                                                results: results),
                                          ),
                                          Expanded(
                                              child: Container(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: <Widget>[
                                                const Text(
                                                  'Pass',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w700),
                                                  textAlign: TextAlign.start,
                                                ),
                                                Text(
                                                    '${getPercentage(pass, pass + fail).toString()}%'),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                const Text(
                                                  'Fail',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w700),
                                                ),
                                                Text(
                                                    '${getPercentage(fail, pass + fail).toString()}%')
                                              ],
                                            ),
                                          ))
                                        ],
                                      )),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                      height: 200,
                                      alignment: Alignment.topLeft,
                                      padding: const EdgeInsets.all(15),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(10)),
                                        border: Border.all(
                                            color: Colors.grey, width: 1),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.5),
                                            spreadRadius: 1,
                                            blurRadius: 5,
                                            offset: const Offset(0,
                                                3), // changes position of shadow
                                          ),
                                        ],
                                      ),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            flex: 3,
                                            child:
                                                childExaminationGradePercentage(
                                                    results: results),
                                          ),
                                          Expanded(flex: 1, child: Container()),
                                          Expanded(
                                              flex: 2,
                                              child: Container(
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: <Widget>[
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: <Widget>[
                                                        CircleAvatar(
                                                          backgroundColor:
                                                              Colors.green[800],
                                                          radius: 5,
                                                        ),
                                                        const SizedBox(
                                                          width: 10,
                                                        ),
                                                        Text(
                                                            'A: ${getPercentage(A, total)}%')
                                                      ],
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: <Widget>[
                                                        CircleAvatar(
                                                          backgroundColor:
                                                              Colors.blue[800],
                                                          radius: 5,
                                                        ),
                                                        const SizedBox(
                                                          width: 10,
                                                        ),
                                                        Text(
                                                            'B: ${getPercentage(B, total)}%')
                                                      ],
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: <Widget>[
                                                        CircleAvatar(
                                                          backgroundColor:
                                                              Colors
                                                                  .orange[800],
                                                          radius: 5,
                                                        ),
                                                        const SizedBox(
                                                          width: 10,
                                                        ),
                                                        Text(
                                                            'C: ${getPercentage(C, total)}%')
                                                      ],
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: <Widget>[
                                                        CircleAvatar(
                                                          backgroundColor:
                                                              Colors
                                                                  .yellow[800],
                                                          radius: 5,
                                                        ),
                                                        const SizedBox(
                                                          width: 10,
                                                        ),
                                                        Text(
                                                            'D: ${getPercentage(D, total)}%')
                                                      ],
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: <Widget>[
                                                        CircleAvatar(
                                                          backgroundColor:
                                                              Colors.red[800],
                                                          radius: 5,
                                                        ),
                                                        const SizedBox(
                                                          width: 10,
                                                        ),
                                                        Text(
                                                            'E: ${getPercentage(E, total)}%')
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ))
                                        ],
                                      )),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    alignment: Alignment.topLeft,
                                    padding: const EdgeInsets.all(15),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(10)),
                                      border: Border.all(
                                          color: Colors.grey, width: 1),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          spreadRadius: 1,
                                          blurRadius: 5,
                                          offset: const Offset(0,
                                              3), // changes position of shadow
                                        ),
                                      ],
                                    ),
                                    child: childExaminationProgress(
                                        studentId: widget.studentId,
                                        academicCalendarId:
                                            widget.academicCalendarId),
                                  )
                                ],
                              );
                            }
                          } else {
                            return Center(
                              child: noData('Oops! Nothing here..'),
                            );
                          }
                        },
                      ),
                      // Row(
                      //   children: <Widget>[
                      //     Expanded(
                      //       flex: 1,
                      //       child: InkWell(
                      //         onTap: () {},
                      //         child: Container(
                      //           width: double.maxFinite,
                      //           padding:
                      //               const EdgeInsets.fromLTRB(10, 10, 0, 10),
                      //           decoration: const BoxDecoration(
                      //               color: Color(0xff71CBCA),
                      //               borderRadius: BorderRadius.all(
                      //                   Radius.circular(10.0))),
                      //           child: const Row(
                      //             children: <Widget>[
                      //               Expanded(
                      //                 flex: 5,
                      //                 child: Column(
                      //                   crossAxisAlignment:
                      //                       CrossAxisAlignment.center,
                      //                   children: <Widget>[
                      //                     Icon(
                      //                       Icons.calendar_month,
                      //                       size: 30.0,
                      //                       color: Colors.white,
                      //                     ),
                      //                     const SizedBox(
                      //                       height: 5,
                      //                     ),
                      //                     Text(
                      //                       'Schedule',
                      //                       style: TextStyle(
                      //                           fontSize: 17.0,
                      //                           color: Colors.white),
                      //                     ),
                      //                   ],
                      //                 ),
                      //               ),
                      //               Expanded(
                      //                 flex: 1,
                      //                 child: Icon(
                      //                   Icons.arrow_forward,
                      //                   color: Colors.white,
                      //                   size: 20,
                      //                 ),
                      //               )
                      //             ],
                      //           ),
                      //         ),
                      //       ),
                      //     ),
                      //     const SizedBox(width: 10),
                      //     Expanded(
                      //       flex: 1,
                      //       child: InkWell(
                      //         onTap: () {},
                      //         child: Container(
                      //           width: double.maxFinite,
                      //           padding:
                      //               const EdgeInsets.fromLTRB(10, 10, 0, 10),
                      //           decoration: const BoxDecoration(
                      //               color: Color(0xff8290F0),
                      //               borderRadius: BorderRadius.all(
                      //                   Radius.circular(10.0))),
                      //           child: const Row(
                      //             children: <Widget>[
                      //               Expanded(
                      //                 flex: 5,
                      //                 child: Column(
                      //                   crossAxisAlignment:
                      //                       CrossAxisAlignment.center,
                      //                   children: <Widget>[
                      //                     Icon(
                      //                       Icons.description,
                      //                       size: 30.0,
                      //                       color: Colors.white,
                      //                     ),
                      //                     const SizedBox(
                      //                       height: 5,
                      //                     ),
                      //                     Text(
                      //                       'Result',
                      //                       style: TextStyle(
                      //                           fontSize: 17.0,
                      //                           color: Colors.white),
                      //                     ),
                      //                   ],
                      //                 ),
                      //               ),
                      //               Expanded(
                      //                 flex: 1,
                      //                 child: Icon(
                      //                   Icons.arrow_forward,
                      //                   color: Colors.white,
                      //                   size: 20,
                      //                 ),
                      //               )
                      //             ],
                      //           ),
                      //         ),
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      // const SizedBox(height: 10),
                      // InkWell(
                      //   onTap: () {},
                      //   child: Container(
                      //     width: double.maxFinite,
                      //     padding: const EdgeInsets.all(10),
                      //     decoration: const BoxDecoration(
                      //         color: Color(0xffF29180),
                      //         borderRadius:
                      //             BorderRadius.all(Radius.circular(10.0))),
                      //     child: const Row(
                      //       children: <Widget>[
                      //         Expanded(
                      //           flex: 1,
                      //           child: Icon(
                      //             Icons.analytics,
                      //             size: 40.0,
                      //             color: Colors.white,
                      //           ),
                      //         ),
                      //         Expanded(
                      //           flex: 4,
                      //           child: Text(
                      //             'Statistics',
                      //             style: TextStyle(
                      //                 fontSize: 17.0, color: Colors.white),
                      //           ),
                      //         ),
                      //         Expanded(
                      //           flex: 1,
                      //           child: Icon(
                      //             Icons.arrow_forward,
                      //             color: Colors.white,
                      //           ),
                      //         )
                      //       ],
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ),
            );
          } else {
            return const Loading();
          }
        });
  }
}
