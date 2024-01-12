import 'package:flutter/material.dart';

class parentTermsOfUse extends StatefulWidget {
  const parentTermsOfUse({super.key});

  @override
  State<parentTermsOfUse> createState() => _parentTermsOfUseState();
}

class _parentTermsOfUseState extends State<parentTermsOfUse> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Terms of Use",
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
                        'Last Updated: 7 January 2024',
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Terms of Use',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 25),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                          'Welcome to UmmiCare! These Terms of Use govern your use of UmmiCare App. By accessing or using the App, you agree to be bound by these Terms.'),
                      SizedBox(
                        height: 30,
                      ),
                      Text(
                        '1.0 User Agreement',
                        style: TextStyle(
                            fontWeight: FontWeight.w800, fontSize: 18),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        '1.1 Acceptance',
                        style: TextStyle(fontWeight: FontWeight.w800),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                          'By using the App, you agree to comply with these Terms. If you do not agree, please refrain from using the App.'),
                      SizedBox(
                        height: 30,
                      ),
                      Text(
                        '2.0 Use of the App',
                        style: TextStyle(
                            fontWeight: FontWeight.w800, fontSize: 18),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        '2.1 Age Restriction',
                        style: TextStyle(fontWeight: FontWeight.w800),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                          'The App is intended for use by parents, with range of individuals age of above 18 years old. Users under this age must have parental supervision.'),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        '2.2 User Conduct',
                        style: TextStyle(fontWeight: FontWeight.w800),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                          'Users are prohibited from engaging in any unlawful, harmful, or disruptive activities while using the App. Any violation may result in the termination of access.'),
                      SizedBox(
                        height: 30,
                      ),
                      Text(
                        '3.0 Privacy',
                        style: TextStyle(
                            fontWeight: FontWeight.w800, fontSize: 18),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                          'Our Privacy Policy governs the collection, use, and protection of user information. By using the App, you consent to the practices outlined in our Privacy Policy.'),
                      SizedBox(
                        height: 30,
                      )
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
