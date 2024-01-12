import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:ummicare/models/healthmodel.dart';
import 'package:ummicare/services/healthDatabase.dart';

class childBmi extends StatefulWidget {
  const childBmi({super.key, required this.healthId});
  final String healthId;

  @override
  State<childBmi> createState() => _childBmiState();
}

class _childBmiState extends State<childBmi> {
  late TooltipBehavior _tooltipBehavior;

  @override
  void initState() {
    _tooltipBehavior = TooltipBehavior(enable: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<BmiModel>>(
      stream: HealthDatabaseService().allBmiDataWithSameHealthId(widget.healthId),
      builder: (context, snapshot) {
        if(snapshot.hasError){
          return Text('Error: ${snapshot.error}');
        }
        if (snapshot.hasData) {
          List<BmiModel>? bmiData = snapshot.data;
          return SfCartesianChart(
            primaryXAxis: CategoryAxis(),
            title: ChartTitle(
              text: 'BMI data over index',
              textStyle: const TextStyle(
                fontWeight: FontWeight.bold
              )
            ),
            tooltipBehavior: _tooltipBehavior,
            series: <LineSeries<BmiPerIndex, String>>[
              LineSeries<BmiPerIndex, String>(
                dataSource: getBmiPerIndexList(bmiData!),
                xValueMapper: (BmiPerIndex data, _) => data.index,
                yValueMapper: (BmiPerIndex data, _) => data.bmi,
                dataLabelSettings: const DataLabelSettings(isVisible: true),
              )
            ],
          );        
        } else {
          return Container(
            child: Text(widget.healthId),
          );
        }
      }
    );
  }
}

class BmiPerIndex {
  BmiPerIndex(this.index, this.bmi);
  final String index;
  final double bmi;
}

BmiPerIndex getBmiPerIndex(List<BmiModel> bmiData, int index) {
  return BmiPerIndex((index+1).toString(), bmiData[index].bmiData);
} 

List<BmiPerIndex> getBmiPerIndexList(List<BmiModel> bmiData) {
  List<BmiPerIndex> BmiPerIndexList = [];
  for (int i = 0; i < bmiData.length; i++) {
    BmiPerIndex bmiPerIndex = getBmiPerIndex(bmiData, i);
    BmiPerIndexList.add(bmiPerIndex);
  }
  return BmiPerIndexList;
}

