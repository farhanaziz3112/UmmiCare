import 'package:flutter/material.dart';
import 'package:ummicare/models/healthmodel.dart';
import 'package:ummicare/screens/parent_pages/child/health/editPhysical.dart';
import 'package:ummicare/services/healthDatabase.dart';

class BmiTile extends StatefulWidget {
  const BmiTile({super.key, required this.healthId, required this.bmiId});
  final String healthId;
  final String bmiId;

  @override
  State<BmiTile> createState() => _BmiTileState();
}

class _BmiTileState extends State<BmiTile> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<BmiModel>(
      stream: HealthDatabaseService().bmiData(widget.bmiId),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          BmiModel? bmi = snapshot.data;
          String bmiStatus = ' ';
          double lastBmiData =
              bmi!.bmiData;
          if (lastBmiData < 16) {
            bmiStatus = "Severe Thinness";
          } else if (lastBmiData < 17) {
            bmiStatus =
                "Moderate Thinness";
          } else if (lastBmiData < 18.5) {
            bmiStatus = "Mild Thinness";
          } else if (lastBmiData < 25) {
            bmiStatus = "Normal";
          } else if (lastBmiData < 30) {
            bmiStatus = "Overweight";
          } else if (lastBmiData < 35) {
            bmiStatus = "Obese Class I";
          } else if (lastBmiData < 40) {
            bmiStatus = "Obese Class II";
          } else if (lastBmiData >= 40) {
            bmiStatus = "Obese Class III";
          } else {
            bmiStatus = "No Status";
          }
          return Padding(
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xff8290F0),
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 2,
                    child: Container(
                      alignment: Alignment.center,
                      child: Text(
                        bmi.currentHeight.toString(),
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            color: Colors.white, fontSize: 15),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(),
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(
                      alignment: Alignment.center,
                      child: Text(
                        bmi.currentWeight.toString(),
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.normal,
                            fontSize: 15),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(),
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(
                      alignment: Alignment.center,
                      child: Text(
                        bmiStatus,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.normal,
                            fontSize: 15),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(),
                  ),
                  Expanded(
                    flex: 2,
                    child: Column(
                      children: <Widget>[
                        IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      EditPhysical(
                                          bmiId: bmi.bmiId),
                                ));
                          },
                        ),
                      ],
                    )
                  ),
                ],
              ),
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }
}