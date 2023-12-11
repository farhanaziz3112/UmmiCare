import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:ummicare/services/healthDatabase.dart';
import 'package:ummicare/shared/constant.dart';

class addNewHealthStatusData extends StatefulWidget {
  const addNewHealthStatusData({super.key, required this.healthStatusId});
  final String healthStatusId;

  @override
  State<addNewHealthStatusData> createState() => _addNewHealthStatusDataState();
}

class _addNewHealthStatusDataState extends State<addNewHealthStatusData> {

  final _formKey = GlobalKey<FormState>();

  String _currentTemperature = '';
  String _currentHeartRate = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: Text(
          "Add New Health Status Data",
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
                    'Current Temperature',
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
                  initialValue: _currentTemperature,
                  decoration: textInputDecoration,
                  validator: (value) =>
                      value == '' ? 'Please enter current temperature' : null,
                  onChanged: (value) =>
                      setState(() => _currentTemperature = value),
                ),
                SizedBox(
                  height: 30.0,
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(left: 20.0),
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
                SizedBox(
                  height: 30.0,
                ),
                TextFormField(
                  initialValue: _currentHeartRate,
                  decoration: textInputDecoration,
                  validator: (value) =>
                      value == '' ? 'Please enter current heart rate' : null,
                  onChanged: (value) =>
                      setState(() => _currentHeartRate = value),
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
                    String healthConditionIdHolder =
                        DateTime.now().millisecondsSinceEpoch.toString() +
                            widget.healthStatusId;
                    String physicalConditionIdHolder =
                        DateTime.now().millisecondsSinceEpoch.toString() + "1" +
                            widget.healthStatusId;
                    String chronicConditionIdHolder =
                        DateTime.now().millisecondsSinceEpoch.toString() + "2" +
                            widget.healthStatusId;
                    await HealthDatabaseService(childId: widget.healthStatusId)
                        .createHealthStatusData(
                            widget.healthStatusId,
                            _currentTemperature,
                            _currentHeartRate,
                            healthConditionIdHolder,
                            physicalConditionIdHolder,
                            chronicConditionIdHolder,);   
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