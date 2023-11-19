import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';

class editChildHealth extends StatefulWidget {
  const editChildHealth({super.key});

  @override
  State<editChildHealth> createState() => _editChildHealthState();
}

class _editChildHealthState extends State<editChildHealth> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: const Text(
          "Edit child health",
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
          'Edit child health',
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