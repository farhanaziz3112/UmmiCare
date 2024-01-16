import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:ummicare/models/healthmodel.dart';
import 'package:ummicare/screens/parent_pages/child/health/BMI/BmiList.dart';

import 'package:ummicare/services/healthDatabase.dart';

class BmiMain extends StatefulWidget {
  const BmiMain({super.key, required this.healthId});
  final String healthId;


  @override
  State<BmiMain> createState() => _BmiMainState();
}

class _BmiMainState extends State<BmiMain> {
  List<double> bmiData = [];

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<BmiModel>>(
      stream: HealthDatabaseService().allBmiDataWithSameHealthId(widget.healthId),
      builder: (context, snapshot) {
        final bmiData = snapshot.data;
        return Scaffold(
          appBar: AppBar(
            elevation: 3.0,
            title: const Text(
              "BMI",
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
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Container(
                        alignment: Alignment.center,
                        constraints:
                            const BoxConstraints(minWidth: 100, maxWidth: 200),
                        child: const Text(
                          'Height',
                          style: TextStyle(color: Colors.grey, fontSize: 15),
                        ),
                      ),
                    ),
                    Expanded(flex: 1, child: Container()),
                    Expanded(
                      flex: 2,
                      child: Container(
                        alignment: Alignment.center,
                        constraints:
                            const BoxConstraints(minWidth: 100, maxWidth: 200),
                        child: const Text(
                          'Weight',
                          style: TextStyle(color: Colors.grey, fontSize: 15),
                        ),
                      ),
                    ),
                    Expanded(flex: 1, child: Container()),
                    Expanded(
                      flex: 2,
                      child: Container(
                        alignment: Alignment.center,
                        constraints:
                            const BoxConstraints(minWidth: 100, maxWidth: 200),
                        child: const Text(
                          'BMI Status',
                          style: TextStyle(color: Colors.grey, fontSize: 15),
                        ),
                      ),
                    ),
                    Expanded(flex: 1, child: Container()),
                    Expanded(
                      flex: 2,
                      child: Container(
                        alignment: Alignment.center,
                        constraints:
                            const BoxConstraints(minWidth: 100, maxWidth: 200),
                        child: const Text(
                          'Action',
                          style: TextStyle(color: Colors.grey, fontSize: 15),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                BmiList(bmi: bmiData),
              ],
            )
          ),
        );
      }
    );
  }
}