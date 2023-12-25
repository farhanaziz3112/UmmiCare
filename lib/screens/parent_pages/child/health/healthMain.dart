import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:ummicare/models/healthModel.dart';
import 'package:ummicare/screens/parent_pages/child/health/healthAppointment.dart';
import 'package:ummicare/screens/parent_pages/child/health/healthStatus.dart';
import 'package:ummicare/screens/parent_pages/child/health/editPhysical.dart';
import 'package:ummicare/screens/parent_pages/child/health/addNewHealthStatusData.dart';

import 'package:ummicare/services/healthDatabase.dart';

class healthMain extends StatefulWidget {
  const healthMain({super.key, required this.childId, required this.healthId});
  final String childId;
  final String healthId;


  @override
  State<healthMain> createState() => _healthMainState();
}

class _healthMainState extends State<healthMain> {
  late List<double> bmiData;
  late List<int> dateLabels;

  void _editPhysical() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
            child: EditPhysical(childId: widget.childId, healthId: widget.healthId),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<HealthModel>>(
      stream: HealthDatabaseService(childId: widget.healthId).allHealthData,
      builder: (context, snapshot) {
        final healthData = snapshot.data;
        for(int i=0; i<healthData!.length-1; i++){
          bmiData.add(bmiData as double);
        }
        List<Map<String, dynamic>> _bmiData = List.generate(
          healthData.length,
          (index) => {'date': dateLabels[index], 'bmiValue': bmiData[index]},
        );
        return Scaffold(
          appBar: AppBar(
            elevation: 0.0,
            title: const Text(
              "Health",
              style: TextStyle(
                color: Colors.black,
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            centerTitle: true,
            backgroundColor: const Color(0xffe1eef5),
            actions: <Widget>[
              TextButton.icon(
                icon: const Icon(Icons.person),
                label: const Text('EditHealth'),
                onPressed: () => _editPhysical(),
              )
            ],
          ),
          body: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 30.0),
                alignment: Alignment.center,
              child: Column(
                children: <Widget>[
                  SfCartesianChart(
                    primaryXAxis: CategoryAxis(),
                    series: <ChartSeries>[
                      LineSeries<Map<String, dynamic>, String>(
                        dataSource: _bmiData,
                        xValueMapper: (Map<String, dynamic> data, _) => data['date']!,
                        yValueMapper: (Map<String, dynamic> data, _) => data['bmiValue']!,
                        dataLabelSettings: DataLabelSettings(isVisible: true),
                      )
                    ],
                  ),
                  Container(
                    width: double.infinity,
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10.0))),
                    child: Container(
                      padding: const EdgeInsets.all(20.0),
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text("graph"),
                          SizedBox(
                            height: 5.0,
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
                    alignment: Alignment.centerLeft,
                    decoration: const BoxDecoration(
                        color: Color(0xff71CBCA),
                        borderRadius:
                            BorderRadius.all(Radius.circular(10.0))),
                    child: Container(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              const Icon(
                                Icons.health_and_safety,
                                size: 30.0,
                                color: Colors.white,
                              ),
                              const Text(
                                ' Health Status',
                                style: TextStyle(
                                    fontSize: 20.0, color: Colors.white),
                              ),
                              Flexible(
                                child: Container(
                                  alignment: Alignment.centerRight,
                                  child: IconButton(
                                    icon: const Icon(
                                      Icons.edit,
                                      size: 25.0,
                                      color: Colors.white,
                                    ),
                                    onPressed: () {
                                      if(healthData[healthData.length - 1].healthStatusId == null){
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                addNewHealthStatusData(
                                                    healthStatusId: healthData[0].healthStatusId),
                                          ));
                                      }else{
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                healthStatus(
                                                    childId: widget.childId, healthId: widget.healthId,healthStatusId: healthData[0].healthStatusId),
                                          ));
                                      }
                                      
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 5.0,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Container(
                    width: double.infinity,
                    alignment: Alignment.centerLeft,
                    decoration: const BoxDecoration(
                        color: Color(0xffF29180),
                        borderRadius:
                            BorderRadius.all(Radius.circular(10.0))),
                    child: Container(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              const Icon(
                                Icons.vaccines,
                                size: 30.0,
                                color: Colors.white,
                              ),
                              const Text(
                                ' Health Appointment',
                                style: TextStyle(
                                    fontSize: 20.0, color: Colors.white),
                              ),
                              Flexible(
                                child: Container(
                                  alignment: Alignment.centerRight,
                                  child: IconButton(
                                    icon: const Icon(
                                      Icons.edit,
                                      size: 25.0,
                                      color: Colors.white,
                                    ),
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                healthAppointment(
                                                    childId: widget.childId, healthId: widget.healthId),
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
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }
    );
  }
}