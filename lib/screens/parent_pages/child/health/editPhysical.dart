
import 'dart:math';

import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:ummicare/models/healthmodel.dart';
import 'package:ummicare/services/healthDatabase.dart';
import 'package:ummicare/shared/constant.dart';

class EditPhysical extends StatefulWidget {
  const EditPhysical({super.key, required this.bmiId});
  final String bmiId;

  @override
  State<EditPhysical> createState() => _EditPhysicalState();
} 

class _EditPhysicalState extends State<EditPhysical> {

  final _formKey = GlobalKey<FormState>();

  double _currentHeight = 0;
  double _currentWeight = 0;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<BmiModel>(
      stream: HealthDatabaseService().bmiData(widget.bmiId),
      builder: (context, snapshot) {
        if(snapshot.hasData){
          BmiModel? bmi = snapshot.data;
          return Scaffold(
            appBar: AppBar(
              title: const Text(
                "Edit Bmi Data",
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
                        initialValue: _currentHeight.toString() == ''
                            ? bmi?.currentHeight.toString() ?? ''
                            : _currentHeight.toString(),
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
                        initialValue: _currentWeight.toString() == ''
                            ? bmi?.currentWeight.toString() ?? ''
                            : _currentWeight.toString(),
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
                          double bmiData = (_currentWeight == 0
                              ? bmi!.currentWeight
                              : _currentWeight) / pow(_currentHeight == 0
                              ? bmi!.currentHeight
                              : _currentHeight, 2);
                          await HealthDatabaseService()
                            .createBmiData(
                              widget.bmiId,
                              bmi!.healthId,
                              _currentHeight == 0
                              ? bmi.currentHeight
                              : _currentHeight,
                              _currentWeight == 0
                              ? bmi.currentWeight
                              : _currentWeight,
                              bmiData);

                          await HealthDatabaseService().addBmi(bmi.healthId, widget.bmiId, bmiData);
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
        }else{
          return Container();
        }
      }
    );
  }
}