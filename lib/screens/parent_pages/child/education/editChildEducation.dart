import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';

class editChildEducation extends StatefulWidget {
  const editChildEducation({super.key, required this.childId});
  final String childId;

  @override
  State<editChildEducation> createState() => _editChildEducationState();
}

class _editChildEducationState extends State<editChildEducation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Education Information",
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
      body: const Center(
        child: Text(
          'Edit child education',
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
