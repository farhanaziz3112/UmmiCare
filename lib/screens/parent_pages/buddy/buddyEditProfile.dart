
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ummicare/models/buddyModel.dart';
import 'package:ummicare/services/buddyDatabase.dart';
import 'package:ummicare/services/storage.dart';
import 'package:ummicare/shared/constant.dart';

class buddyEditProfile extends StatefulWidget {
  const buddyEditProfile({super.key, required this.buddyProfileId});
  final String buddyProfileId;

  @override
  State<buddyEditProfile> createState() => _buddyEditProfileState();
}

class _buddyEditProfileState extends State<buddyEditProfile> {
  final _formKey = GlobalKey<FormState>();

  //form values holder
  String username = '';
  bool isPrivate = true;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<buddyProfileModel>(
        stream: buddyDatabase().buddyProfileData(widget.buddyProfileId),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            buddyProfileModel? profile = snapshot.data;
            return Scaffold(
              appBar: AppBar(
                title: Text(
                  "Edit ${profile!.buddyProfileUsername}\'s Profile",
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 15,
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
                        const Text(
                            'Set your Username, Profile Picture and Privacy Status:'),
                        const SizedBox(
                          height: 30.0,
                        ),
                        Stack(
                          clipBehavior: Clip.none,
                          children: [
                            CircleAvatar(
                              backgroundImage:
                                  NetworkImage(profile.buddyProfileImageURL),
                              radius: 50.0,
                              backgroundColor: Colors.grey,
                            ),
                            Positioned(
                              bottom: -60,
                              right: -15,
                              top: 0,
                              child: RawMaterialButton(
                                onPressed: () async {
                                  ImagePicker imagePicker = ImagePicker();
                                  XFile? file = await imagePicker.pickImage(
                                      source: ImageSource.camera);
                                  print('${file!.path}');

                                  StorageService _storageService =
                                      StorageService();
                                  _storageService.uploadBuddyProfilePic(
                                      profile, file);
                                },
                                constraints:
                                    BoxConstraints.tight(const Size(30, 30)),
                                elevation: 2.0,
                                fillColor:
                                    const Color.fromARGB(255, 216, 216, 216),
                                child:
                                    const Icon(Icons.edit, color: Colors.black),
                                padding: const EdgeInsets.all(0.0),
                                shape: const CircleBorder(),
                              ),
                            )
                          ],
                        ),
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
                          initialValue: profile.buddyProfileUsername,
                          decoration: textInputDecoration.copyWith(
                              hintText: 'Username'),
                          validator: (value) =>
                              value == '' ? 'Please enter your username' : null,
                          onChanged: (value) =>
                              setState(() => username = value),
                        ),
                        const SizedBox(
                          height: 20.0,
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
                          height: 20.0,
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xff8290F0),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5)),
                          ),
                          child: const Text(
                            'Edit Buddy profile',
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              await buddyDatabase().updateBuddyProfileData(
                                  profile.buddyProfileId,
                                  username == ""
                                      ? profile.buddyProfileUsername
                                      : username,
                                  isPrivate ? 'private' : 'public',
                                  profile.buddyProfileImageURL);
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
