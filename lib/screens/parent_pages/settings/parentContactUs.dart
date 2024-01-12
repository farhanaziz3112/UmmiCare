import 'package:flutter/material.dart';

class parentContactUs extends StatefulWidget {
  const parentContactUs({super.key});

  @override
  State<parentContactUs> createState() => _parentContactUsState();
}

class _parentContactUsState extends State<parentContactUs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Contact Us",
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
                        'Contact Us',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 25),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                          'For any questions, concerns, or support related to UmmiCare, please feel free to reach out to us using the following contact methods:'),
                      SizedBox(
                        height: 30,
                      ),
                      Row(
                        children: <Widget>[
                          Icon(Icons.email),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Email',
                            style: TextStyle(
                                fontWeight: FontWeight.w800, fontSize: 18),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        'farhanaziz3112@gmail.com',
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text('maizat13501@gmail.com'),
                      SizedBox(
                        height: 30,
                      ),
                      Row(
                        children: <Widget>[
                          Icon(Icons.phone),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Customer Support Phone',
                            style: TextStyle(
                                fontWeight: FontWeight.w800, fontSize: 18),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        '018-2026040',
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text('013-5223880'),
                      SizedBox(
                        height: 30,
                      ),
                      Row(
                        children: <Widget>[
                          Icon(Icons.location_on),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Mailing Address',
                            style: TextStyle(
                                fontWeight: FontWeight.w800, fontSize: 18),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                          'Universiti Malaya, 50603 Kuala Lumpur, Wilayah Persekutuan Kuala Lumpur'),
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
