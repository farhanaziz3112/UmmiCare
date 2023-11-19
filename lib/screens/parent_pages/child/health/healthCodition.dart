import 'package:flutter/material.dart';
import 'package:ummicare/shared/constant.dart';
import 'package:ummicare/services/healthDatabase.dart';

class healthCondition extends StatefulWidget {
  const healthCondition({super.key, required this.childId,required this.healthConditionId});
  final String childId;
  final String healthConditionId;

  @override
  State<healthCondition> createState() => _healthCondition();
}

class _healthCondition extends State<healthCondition> {

  final _formKey = GlobalKey<FormState>();

  String _currentSymptom = '';
  String _currentIllness = '';
  String _notes = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: Text(
          "Edit Health Condition",
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
                  height: 10.0,
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(left: 20.0),
                  child: Text(
                    'Symptom',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[500],
                    ),
                  ),
                ),
                SizedBox(
                  height: 15.0,
                ),
                TextFormField(
                  initialValue: _currentSymptom,
                  decoration: textInputDecoration,
                  validator: (value) =>
                      value == '' ? 'Please enter current symptom' : null,
                  onChanged: (value) =>
                      setState(() => _currentSymptom = value),
                ),
                SizedBox(
                  height: 30.0,
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(left: 20.0),
                  child: Text(
                    'Current Illness',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[500],
                    ),
                  ),
                ),
                SizedBox(
                  height: 15.0,
                ),
                TextFormField(
                  initialValue: _currentIllness,
                  decoration: textInputDecoration,
                  validator: (value) =>
                      value == '' ? 'Please enter current illness' : null,
                  onChanged: (value) =>
                      setState(() => _currentIllness = value),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(left: 20.0),
                  child: Text(
                    'Notes',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[500],
                    ),
                  ),
                ),
                SizedBox(
                  height: 15.0,
                ),
                TextFormField(
                  initialValue: _notes,
                  decoration: textInputDecoration,
                  validator: (value) =>
                      value == '' ? 'Please enter some notes' : null,
                  onChanged: (value) =>
                      setState(() => _notes = value),
                ),
                SizedBox(
                  height: 20.0,
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
                    await HealthDatabaseService(childId: widget.childId)
                        .createHealthConditionData(
                            widget.healthConditionId,
                            _currentSymptom,
                            _currentIllness,
                            _notes);
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