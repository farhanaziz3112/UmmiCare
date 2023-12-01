import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:ummicare/shared/constant.dart';
import 'package:ummicare/services/healthDatabase.dart';

class physicalCondition extends StatefulWidget {
  const physicalCondition({super.key, required this.childId, required this.healthId, required this.healthStatusId});
  final String childId;
  final String healthId;
  final String healthStatusId;

  @override
  State<physicalCondition> createState() => _physicalCondition();
}

class _physicalCondition extends State<physicalCondition> {

  final _formKey = GlobalKey<FormState>();

  String _currentInjury = '';
  String details= '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: const Text(
          "Edit Physical Condition",
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
                    'Injury',
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
                  initialValue: _currentInjury,
                  decoration: textInputDecoration,
                  validator: (value) =>
                      value == '' ? 'Please enter current injury' : null,
                  onChanged: (value) =>
                      setState(() => _currentInjury = value),
                ),
                const SizedBox(
                  height: 30.0,
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Text(
                    'Details',
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
                  initialValue: details,
                  decoration: textInputDecoration,
                  validator: (value) =>
                      value == '' ? 'Please enter details' : null,
                  onChanged: (value) =>
                      setState(() => details= value),
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
                    //------------Health-------------
                    String healthIdHolder =
                        DateTime.now().millisecondsSinceEpoch.toString() +
                            widget.childId;
                    String healthStatusIdHolder =
                        DateTime.now().millisecondsSinceEpoch.toString() + "1" +
                            widget.childId;
                    await HealthDatabaseService(childId: widget.childId)
                        .createPhysicalConditionData(
                            healthIdHolder,
                            widget.childId,
                            healthStatusIdHolder,
                            _currentInjury,
                            details,
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