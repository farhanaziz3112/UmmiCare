import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';

class addNewChildStory extends StatefulWidget {
  const addNewChildStory({super.key});

  @override
  State<addNewChildStory> createState() => _addNewChildStoryState();
}

class _addNewChildStoryState extends State<addNewChildStory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: const Text(
          "Add New Child Story",
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
          'Add New Child Story',
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