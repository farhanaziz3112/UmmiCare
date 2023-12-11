import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ummicare/models/buddymodel.dart';
import 'package:ummicare/screens/parent_pages/buddy/buddyMain.dart';
import 'package:ummicare/services/buddyDatabase.dart';
import 'package:ummicare/shared/function.dart';

import '../../../services/storage.dart';
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
  String private = '';
  bool flag = true;
  String imageURL = '';

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<BuddyModel>(
        stream: BuddyDatabaseService(userId: widget.parentId).buddyData,
        builder: (context, snapshot) {
          BuddyModel? buddy = snapshot.data;
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
                      // Stack(
                      //   clipBehavior: Clip.none,
                      //   children: [
                      //     CircleAvatar(
                      //       backgroundImage:
                      //           NetworkImage(buddy!.imageURL),
                      //       radius: 50.0,
                      //       backgroundColor: Colors.grey,
                      //     ),
                      //     Positioned(
                      //       bottom: -60,
                      //       right: -15,
                      //       top: 0,
                      //       child: RawMaterialButton(
                      //         onPressed: () async {
                      //           ImagePicker imagePicker = ImagePicker();
                      //           XFile? file = await imagePicker.pickImage(
                      //               source: ImageSource.camera);
                      //           print('${file!.path}');
          
                      //           StorageService _storageService =
                      //               StorageService();
                      //           _storageService.uploadBuddyProfilePic(
                      //               buddy, file);
                      //         },
                      //         constraints: BoxConstraints.tight(const Size(30, 30)),
                      //         elevation: 2.0,
                      //         fillColor: const Color.fromARGB(255, 216, 216, 216),
                      //         child: const Icon(Icons.edit, color: Colors.black),
                      //         padding: const EdgeInsets.all(0.0),
                      //         shape: const CircleBorder(),
                      //       ),
                      //     )
                      //   ],
                      // ),
                      const SizedBox(
                        height: 20.0,
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
                        height: 5.0,
                      ),
                      Row(
                        children: [
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
                          Text(
                            flag ? 'Private' : 'Public',
                            style: TextStyle(fontSize: 15.0),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xff8290F0)),
                        child: Text(
                          'Create Buddy profile',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            String buddyIdHolder =
                              DateTime.now().millisecondsSinceEpoch.toString() +
                                  widget.parentId;
                            if(flag){
                              private = 'Private';
                            }else{
                              private = 'Public';
                            }
                            await BuddyDatabaseService(userId: widget.parentId)
                                .createBuddyData(
                                  buddyIdHolder,
                                  username,
                                  private,
                                  imageURL,
                                  widget.parentId);
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
    );
  }
}