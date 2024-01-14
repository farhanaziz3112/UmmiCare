import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:ummicare/models/examinationModel.dart';
import 'package:ummicare/shared/function.dart';

class childExaminationGradePercentage extends StatefulWidget {
  const childExaminationGradePercentage({super.key, required this.results});
  final List<subjectResultModel> results;

  @override
  State<childExaminationGradePercentage> createState() =>
      _childExaminationGradePercentageState();
}

class _childExaminationGradePercentageState
    extends State<childExaminationGradePercentage> {
  late TooltipBehavior _tooltipBehavior;

  @override
  void initState() {
    _tooltipBehavior = TooltipBehavior(enable: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SfCircularChart(
      tooltipBehavior: _tooltipBehavior,
      series: <CircularSeries>[
        PieSeries<CategoryData, String>(
            dataSource: getGradeData(widget.results),
            radius: '100%',
            pointColorMapper: (CategoryData data, _) => data.color,
            xValueMapper: (CategoryData data, _) => data.x,
            yValueMapper: (CategoryData data, _) => data.y,
            dataLabelSettings: const DataLabelSettings(
                isVisible: true,
                textStyle: TextStyle(fontSize: 10, color: Colors.white)))
      ],
    );
  }
}

class CategoryData {
  CategoryData(this.x, this.y, this.color);
  final String x;
  final double y;
  final Color color;
}

List<CategoryData> getGradeData(List<subjectResultModel> results) {
  int A = getResultGradeTotal(results, 'A');
  int B = getResultGradeTotal(results, 'B');
  int C = getResultGradeTotal(results, 'C');
  int D = getResultGradeTotal(results, 'D');
  int E = getResultGradeTotal(results, 'E');

  int total = A + B + C + D + E;
  print(total);

  return <CategoryData>[
    CategoryData('A', getPercentage(A, total), Colors.green[800]!),
    CategoryData('B', getPercentage(B, total), Colors.blue[800]!),
    CategoryData('C', getPercentage(C, total), Colors.orange[800]!),
    CategoryData('D', getPercentage(D, total), Colors.yellow[800]!),
    CategoryData('E', getPercentage(E, total), Colors.red[800]!),
  ];
}
