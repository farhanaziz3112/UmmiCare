import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';
import 'package:ummicare/services/healthDatabase.dart';
import 'package:ummicare/shared/constant.dart';

class addNewHealthData extends StatefulWidget {
  const addNewHealthData({super.key, required this.childId});
  final String childId;

  @override
  State<addNewHealthData> createState() => _addNewHealthDataState();
}

class _addNewHealthDataState extends State<addNewHealthData> {

  final _formKey = GlobalKey<FormState>();

  String _currentHeight = '';
  String _currentWeight = '';

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
                  initialValue: _currentHeight,
                  decoration: textInputDecoration,
                  validator: (value) =>
                      value == '' ? 'Please enter current height' : null,
                  onChanged: (value) =>
                      setState(() => _currentHeight = value),
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
                  initialValue: _currentWeight,
                  decoration: textInputDecoration,
                  validator: (value) =>
                      value == '' ? 'Please enter current weight' : null,
                  onChanged: (value) =>
                      setState(() => _currentWeight = value),
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
                    //------------Health-------------
                    String healthIdHolder =
                        DateTime.now().millisecondsSinceEpoch.toString() +
                            widget.childId;
                    String healthStatusIdHolder =
                        DateTime.now().millisecondsSinceEpoch.toString() + "1" +
                            widget.childId;
                    await HealthDatabaseService(childId: widget.childId)
                        .createHealthData(
                            healthIdHolder,
                            widget.childId,
                            healthStatusIdHolder,
                            _currentHeight,
                            _currentWeight,);   
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