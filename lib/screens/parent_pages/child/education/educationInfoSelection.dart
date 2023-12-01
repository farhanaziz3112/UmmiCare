import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

class educationInfoSelection extends StatefulWidget {
  const educationInfoSelection({super.key, required this.childId});
  final String childId;

  @override
  State<educationInfoSelection> createState() => _educationInfoSelectionState();
}

class _educationInfoSelectionState extends State<educationInfoSelection> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Education Information",
            style: TextStyle(
              color: Colors.black,
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          iconTheme: const IconThemeData(color: Colors.black),
          centerTitle: true,
          backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 30.0),
            alignment: Alignment.center,
            child: Column(
              children: <Widget>[
                Container(
                  width: double.infinity,
                  alignment: Alignment.centerLeft,
                  decoration: const BoxDecoration(
                      color: Color(0xff71CBCA),
                      borderRadius: BorderRadius.all(Radius.circular(10.0))),
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(10.0, 10.0, 0.0, 10.0),
                    child: Row(
                      children: <Widget>[
                        const Icon(
                          Icons.school,
                          size: 30.0,
                          color: Colors.black,
                        ),
                        const Text(
                          ' Current School Information',
                          style: TextStyle(fontSize: 17.0, color: Colors.black),
                        ),
                        Flexible(
                          child: Container(
                            alignment: Alignment.centerRight,
                            child: IconButton(
                              icon: Transform.scale(
                                scaleX: -1,
                                child: const Icon(
                                  Icons.arrow_back,
                                  size: 25.0,
                                  color: Colors.white,
                                ),
                              ),
                              onPressed: () {},
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15.0,
                ),
                Container(
                  width: double.infinity,
                  alignment: Alignment.centerLeft,
                  decoration: const BoxDecoration(
                      color: Color(0xffF29180),
                      borderRadius: BorderRadius.all(Radius.circular(10.0))),
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(10.0, 10.0, 0.0, 10.0),
                    child: Row(
                      children: <Widget>[
                        const Icon(
                          Icons.calendar_month,
                          size: 30.0,
                          color: Colors.black,
                        ),
                        const Text(
                          ' Update Study Calendar',
                          style: TextStyle(fontSize: 17.0, color: Colors.black),
                        ),
                        Flexible(
                          child: Container(
                            alignment: Alignment.centerRight,
                            child: IconButton(
                              icon: Transform.scale(
                                scaleX: -1,
                                child: const Icon(
                                  Icons.arrow_back,
                                  size: 25.0,
                                  color: Colors.white,
                                ),
                              ),
                              onPressed: () {},
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15.0,
                ),
                Container(
                  width: double.infinity,
                  alignment: Alignment.centerLeft,
                  decoration: const BoxDecoration(
                      color: Color(0xff8290F0),
                      borderRadius: BorderRadius.all(Radius.circular(10.0))),
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(10.0, 10.0, 0.0, 10.0),
                    child: Row(
                      children: <Widget>[
                        const Icon(
                          Icons.list,
                          size: 30.0,
                          color: Colors.black,
                        ),
                        const Text(
                          ' View Previous Education Record',
                          style: TextStyle(fontSize: 17.0, color: Colors.black),
                        ),
                        Flexible(
                          child: Container(
                            alignment: Alignment.centerRight,
                            child: IconButton(
                              icon: Transform.scale(
                                scaleX: -1,
                                child: const Icon(
                                  Icons.arrow_back,
                                  size: 25.0,
                                  color: Colors.white,
                                ),
                              ),
                              onPressed: () {},
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
