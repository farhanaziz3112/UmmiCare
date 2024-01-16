
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:ummicare/services/healthDatabase.dart';
import 'package:ummicare/shared/constant.dart';

class addBmi extends StatefulWidget {
  const addBmi({super.key, required this.healthId});
  final String healthId;

  @override
  State<addBmi> createState() => _addBmiState();
} 

class _addBmiState extends State<addBmi> {

  final _formKey = GlobalKey<FormState>();

  double _currentHeight = 0;
  double _currentWeight = 0;

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Add Bmi Data",
          style: TextStyle(
            color: Colors.black,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
      ),
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(left: 20.0),
                  child: Text(
                    'Height(m)',
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
                  onChanged: (value) {
                    setState(() {
                      _currentHeight = (value.isEmpty ? null : double.parse(value))!;
                    });
                  },
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                ),
                SizedBox(
                  height: 30.0,
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(left: 20.0),
                  child: Text(
                    'Weight(kg)',
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
                  onChanged: (value) {
                    setState(() {
                      _currentWeight = (value.isEmpty ? null : double.parse(value))!;
                    });
                  },
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
                  'Submit',
                  style: TextStyle(color: Colors.black),
                ),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    final bmiDocument =
                            FirebaseFirestore.instance.collection('Bmi').doc();
                    double bmiData = (_currentWeight) / pow(_currentHeight, 2);
                    await HealthDatabaseService()
                      .createBmiData(
                        bmiDocument.id,
                        widget.healthId,
                        _currentHeight,
                        _currentWeight,
                        bmiData);

                    await HealthDatabaseService().addBmi(widget.healthId, bmiDocument.id, bmiData);
                  }
                    Navigator.pop(context);
                }
                )
              ],
            ),
          ),
        ),
      ),
    );
        
  }
}