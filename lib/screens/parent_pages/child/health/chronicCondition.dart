import 'package:flutter/material.dart';
import 'package:ummicare/models/healthstatusmodel.dart';
import 'package:ummicare/services/healthDatabase.dart';

class chronicCondition extends StatefulWidget {
  const chronicCondition({super.key, required this.chronicConditionId});
  final String chronicConditionId;

  @override
  State<chronicCondition> createState() => _chronicConditionState();
}

class _chronicConditionState extends State<chronicCondition> {

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ChronicConditionModel>(
      stream: HealthDatabaseService().chronicConditionData(widget.chronicConditionId),
      builder: (context, snapshot) {
        final chronic = snapshot.data;
        return Scaffold(
          appBar: AppBar(
            elevation: 3.0,
            title: const Text(
              "Chronic Condition",
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
                                Icons.emergency,
                                size: 30.0,
                                color: Colors.black,
                              ),
                              SizedBox(width: 5),
                              Text(
                                'Chronic Condition',
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
                                      'Allergies',
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
                                      'Details',
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
                                      ': ${chronic!.childAllergies}',
                                      style: const TextStyle(
                                          fontSize:
                                              15),
                                    ),
                                    const SizedBox(
                                        height:
                                            10),
                                    Text(
                                      ': ${chronic.childChronic}',
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