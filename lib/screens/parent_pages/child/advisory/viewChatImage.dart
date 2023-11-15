import 'package:flutter/material.dart';

class viewChatImage extends StatelessWidget {
  const viewChatImage({super.key, required this.imageLink});
  final String imageLink;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Image',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: Center(child: Image.network(imageLink)),
    );
  }
}