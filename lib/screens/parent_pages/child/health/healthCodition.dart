import 'package:flutter/material.dart';
import 'package:ummicare/models/healthstatusmodel.dart';
import 'package:ummicare/services/healthDatabase.dart';

class healthCondition extends StatefulWidget {
  const healthCondition({super.key, required this.healthConditionId});
  final String healthConditionId;

  @override
  State<healthCondition> createState() => _healthConditionState();
}

class _healthConditionState extends State<healthCondition> {

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<HealthConditionModel>(
      stream: HealthDatabaseService().healthConditionData(widget.healthConditionId),
      builder: (context, snapshot) {
        final condition = snapshot.data;
        return Scaffold(
          appBar: AppBar(
            elevation: 3.0,
            title: const Text(
              "Health Condition",
              style: TextStyle(
                color: Colors.black,
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            iconTheme: const IconThemeData(color: Colors.black),
            centerTitle: true,
            backgroundColor: const Color.fromARGB(255, 255, 255, 255),
          ),
          body: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 30.0),
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
                      padding: const EdgeInsets.fromLTRB(
                          20.0, 10.0, 10.0, 20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                Icons.medical_information,
                                size: 30.0,
                                color: Colors.black,
                              ),
                              SizedBox(width: 5),
                              Text(
                                'Health Condition',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 18.0, color: Colors.black),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 5.0,
                          ),
                          Row(
                            children: <Widget>[
                              const Expanded(
                                flex: 1,
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment
                                          .start,
                                  children: <Widget>[
                                    Text(
                                      'Temperature',
                                      style: TextStyle(
                                          fontWeight: FontWeight
                                              .bold,
                                          fontSize:
                                              15),
                                    ),
                                    SizedBox(
                                        height:
                                            10),
                                    Text(
                                      'Heart Rate',
                                      style: TextStyle(
                                          fontWeight: FontWeight
                                              .bold,
                                          fontSize:
                                              15),
                                    ),
                                    SizedBox(
                                        height:
                                            10),
                                    Text(
                                      'Symptom',
                                      style: TextStyle(
                                          fontWeight: FontWeight
                                              .bold,
                                          fontSize:
                                              15),
                                    ),
                                    SizedBox(
                                        height:
                                            10),
                                    Text(
                                      'Illness',
                                      style: TextStyle(
                                          fontWeight: FontWeight
                                              .bold,
                                          fontSize:
                                              15),
                                    ),
                                    SizedBox(
                                        height:
                                            10),
                                    Text(
                                      'Notes',
                                      style: TextStyle(
                                          fontWeight: FontWeight
                                              .bold,
                                          fontSize:
                                              15),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                  width: 20),
                              Expanded(
                                flex: 2,
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment
                                          .start,
                                  children: <Widget>[
                                    Text(
                                      ': ${condition!.currentTemperature}',
                                      style: const TextStyle(
                                          fontSize:
                                              15),
                                    ),
                                    const SizedBox(
                                        height:
                                            10),
                                    Text(
                                      ': ${condition.currentHeartRate}',
                                      style: const TextStyle(
                                          fontSize:
                                              15),
                                    ),
                                    const SizedBox(
                                        height:
                                            10),
                                    Text(
                                      ': ${condition.currentSymptom}',
                                      style: const TextStyle(
                                          fontSize:
                                              15),
                                    ),
                                    const SizedBox(
                                        height:
                                            10),
                                    Text(
                                      ': ${condition.currentIllness}',
                                      style: const TextStyle(
                                          fontSize:
                                              15),
                                    ),
                                    const SizedBox(
                                        height:
                                            10),
                                    Text(
                                      ': ${condition.notes}',
                                      style: const TextStyle(
                                          fontSize:
                                              15),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          )
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