import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:ummicare/services/healthDatabase.dart';
import 'package:ummicare/shared/constant.dart';
import 'package:intl/intl.dart';

class editVaccineAppointment extends StatefulWidget {
  const editVaccineAppointment({super.key, required this.selectedDay, required this.time, required this.healthId, required this.vaccinationAppointmentId});
  final DateTime? selectedDay;
  final TimeOfDay time;
  final String healthId;
  final String vaccinationAppointmentId;

  @override
  State<editVaccineAppointment> createState() => _editVaccineAppointmentState();
}

class _editVaccineAppointmentState extends State<editVaccineAppointment> {

  final _formKey = GlobalKey<FormState>();

  String _vaccineType = '';
  late TimeOfDay _selectedTime;
  DateTime _selectedDay = DateTime.now();
  String _formattedDate = '';

  @override
  void initState() {
    super.initState();
    _selectedTime = widget.time;
    _selectedDay = widget.selectedDay!;
    _formattedDate = DateFormat('dd-MM-yyyy').format(_selectedDay);
    
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: const Text(
          "Add new child appointment",
          style: TextStyle(
            color: Colors.black,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xffe1eef5),
      ),
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(left: 20.0),
                  child: Text(
                    '${_formattedDate}',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                SizedBox(
                  height: 30.0,
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(left: 20.0),
                  child: Text(
                    'Vaccine Type',
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
                  initialValue: _vaccineType,
                  decoration: textInputDecoration,
                  validator: (value) =>
                      value == '' ? 'Please enter vaccine type' : null,
                  onChanged: (value) =>
                      setState(() => _vaccineType = value),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () => _selectTime(context),
                  child: Text('Select Time'),
                ),
                SizedBox(height: 20),
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
                    String formattedMinute = _selectedTime.minute.toString().padLeft(2, '0');
                    String formattedTime = '${_selectedTime.hourOfPeriod}:$formattedMinute ${_selectedTime.period.index == 0 ? 'AM' : 'PM'}';
                    await HealthDatabaseService(childId: widget.healthId)
                        .updateVaccinationAppointmentData(
                            widget.vaccinationAppointmentId,
                            _vaccineType,
                            _formattedDate,
                            formattedTime,
                            widget.healthId,
                            '',
                            '',);
                    Navigator.pop(context);
                  }
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