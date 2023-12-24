import 'dart:math';

import 'package:flutter/material.dart';
import 'package:ummicare/services/healthDatabase.dart';
import 'package:ummicare/shared/constant.dart';
import 'package:ummicare/models/healthModel.dart';
import 'package:ummicare/shared/loading.dart';

class EditPhysical extends StatefulWidget {
  const EditPhysical({super.key, required this.childId, required this.healthId});
  final String childId;
  final String healthId;

  @override
  State<EditPhysical> createState() => _EditPhysicalState();
}

class _EditPhysicalState extends State<EditPhysical> {

  final _formKey = GlobalKey<FormState>();

  late double _currentHeight;
  late double _currentWeight;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<HealthModel>(
      stream: HealthDatabaseService(childId: widget.childId).healthData,
      builder: (context, snapshot) {
        if(snapshot.hasData){
          final healthData = snapshot.data;
          return Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 30.0,
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(left: 20.0),
                  child: Text(
                    'Current Height',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[500],
                    ),
                  ),
                ),
                SizedBox(
                  height: 30.0,
                ),
                TextFormField(
                  initialValue: _currentHeight.toString(),
                  decoration: textInputDecoration,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter current height';
                    }
                    if (double.tryParse(value) == null) {
                      return 'Please enter a valid number';
                    }
                    return null;
                  },
                  onChanged: (value) =>
                      setState(() => _currentHeight = double.parse(value)),
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                ),
                SizedBox(
                  height: 30.0,
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(left: 20.0),
                  child: Text(
                    'Current Weight',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[500],
                    ),
                  ),
                ),
                SizedBox(
                  height: 30.0,
                ),
                TextFormField(
                  initialValue: _currentWeight.toString(),
                  decoration: textInputDecoration,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter current height';
                    }
                    if (double.tryParse(value) == null) {
                      return 'Please enter a valid number';
                    }
                    return null;
                  },
                  onChanged: (value) =>
                      setState(() => _currentWeight = double.parse(value)),
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                ),
                SizedBox(
                  height: 30.0,
                ),
                ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                ),
                child: Text(
                  'Update',
                  style: TextStyle(color: Colors.black),
                ),
                onPressed: () async {
                  if (_formKey.currentState!.validate()){
                    double bmi = _currentWeight / pow(_currentHeight, 2);
                    await HealthDatabaseService(childId: healthData!.childId)
                      .createBmiData(
                            healthData.bmiId,
                            _currentHeight,
                            _currentWeight,
                            bmi);
                  }
                  Navigator.pop(context);
                }
                )
              ],
            ),
          );
        }else{
          return Loading();
        }
      }
    );
  }
}