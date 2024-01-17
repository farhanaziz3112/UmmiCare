import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:ummicare/models/healthmodel.dart';
import 'package:ummicare/screens/charts/childBmi.dart';
import 'package:ummicare/screens/parent_pages/child/health/BmiMain.dart';
import 'package:ummicare/screens/parent_pages/child/health/healthAppointment.dart';
import 'package:ummicare/screens/parent_pages/child/health/healthStatus.dart';

import 'package:ummicare/services/healthDatabase.dart';

class healthMain extends StatefulWidget {
  const healthMain({super.key, required this.childId, required this.healthId, required this.parentId});
  final String childId;
  final String parentId;
  final String healthId;


  @override
  State<healthMain> createState() => _healthMainState();
}

class _healthMainState extends State<healthMain> {
  List<double> bmiData = [];

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<HealthModel>(
      stream: HealthDatabaseService().healthData(widget.healthId),
      builder: (context, snapshot) {
        final healthData = snapshot.data;
        return Scaffold(
          appBar: AppBar(
            elevation: 3.0,
            title: const Text(
              "Health",
              style: TextStyle(
                color: Colors.black,
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            iconTheme: const IconThemeData(color: Colors.black),
            centerTitle: true,
            backgroundColor: const Color.fromARGB(255, 255, 255, 255),
            actions: <Widget>[
              TextButton.icon(
                icon: const Icon(Icons.person),
                label: const Text('BMI'),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            BmiMain(
                                healthId: widget.healthId),
                      ));
                },
              )
            ],
          ),
          body: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 30.0),
                alignment: Alignment.center,
              child: Column(
                children: <Widget>[
                  Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(),
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 200,
                          child: childBmi(healthId: widget.healthId),
                        ),
                      ],
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
                                ' Health Status',
                                style: TextStyle(
                                    fontSize: 20.0, color: Colors.white),
                              ),
                              Flexible(
                                child: Container(
                                  alignment: Alignment.centerRight,
                                  child: IconButton(
                                    icon: const Icon(
                                      Icons.arrow_forward,
                                      size: 25.0,
                                      color: Colors.white,
                                    ),
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                healthStatus(
                                                    healthId: widget.healthId, healthStatusId: healthData!.healthStatusId),
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
                                ' Health Appointment',
                                style: TextStyle(
                                    fontSize: 20.0, color: Colors.white),
                              ),
                              Flexible(
                                child: Container(
                                  alignment: Alignment.centerRight,
                                  child: IconButton(
                                    icon: const Icon(
                                      Icons.arrow_forward,
                                      size: 25.0,
                                      color: Colors.white,
                                    ),
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                healthAppointment(
                                                    childId: widget.childId, healthId: widget.healthId, parentId: widget.parentId),
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