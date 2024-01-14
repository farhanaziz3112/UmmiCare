import 'package:flutter/material.dart';
import 'package:ummicare/models/healthstatusmodel.dart';
import 'package:ummicare/services/healthDatabase.dart';

class physicalCondition extends StatefulWidget {
  const physicalCondition({super.key, required this.physicalConditionId});
  final String physicalConditionId;

  @override
  State<physicalCondition> createState() => _physicalConditionState();
}

class _physicalConditionState extends State<physicalCondition> {

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<PhysicalConditionModel>(
      stream: HealthDatabaseService().physicalConditionData(widget.physicalConditionId),
      builder: (context, snapshot) {
        final physical = snapshot.data;
        return Scaffold(
          appBar: AppBar(
            elevation: 0.0,
            title: const Text(
              "Physical Condition",
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
                          Icons.personal_injury,
                          size: 30.0,
                          color: Colors.black,
                        ),
                        SizedBox(width: 5),
                        Text(
                          'Physical Condition',
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
                                'Injury',
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
                                ': ${physical?.currentInjury}',
                                style: const TextStyle(
                                    fontSize:
                                        15),
                              ),
                              const SizedBox(
                                  height:
                                      10),
                              Text(
                                ': ${physical?.details}',
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
          ),
        );
      },
    );
  }
}