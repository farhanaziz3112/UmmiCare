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
              "physical Condition",
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
            // child
          ),
        );
      },
    );
  }
}