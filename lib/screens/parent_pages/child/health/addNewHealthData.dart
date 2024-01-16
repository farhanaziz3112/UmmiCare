import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:ummicare/models/childModel.dart';
import 'package:ummicare/models/medicalStaffModel.dart';
import 'package:ummicare/services/activityDatabase.dart';
import 'package:ummicare/services/childDatabase.dart';
import 'package:ummicare/services/healthDatabase.dart';
import 'package:ummicare/services/medicalStaffDatabase.dart';
import 'package:ummicare/services/patientDatabase.dart';
import 'package:ummicare/shared/constant.dart';

class addNewHealthData extends StatefulWidget {
  const addNewHealthData({super.key, required this.child});
  final childModel child;

  @override
  State<addNewHealthData> createState() => _addNewHealthDataState();
}

class _addNewHealthDataState extends State<addNewHealthData> {
  final _formKey = GlobalKey<FormState>();

  double _currentHeight = 0;
  double _currentWeight = 0;
  String _clinic = '';
  String _clinicId = '';
  List<String> clinicList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Add New Health Data",
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
                    'Select a clinic',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[500],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                StreamBuilder<List<ClinicModel>>(
                  stream: medicalStaffDatabase().allClinicData,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<ClinicModel>? clinic = snapshot.data;
                      clinicList.clear();
                      for (int i = 0; i < clinic!.length; i++) {
                        clinicList.add(clinic[i].clinicName);
                      }
                      _clinic = clinicList[0];
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
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please select an option';
                            }
                            for (int i = 0; i < clinic.length; i++) {
                              if (clinic[i]
                                  .clinicName
                                  .toLowerCase()
                                  .contains(_clinic.toLowerCase())) {
                                setState(() {
                                  _clinicId = clinic[i].clinicId;
                                });
                              }
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
                const SizedBox(
                  height: 30.0,
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.only(left: 20.0),
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
                const SizedBox(
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
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                ),
                const SizedBox(
                  height: 30.0,
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.only(left: 20.0),
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
                const SizedBox(
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
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                ),
                const SizedBox(
                  height: 30.0,
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                    ),
                    child: const Text(
                      'Submit',
                      style: TextStyle(color: Colors.black),
                    ),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        final healthDocument = FirebaseFirestore.instance
                            .collection('Health')
                            .doc();
                        double bmi = _currentWeight / pow(_currentHeight, 2);
                        final bmiDocument =
                            FirebaseFirestore.instance.collection('Bmi').doc();
                        final healthStatusDocument = FirebaseFirestore.instance
                            .collection('Health Status')
                            .doc();
                        final patientDocument = FirebaseFirestore.instance
                            .collection('Patient')
                            .doc();
                        await childDatabase(childId: widget.child.childId)
                            .updateChildData(
                                widget.child.childId,
                                widget.child.parentId,
                                widget.child.childCreatedDate,
                                widget.child.childName,
                                widget.child.childFirstname,
                                widget.child.childLastname,
                                widget.child.childBirthday,
                                widget.child.childCurrentAge,
                                widget.child.childAgeCategory,
                                widget.child.childProfileImg,
                                widget.child.educationId,
                                healthDocument.id,
                                widget.child.overallStatus);

                        await HealthDatabaseService().createHealthData(
                            healthDocument.id,
                            widget.child.childId,
                            healthStatusDocument.id,
                            patientDocument.id);

                        await HealthDatabaseService().createBmiData(
                            bmiDocument.id,
                            healthDocument.id,
                            _currentHeight,
                            _currentWeight,
                            bmi);

                        await HealthDatabaseService()
                            .addBmi(healthDocument.id, bmiDocument.id, bmi);

                        await HealthDatabaseService().createHealthStatusData(
                          healthStatusDocument.id,
                          ' ',
                          ' ',
                          ' ',
                          patientDocument.id,
                        );

                        await PatientDatabaseService().createPatientData(
                          patientDocument.id,
                          healthDocument.id,
                          widget.child.childId,
                          _clinicId,
                          healthStatusDocument.id,
                          ' ',
                          widget.child.childProfileImg,
                          widget.child.childName,
                          widget.child.childCurrentAge,
                        );

                        await activityDatabase().createactivityData(
                            widget.child.parentId,
                            widget.child.childId,
                            'Health Module Registered!',
                            '${widget.child.childFirstname} has been registered into Health Module!',
                            'health',
                            DateTime.now().millisecondsSinceEpoch.toString());
                      }
                      Navigator.pop(context);
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
