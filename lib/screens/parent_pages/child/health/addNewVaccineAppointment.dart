import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';

class addNewVaccineAppointment extends StatefulWidget {
  const addNewVaccineAppointment({super.key});

  @override
  State<addNewVaccineAppointment> createState() => _addNewVaccineAppointmentState();
}

class _addNewVaccineAppointmentState extends State<addNewVaccineAppointment> {
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
      body: const Center(
        child: Text(
          'Add new vaccine appointment',
          style: TextStyle(
          color: Colors.black,
          fontSize: 40,
          fontWeight: FontWeight.bold,
        ),
        ),
      ),
    );
  }
}