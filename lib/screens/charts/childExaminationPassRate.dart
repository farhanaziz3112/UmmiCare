import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:ummicare/models/examinationModel.dart';
import 'package:ummicare/shared/function.dart';

class childExaminationPassRate extends StatefulWidget {
  const childExaminationPassRate({super.key, required this.results});
  final List<subjectResultModel> results;

  @override
  State<childExaminationPassRate> createState() =>
      _childExaminationPassRateState();
}

class _childExaminationPassRateState extends State<childExaminationPassRate> {
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
            dataSource: getCategoryData(widget.results),
            radius: '100%',
            pointColorMapper: (CategoryData data, _) => data.color,
            xValueMapper: (CategoryData data, _) => data.x,
            yValueMapper: (CategoryData data, _) => data.y,
            dataLabelSettings: const DataLabelSettings(
                // Renders the data label
                isVisible: true,
                textStyle: TextStyle(fontSize: 20, color: Colors.white)))
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

List<CategoryData> getCategoryData(List<subjectResultModel> results) {
  int pass = getResultPassFailRate(results, 'pass');
  int fail = getResultPassFailRate(results, 'fail');

  return <CategoryData>[
    CategoryData('Pass', getPercentage(pass, pass+fail), Colors.green[800]!),
    CategoryData('Fail', getPercentage(fail, pass+fail), Colors.red[800]!),
  ];
}

