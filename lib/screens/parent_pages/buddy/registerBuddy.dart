import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:ummicare/models/parentModel.dart';
import 'package:ummicare/services/activityDatabase.dart';
import 'package:ummicare/services/buddyDatabase.dart';
import 'package:ummicare/services/parentDatabase.dart';

import '../../../shared/constant.dart';

class registerBuddy extends StatefulWidget {
  const registerBuddy({super.key, required this.parentId});
  final String parentId;

  @override
  State<registerBuddy> createState() => _registerBuddyState();
}

class _registerBuddyState extends State<registerBuddy> {
  final _formKey = GlobalKey<FormState>();

  //form values holder
  String username = '';
  bool isPrivate = true;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<parentModel>(
        stream: parentDatabase(parentId: widget.parentId).parentData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            parentModel? parent = snapshot.data;
            return Scaffold(
              appBar: AppBar(
                title: const Text(
                  "Register Buddy",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                centerTitle: true,
                elevation: 3,
                backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                iconTheme: const IconThemeData(color: Colors.black),
              ),
              resizeToAvoidBottomInset: false,
              body: SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      vertical: 30.0, horizontal: 20.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        const Text('Set your Username and Privacy Status:'),
                        const SizedBox(
                          height: 20.0,
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.only(left: 20.0),
                          child: Text(
                            'Username',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[500],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 5.0,
                        ),
                        TextFormField(
                          initialValue: username,
                          decoration: textInputDecoration.copyWith(
                              hintText: 'Username'),
                          validator: (value) =>
                              value == '' ? 'Please enter your username' : null,
                          onChanged: (value) =>
                              setState(() => username = value),
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.only(left: 20.0),
                          child: Text(
                            'Privacy Status',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[500],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Public',
                              style: TextStyle(fontSize: 15.0),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Switch(
                              // thumb color (round icon)
                              activeColor: Colors.white,
                              activeTrackColor: const Color(0xff8290F0),
                              inactiveThumbColor: Colors.white,
                              inactiveTrackColor: const Color(0xff8290F0),
                              splashRadius: 50.0,
                              // boolean variable value
                              value: isPrivate,
                              // changes the state of the switch
                              onChanged: (value) =>
                                  setState(() => isPrivate = value),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            const Text(
                              'Private',
                              style: TextStyle(fontSize: 15.0),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 25.0,
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xff8290F0),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5)),
                          ),
                          child: const Text(
                            'Create Buddy profile',
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              await buddyDatabase().createBuddyProfileData(
                                  parent!.parentId,
                                  username,
                                  isPrivate ? 'private' : 'public',
                                  parent.parentProfileImg);
                              activityDatabase().createactivityData(
                                  parent.parentId,
                                  '',
                                  'Welcome to the Buddy!',
                                  'Feel free to reach out to our parents communities!',
                                  'buddy',
                                  DateTime.now()
                                      .millisecondsSinceEpoch
                                      .toString());
                              Navigator.pop(context);
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          } else {
            return Container();
          }
        });
  }
}
