import 'package:flutter/material.dart';
import 'package:ummicare/services/healthDatabase.dart';
import 'package:ummicare/shared/constant.dart';
import 'package:ummicare/models/healthmodel.dart';
import 'package:ummicare/shared/loading.dart';

class EditPhysical extends StatefulWidget {
  const EditPhysical({super.key, required this.childId, required this.healthId,required this.healthStatusId});
  final String childId;
  final String healthId;
  final String healthStatusId;

  @override
  State<EditPhysical> createState() => _EditPhysicalState();
}

class _EditPhysicalState extends State<EditPhysical> {

  final _formKey = GlobalKey<FormState>();

  String _currentPhysical = '';
  String _healthStatusId ='';
  String _currentWeight = '';

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<HealthModel>>(
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
                  initialValue: _currentPhysical,
                  decoration: textInputDecoration,
                  validator: (value) =>
                      value == '' ? 'Please enter current Physical' : null,
                  onChanged: (value) =>
                      setState(() => _currentPhysical = value),
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
                  'Update',
                  style: TextStyle(color: Colors.black),
                ),
                onPressed: () async {
                  if (_formKey.currentState!.validate()){
                    await HealthDatabaseService(childId: widget.childId)
                      .updateHealthData(
                            widget.healthId,
                            widget.childId,
                            widget.healthStatusId,
                            _currentPhysical,
                            _currentWeight,);
                    Navigator.pop(context);
                  }
                  
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