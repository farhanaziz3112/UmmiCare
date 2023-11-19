import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:ummicare/models/healthmodel.dart';
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
    return StreamBuilder<HealthStatusModel>(
      stream: HealthDatabaseService(childId: widget.childId).healthStatusData,
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
              padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 30.0),
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
                          decoration: BoxDecoration(
                              color: Color(0xffF29180),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0))),
                          child: Container(
                            padding: EdgeInsets.fromLTRB(5, 20, 0, 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Icon(
                                      Icons.height,
                                      size: 30.0,
                                      color: Colors.white,
                                    ),
                                    Text(
                                      'Temperature',
                                      style: TextStyle(
                                          fontSize: 20.0, color: Colors.white),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 5.0,
                                ),
                                Text(
                                    'Current Temperature:' '${healthData.data?.currentTemperature}'
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          width: 150,
                          alignment: Alignment.centerLeft,
                          decoration: BoxDecoration(
                              color: Color(0xff8290F0),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0))),
                          child: Container(
                            padding: EdgeInsets.fromLTRB(5, 20, 0, 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Icon(
                                      Icons.monitor_weight,
                                      size: 30.0,
                                      color: Colors.white,
                                    ),
                                    Text(
                                      'Heart Rate',
                                      style: TextStyle(
                                          fontSize: 20.0, color: Colors.white),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 5.0,
                                ),
                                Text(
                                    'Heart Rate:' '${healthData.data?.currentHeartRate}'
                                ,)
                              ],
                            ),
                          ),
                        ),
                      ]
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Container(
                    width: double.infinity,
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(
                        color: Color(0xff8290F0),
                        borderRadius:
                            BorderRadius.all(Radius.circular(10.0))),
                    child: Container(
                      padding: EdgeInsets.all(20.0),
                      child: Column(
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
                                ' Health Condition',
                                style: TextStyle(
                                    fontSize: 20.0, color: Colors.white),
                              ),
                              Flexible(
                                child: Container(
                                  alignment: Alignment.centerRight,
                                  child: IconButton(
                                    icon: Icon(
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
                                                    childId: widget.childId, healthConditionId: healthData.data!.healthConditionId,),
                                          ));
                                    },
                                  ),
                                ),
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
                  SizedBox(
                    height: 10.0,
                  ),
                  Container(
                    width: double.infinity,
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(
                        color: Color(0xffF29180),
                        borderRadius:
                            BorderRadius.all(Radius.circular(10.0))),
                    child: Container(
                      padding: EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Icon(
                                Icons.vaccines,
                                size: 30.0,
                                color: Colors.white,
                              ),
                              Text(
                                ' Physical Condition',
                                style: TextStyle(
                                    fontSize: 20.0, color: Colors.white),
                              ),
                              Flexible(
                                child: Container(
                                  alignment: Alignment.centerRight,
                                  child: IconButton(
                                    icon: Icon(
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
                                                    childId: widget.childId, physicalConditionId: healthData.data!.physicalConditionId,),
                                          ));
                                    },
                                  ),
                                ),
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
                  SizedBox(
                    height: 10.0,
                  ),
                  Container(
                    width: double.infinity,
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(
                        color: Color(0xff71CBCA),
                        borderRadius:
                            BorderRadius.all(Radius.circular(10.0))),
                    child: Container(
                      padding: EdgeInsets.all(20.0),
                      child: Column(
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
                              Flexible(
                                child: Container(
                                  alignment: Alignment.centerRight,
                                  child: IconButton(
                                    icon: Icon(
                                      Icons.edit,
                                      size: 25.0,
                                      color: Colors.white,
                                    ),
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                healthStatus(
                                                    childId: widget.childId, healthId: widget.healthId,healthStatusId: widget.healthStatusId,),
                                          ));
                                    },
                                  ),
                                ),
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