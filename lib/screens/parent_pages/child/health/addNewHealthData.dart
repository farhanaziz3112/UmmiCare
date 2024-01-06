import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:ummicare/models/medicalStaffModel.dart';
import 'package:ummicare/services/healthDatabase.dart';
import 'package:ummicare/services/medicalStaffDatabase.dart';
import 'package:ummicare/shared/constant.dart';

class addNewHealthData extends StatefulWidget {
  const addNewHealthData({super.key, required this.healthId});
  final String healthId;

  @override
  State<addNewHealthData> createState() => _addNewHealthDataState();
} 

class _addNewHealthDataState extends State<addNewHealthData> {

  final _formKey = GlobalKey<FormState>();

  double _currentHeight = 0;
  double _currentWeight = 0;
  String _clinic = 'Please register a clinic';
  List<String> clinicList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Add New Health Data",
          style: TextStyle(
            color: Colors.black,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: IconThemeData(color: Colors.black),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
      ),
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 30.0,
                ),
                StreamBuilder<List<ClinicModel>>(
                  stream: medicalStaffDatabase().allClinicData,
                  builder: (context, snapshot) {
                    if(snapshot.hasError){
                      return Text('Error: ${snapshot.error}');
                    }
                    if(snapshot.hasData){
                      List<ClinicModel>? clinic = snapshot.data;
                      for(int i =0; i<clinic!.length; i++){
                        clinicList.add(clinic[i].clinicName);
                      }
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: DropdownButtonFormField<String>(
                          value: _clinic,
                          onChanged: (String? newValue) {
                            setState(() {
                              _clinic = newValue!;
                            });
                          },
                          items: clinicList
                              .map<DropdownMenuItem<String>>((clinicList) {
                            return DropdownMenuItem<String>(
                              value: clinicList,
                              child: Text(clinicList),
                            );
                          }).toList(),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please select an option';
                            }
                            return null;
                          },
                        ),
                      );
                    } else {
                      return Container();
                    }
                  },
                ),
                // Padding(
                //   padding: const EdgeInsets.all(8.0),
                //   child: DropdownButtonFormField<String>(
                //     value: _clinic,
                //     onChanged: (String? newValue) {
                //       setState(() {
                //         _clinic = newValue!;
                //       });
                //     },
                //     items: <String>['Option 1', 'Option 2', 'Option 3', 'Option 4']
                //         .map<DropdownMenuItem<String>>((String value) {
                //       return DropdownMenuItem<String>(
                //         value: value,
                //         child: Text(value),
                //       );
                //     }).toList(),
                //     validator: (value) {
                //       if (value == null || value.isEmpty) {
                //         return 'Please select an option';
                //       }
                //       return null;
                //     },
                //   ),
                // ),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(left: 20.0),
                  child: Text(
                    'Current Height(m)',
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
                    'Current Weight(kg)',
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
                  'Submit',
                  style: TextStyle(color: Colors.black),
                ),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    double bmi = _currentWeight / pow(_currentHeight, 2);
                    final bmihDocument = FirebaseFirestore.instance
                                                          .collection('Bmi')
                                                          .doc();
                    await HealthDatabaseService()
                        .createBmiData(
                          bmihDocument.id,
                          widget.healthId,
                          _currentHeight,
                          _currentWeight,
                          bmi);
                    await HealthDatabaseService().addBmi(widget.healthId, bmihDocument.id);
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