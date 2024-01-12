import 'package:flutter/material.dart';

class parentPrivacyPolicy extends StatefulWidget {
  const parentPrivacyPolicy({super.key});

  @override
  State<parentPrivacyPolicy> createState() => _parentPrivacyPolicyState();
}

class _parentPrivacyPolicyState extends State<parentPrivacyPolicy> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Privacy Policy",
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
                        'Privacy Policy',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 25),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                          'Welcome to UmmiCare! We are committed to protecting the privacy of children using our mobile application. This Privacy Policy outlines how we collect, use, disclose, and manage personal information collected from users of our mobile app.'),
                      SizedBox(
                        height: 30,
                      ),
                      Text(
                        '1.0 Information Collection',
                        style: TextStyle(
                            fontWeight: FontWeight.w800, fontSize: 18),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        '1.1 Personal Information',
                        style: TextStyle(fontWeight: FontWeight.w800),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                          'We may collect personal information from users, such as names, ages, and contact information, for account registration or customization purposes.'),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        '1.2 Non-Personal Information',
                        style: TextStyle(fontWeight: FontWeight.w800),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                          'We may collect non-personal information, such as device information, app usage statistics, and technical details to improve our services.'),
                      SizedBox(
                        height: 30,
                      ),
                      Text(
                        '2.0 Information Usage',
                        style: TextStyle(
                            fontWeight: FontWeight.w800, fontSize: 18),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        '2.1 Personal Information',
                        style: TextStyle(fontWeight: FontWeight.w800),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                          'Personal information is used for account management, customization, and communication with users and parents.'),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        '2.2 Non-Personal Information',
                        style: TextStyle(fontWeight: FontWeight.w800),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                          'Non-personal information is used to analyze app performance, improve user experience, and develop new features.'),
                      SizedBox(
                        height: 30,
                      ),
                      Text(
                        '3.0 Data Security',
                        style: TextStyle(
                            fontWeight: FontWeight.w800, fontSize: 18),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                          'We implement reasonable security measures to protect personal information from unauthorized access, disclosure, alteration, and destruction.'),
                      SizedBox(
                        height: 30,
                      ),
                      Text(
                        '4.0 Sharing Information',
                        style: TextStyle(
                            fontWeight: FontWeight.w800, fontSize: 18),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                          'We do not sell or share personal information of children with third parties for marketing purposes. However, we may share information with service providers for app functionality, maintenance, or improvement.'),
                      SizedBox(
                        height: 30,
                      ),
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
