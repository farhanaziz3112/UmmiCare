import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';

class addNewExamResult extends StatefulWidget {
  const addNewExamResult({super.key});

  @override
  State<addNewExamResult> createState() => _addNewExamResultState();
}

class _addNewExamResultState extends State<addNewExamResult> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: const Text(
          "Add new exam result",
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
          'Add new exam result',
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