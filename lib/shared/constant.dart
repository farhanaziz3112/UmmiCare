import 'package:flutter/material.dart';

const textInputDecoration = InputDecoration(
  fillColor: Colors.white,
  filled: true,
  contentPadding: EdgeInsets.all(12.0),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(width: 1, color: Colors.grey),
    borderRadius: const BorderRadius.all(
      const Radius.circular(30.0),
    ),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(width: 1, color: Colors.black),
    borderRadius: const BorderRadius.all(
      const Radius.circular(15.0),
    ),
  ),
  // enabledBorder: OutlineInputBorder(
  //     borderSide: BorderSide(color: Colors.white, width: 2.0),
  //   ),
  // focusedBorder: OutlineInputBorder(
  //     borderSide: BorderSide(color: Color.fromARGB(255, 88, 87, 87), width: 2.0)),
);

Widget noData(String inLineText) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Container(
          height: 80,
          width: 80,
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/background/nodatabg.png"),
                fit: BoxFit.cover),
          ),
          child: Container()),
      const SizedBox(
        height: 10,
      ),
      Text(
        inLineText,
        style: TextStyle(color: Colors.grey[700]),
      ),
    ],
  );
}
