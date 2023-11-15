import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';

class advisoryMain extends StatelessWidget {
  const advisoryMain({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: const Text(
          "Advisory",
          style: TextStyle(
            color: Colors.black,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xffe1eef5),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            TextButton(
              style: TextButton.styleFrom(primary: Colors.blue),
              onPressed: () {
                Navigator.of(context).pushNamed('/parent/child/advisory/advisorprofile');
              },
              child: Text('Advisor profile'),
            ),
            TextButton(
              style: TextButton.styleFrom(primary: Colors.blue),
              onPressed: () {
                Navigator.of(context).pushNamed('/parent/child/advisory/chatting');
              },
              child: Text('Chatting page'),
            ),
          ],
        ),
      ),
    );
  }
}