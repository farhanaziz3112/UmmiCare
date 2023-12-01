import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:ummicare/shared/constant.dart';
import 'package:ummicare/services/healthDatabase.dart';

class healthCondition extends StatefulWidget {
  const healthCondition({super.key, required this.childId, required this.healthId, required this.healthStatusId});
  final String childId;
  final String healthId;
  final String healthStatusId;

  @override
  State<healthCondition> createState() => _healthCondition();
}

class _healthCondition extends State<healthCondition> {

  final _formKey = GlobalKey<FormState>();

  String _currentSymptom = '';
  String _currentTemperature = '';
  String _currentHeartRate = '';
  String _currentIllness = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: const Text(
          "Edit Health Condition",
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
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                const SizedBox(
                  height: 10.0,
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.only(left: 20.0),
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
                const SizedBox(
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
                const SizedBox(
                  height: 30.0,
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Text(
                    'Current Temperature',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[500],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15.0,
                ),
                TextFormField(
                  initialValue: _currentTemperature,
                  decoration: textInputDecoration,
                  validator: (value) =>
                      value == '' ? 'Please enter current temperature' : null,
                  onChanged: (value) =>
                      setState(() => _currentTemperature = value),
                ),
                const SizedBox(
                  height: 30.0,
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Text(
                    'Current Heart Rate',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[500],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15.0,
                ),
                TextFormField(
                  initialValue: _currentTemperature,
                  decoration: textInputDecoration,
                  validator: (value) =>
                      value == '' ? 'Please enter current heart rate' : null,
                  onChanged: (value) =>
                      setState(() => _currentHeartRate = value),
                ),
                const SizedBox(
                  height: 30.0,
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.only(left: 20.0),
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
                const SizedBox(
                  height: 15.0,
                ),
                TextFormField(
                  initialValue: _currentTemperature,
                  decoration: textInputDecoration,
                  validator: (value) =>
                      value == '' ? 'Please enter current illness' : null,
                  onChanged: (value) =>
                      setState(() => _currentIllness = value),
                ),
                const SizedBox(
                  height: 20.0,
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
                    //------------Health-------------
                    String healthIdHolder =
                        DateTime.now().millisecondsSinceEpoch.toString() +
                            widget.childId;
                    String healthStatusIdHolder =
                        DateTime.now().millisecondsSinceEpoch.toString() + "1" +
                            widget.childId;
                    await HealthDatabaseService(childId: widget.childId)
                        .createHealthConditionData(
                            healthIdHolder,
                            widget.childId,
                            healthStatusIdHolder,
                            _currentSymptom,
                            _currentTemperature,
                            _currentHeartRate,
                            _currentIllness,
                            healthStatusIdHolder);
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