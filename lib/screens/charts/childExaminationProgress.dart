import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:ummicare/models/childModel.dart';
import 'package:ummicare/models/examinationModel.dart';
import 'package:ummicare/models/subjectModel.dart';
import 'package:ummicare/services/academicCalendarDatabase.dart';
import 'package:ummicare/services/examDatabase.dart';
import 'package:ummicare/services/parentDatabase.dart';

class childExaminationProgress extends StatefulWidget {
  const childExaminationProgress(
      {super.key, required this.studentId, required this.academicCalendarId});
  final String studentId;
  final String academicCalendarId;

  @override
  State<childExaminationProgress> createState() =>
      _childExaminationProgressState();
}

class _childExaminationProgressState extends State<childExaminationProgress> {
  late TooltipBehavior _tooltip;

  @override
  void initState() {
    _tooltip = TooltipBehavior(enable: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final chartData = <ChartSampleData>[
    //   ChartSampleData('France', 56, 67, 93, Colors.black),
    //   ChartSampleData('Spain', 26, 48, 65, Colors.green),
    //   ChartSampleData('US', 35, 88, 91, Colors.red),
    //   ChartSampleData('Italy', 92, 79, 56, Colors.blue),
    // ];
    return StreamBuilder<List<subjectModel>>(
      stream:
          academicCalendarDatabase().allSubjectData(widget.academicCalendarId),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<subjectModel>? subjectList = snapshot.data;
          return StreamBuilder<List<examModel>>(
              stream: examDatabase()
                  .allExamDataWithAcademicCalendarId(widget.academicCalendarId),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<examModel>? examList = snapshot.data;
                  return StreamBuilder<List<subjectResultModel>>(
                      stream: examDatabase()
                          .allSubjectResultDataWithAcademicCalendarAndStudentId(
                              widget.studentId, widget.academicCalendarId),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          List<subjectResultModel>? resultList = snapshot.data;
                          return SfCartesianChart(
                              primaryXAxis: CategoryAxis(),
                              primaryYAxis: NumericAxis(
                                  minimum: 0, maximum: 100, interval: 10),
                              tooltipBehavior: _tooltip,
                              series: getData(widget.studentId, subjectList!,
                                  examList!, resultList!));
                        } else {
                          return Container();
                        }
                      });
                  // series: <CartesianSeries<ExamData, String>>[
                  //   // ColumnSeries<ChartSampleData, String>(
                  //   //     dataSource: chartData,
                  //   //     xValueMapper: (ChartSampleData sales, _) =>
                  //   //         sales.x as String,
                  //   //     yValueMapper: (ChartSampleData sales, _) => sales.y,
                  //   //     name: '2015'),
                  //   // ColumnSeries<ChartSampleData, String>(
                  //   //     dataSource: chartData,
                  //   //     xValueMapper: (ChartSampleData sales, _) =>
                  //   //         sales.x as String,
                  //   //     yValueMapper: (ChartSampleData sales, _) =>
                  //   //         sales.secondSeriesYValue,
                  //   //     name: '2016'),
                  //   // ColumnSeries<ChartSampleData, String>(
                  //   //     dataSource: chartData,
                  //   //     xValueMapper: (ChartSampleData sales, _) =>
                  //   //         sales.x as String,
                  //   //     yValueMapper: (ChartSampleData sales, _) =>
                  //   //         sales.thirdSeriesYValue,
                  //   //     name: '2017')

                  // ]);
                } else {
                  return Container();
                }
              });
        } else {
          return Container();
        }
      },
    );
  }
}

List<CartesianSeries<ExamData, String>> getData(
    String studentId,
    List<subjectModel> subjectList,
    List<examModel> examList,
    List<subjectResultModel> resultList) {
  final chartData = <ExamData>[];
  for (int i = 0; i < subjectList.length; i++) {
    List<int> marks = [];
    for (int j = 0; j < examList.length; j++) {
      for (int k = 0; k < resultList.length; k++) {
        if (resultList[k].examId == examList[j].examId &&
            resultList[k].subjectId == subjectList[i].subjectId &&
            resultList[k].studentId == studentId) {
          if (resultList[k].subjectMark != '') {
            marks.add(int.parse(resultList[k].subjectMark));
          } else {
            marks.add(0);
          }
        }
      }
    }
    chartData.add(ExamData(
        subjectList[i].subjectName, marks, Colors.grey));
  }
  List<CartesianSeries<ExamData, String>> finalList = [];
  for (int i = 0; i < examList.length; i++) {
    finalList.add(
      BarSeries<ExamData, String>(
        dataSource: chartData,
        xValueMapper: (ExamData sales, _) => sales.x as String,
        yValueMapper: (ExamData sales, _) => sales.marks[i],
        name: examList[i].examTitle),
    );
  }
  // List<CartesianSeries<ExamData, String>> finalList = [
    // ColumnSeries<ExamData, String>(
    //     dataSource: chartData,
    //     xValueMapper: (ExamData sales, _) => sales.x as String,
    //     yValueMapper: (ExamData sales, _) => sales.first,
    //     name: examList[0].examTitle),
  //   ColumnSeries<ExamData, String>(
  //       dataSource: chartData,
  //       xValueMapper: (ExamData sales, _) => sales.x as String,
  //       yValueMapper: (ExamData sales, _) => sales.second,
  //       name: examList[1].examTitle),
  //   ColumnSeries<ExamData, String>(
  //       dataSource: chartData,
  //       xValueMapper: (ExamData sales, _) => sales.x as String,
  //       yValueMapper: (ExamData sales, _) => sales.third,
  //       name: examList[2].examTitle)
  // ];
  return finalList;
}

class ExamData {
  ExamData(this.x, this.marks, this.color);
  final String x;
  final List<int> marks;
  final Color color;
}

// List<StatusData> getStatusData(List<childModel> childList) {
//   int active = getNoOfChildEducationStatus(childList, true);
//   int inactive = getNoOfChildEducationStatus(childList, false);

//   return <StatusData>[
//     StatusData('Inactive', inactive, Colors.red),
//     StatusData('Active', active, Colors.green),
//   ];
// }

// class _ChartData {
//   _ChartData(this.x, this.y);

//   final String x;
//   final double y;
// }
