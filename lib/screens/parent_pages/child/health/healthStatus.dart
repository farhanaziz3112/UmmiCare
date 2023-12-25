import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:ummicare/models/healthstatusmodel.dart';
import 'package:ummicare/screens/parent_pages/child/health/healthCodition.dart';
import 'package:ummicare/screens/parent_pages/child/health/physicalCondition.dart';
import 'package:ummicare/services/healthDatabase.dart';

class healthStatus extends StatefulWidget {
  const healthStatus({super.key, required this.childId, required this.healthId,required this.healthStatusId});
  final String childId;
  final String healthId;
  final String healthStatusId;

  @override
  State<healthStatus> createState() => _healthStatusState();
}

class _healthStatusState extends State<healthStatus> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<HealthStatusModel>>(
      stream: HealthDatabaseService(childId: widget.healthStatusId).allHealthStatusData,
      builder: (context, snapshot){
        final healthData = snapshot;
        return Scaffold(
          appBar: AppBar(
            elevation: 0.0,
            title: const Text(
              "Health Status",
              style: TextStyle(
                color: Colors.black,
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            centerTitle: true,
            backgroundColor: const Color(0xffe1eef5),
          ),
          body: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 30.0),
                alignment: Alignment.center,
              child: Column(
                children: <Widget>[
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          width: 150,
                          alignment: Alignment.centerLeft,
                          decoration: const BoxDecoration(
                              color: Color(0xffF29180),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0))),
                          child: Container(
                            padding: const EdgeInsets.fromLTRB(5, 20, 0, 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                const Row(
                                  children: <Widget>[
                                    Icon(
                                      Icons.height,
                                      size: 20.0,
                                      color: Colors.white,
                                    ),
                                    Text(
                                      'Temperature',
                                      style: TextStyle(
                                          fontSize: 20.0, color: Colors.white),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 5.0,
                                ),
                                Text(
                                    '${healthData.data?[0].currentTemperature}'
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          width: 150,
                          alignment: Alignment.centerLeft,
                          decoration: const BoxDecoration(
                              color: Color(0xff8290F0),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0))),
                          child: Container(
                            padding: const EdgeInsets.fromLTRB(5, 20, 0, 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                const Row(
                                  children: <Widget>[
                                    Icon(
                                      Icons.monitor_weight,
                                      size: 20.0,
                                      color: Colors.white,
                                    ),
                                    Text(
                                      'Heart Rate',
                                      style: TextStyle(
                                          fontSize: 20.0, color: Colors.white),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 5.0,
                                ),
                                Text(
                                    '${healthData.data?[0].currentHeartRate}'
                                ,)
                              ],
                            ),
                          ),
                        ),
                      ]
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Container(
                    width: double.infinity,
                    alignment: Alignment.centerLeft,
                    decoration: const BoxDecoration(
                        color: Color(0xff8290F0),
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
                                ' Health Condition',
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
                                                healthCondition(
                                                    healthStatusId: widget.healthStatusId, healthConditionId: healthData.data![0].healthConditionId,),
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
                                ' Physical Condition',
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
                                                physicalCondition(
                                                    healthStatusId: widget.healthStatusId, physicalConditionId: healthData.data![0].physicalConditionId,),
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
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Icon(
                                Icons.health_and_safety,
                                size: 30.0,
                                color: Colors.white,
                              ),
                              Text(
                                ' Chronic Condition',
                                style: TextStyle(
                                    fontSize: 20.0, color: Colors.white),
                              ),
                            ],
                          ),
                          SizedBox(
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
      },
    );
  }
}