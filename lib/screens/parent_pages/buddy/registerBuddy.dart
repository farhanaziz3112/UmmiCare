import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ummicare/services/buddydatabase.dart';
import 'package:ummicare/shared/function.dart';

import '../../../services/storage.dart';
import '../../../shared/constant.dart';

class registerBuddy extends StatefulWidget {
  const registerBuddy({super.key, required this.currentuserId});
  final String currentuserId;

  @override
  State<registerBuddy> createState() => _registerBuddyState();
}

class _registerBuddyState extends State<registerBuddy> {
  final _formKey = GlobalKey<FormState>();

  //form values holder
  String username = '';
  String private = '';
  bool flag = true;
  String imageURL = '';

  @override
  Widget build(BuildContext context) {
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
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        iconTheme: IconThemeData(color: Colors.black),
      ),
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 30.0, horizontal: 20.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                Text(
                  'Insert your buddy details',
                  style: TextStyle(fontSize: 20.0),
                ),
                SizedBox(
                  height: 30.0,
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(left: 20.0),
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
                SizedBox(
                  height: 5.0,
                ),
                TextFormField(
                  initialValue: username,
                  decoration:
                      textInputDecoration.copyWith(hintText: 'Username'),
                  validator: (value) =>
                      value == '' ? 'Please enter your child name' : null,
                  onChanged: (value) => setState(() => username = value),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(left: 20.0),
                  child: Text(
                    'Private',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[500],
                    ),
                  ),
                ),
                SizedBox(
                  height: 5.0,
                ),
                Switch(
                  // thumb color (round icon)
                  activeColor: Colors.amber,
                  activeTrackColor: Colors.cyan,
                  inactiveThumbColor: Colors.blueGrey.shade600,
                  inactiveTrackColor: Colors.grey.shade400,
                  splashRadius: 50.0,
                  // boolean variable value
                  value: flag,
                  // changes the state of the switch
                  onChanged: (value) => setState(() => flag = value),
                ),
                SizedBox(
                  height: 20.0,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xff8290F0)),
                  child: Text(
                    'Create child profile',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      String buddyIdHolder =
                        DateTime.now().millisecondsSinceEpoch.toString() +
                            widget.currentuserId;
                      if(flag){
                        private = 'Private';
                      }else{
                        private = 'Public';
                      }
                      await BuddyDatabaseService(userId: widget.currentuserId)
                          .createChildData(
                            buddyIdHolder,
                            username,
                            private,
                            imageURL,
                            widget.currentuserId);
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
  }
}