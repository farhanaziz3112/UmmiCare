import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';

class childStory extends StatefulWidget {
  const childStory({super.key});

  @override
  State<childStory> createState() => _childStoryState();
}

class _childStoryState extends State<childStory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: const Text(
          "Child Story",
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
          'Child Story',
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
