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
            elevation: 0.0,
            title: const Text(
              "Chronic Condition",
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