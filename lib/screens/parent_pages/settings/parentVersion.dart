import 'package:flutter/material.dart';

class parentVersion extends StatefulWidget {
  const parentVersion({super.key});

  @override
  State<parentVersion> createState() => _parentVersionState();
}

class _parentVersionState extends State<parentVersion> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Version",
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        elevation: 3,
      ),
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: SingleChildScrollView(
          child: Container(
            padding:
                const EdgeInsets.symmetric(vertical: 30.0, horizontal: 20.0),
            child: Column(
              children: <Widget>[
                Container(
                  alignment: Alignment.topLeft,
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(),
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 5,
                        offset:
                            const Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Version 1.0.0',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                          'The first version of the app is out! Our first launch comes with web application (Staff User) and mobile application (Parent User). Multiple modules such as Health module and Education module will be available.')
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
