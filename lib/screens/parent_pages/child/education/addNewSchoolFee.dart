import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';

class addNewSchoolFee extends StatefulWidget {
  const addNewSchoolFee({super.key});

  @override
  State<addNewSchoolFee> createState() => _addNewSchoolFeeState();
}

class _addNewSchoolFeeState extends State<addNewSchoolFee> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: const Text(
          "Add new school fee",
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
          'Add new school fee',
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