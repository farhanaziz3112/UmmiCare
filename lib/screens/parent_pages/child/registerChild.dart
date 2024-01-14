import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ummicare/models/parentModel.dart';
import 'package:ummicare/services/activityDatabase.dart';
import 'package:ummicare/services/parentDatabase.dart';
import 'package:ummicare/services/storage.dart';
import 'package:ummicare/shared/function.dart';
import '../../../shared/constant.dart';

class registerChild extends StatefulWidget {
  const registerChild({super.key, required this.parentId});
  final String parentId;

  @override
  State<registerChild> createState() => _registerChildState();
}

class _registerChildState extends State<registerChild> {
  final _formKey = GlobalKey<FormState>();

  //form values holder
  String parentId = '';
  String childName = '';
  String childFirstname = '';
  String childLastname = '';
  DateTime childBirthday = DateTime.now();
  String childProfileImg = '';

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
                  "Register Child",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                centerTitle: true,
                backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                iconTheme: const IconThemeData(color: Colors.black),
                elevation: 3,
              ),
              resizeToAvoidBottomInset: false,
              body: Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: SingleChildScrollView(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 30.0, horizontal: 20.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: <Widget>[
                          const Text(
                            'Insert your child details',
                            style: TextStyle(fontSize: 20.0),
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          Stack(
                            clipBehavior: Clip.none,
                            children: [
                              CircleAvatar(
                                backgroundImage: NetworkImage(childProfileImg),
                                radius: 50.0,
                                backgroundColor: Colors.grey,
                              ),
                              Positioned(
                                bottom: -60,
                                right: -15,
                                top: 0,
                                child: RawMaterialButton(
                                  onPressed: () async {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            scrollable: true,
                                            title: const Padding(
                                              padding: EdgeInsets.all(10.0),
                                              child: Text('Upload Photo'),
                                            ),
                                            content: const Text(
                                                'Please choose your method to upload photo:'),
                                            actions: [
                                              ElevatedButton.icon(
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor:
                                                      const Color(0xff8290F0),
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5)),
                                                ),
                                                onPressed: () async {
                                                  ImagePicker imagePicker =
                                                      ImagePicker();
                                                  XFile? file =
                                                      await imagePicker
                                                          .pickImage(
                                                              source:
                                                                  ImageSource
                                                                      .camera);
                                                  print('${file!.path}');

                                                  StorageService
                                                      _storageService =
                                                      StorageService();
                                                  _storageService
                                                      .uploadChildProfilePicFirstTime(
                                                          file)
                                                      .then((value) {
                                                    setState(() {
                                                      childProfileImg = value;
                                                    });
                                                  });
                                                  Navigator.of(context).pop();
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                          const SnackBar(
                                                    content: Text(
                                                        'New photo successfully submitted!'),
                                                  ));
                                                },
                                                icon: const Icon(
                                                  Icons.camera_alt,
                                                  color: Colors.white,
                                                ),
                                                label: const Text("Camera",
                                                    style: TextStyle(
                                                        color: Colors.white)),
                                              ),
                                              ElevatedButton.icon(
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor:
                                                      const Color(0xff8290F0),
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5)),
                                                ),
                                                onPressed: () async {
                                                  ImagePicker imagePicker =
                                                      ImagePicker();
                                                  XFile? file =
                                                      await imagePicker
                                                          .pickImage(
                                                              source:
                                                                  ImageSource
                                                                      .gallery);
                                                  print('${file!.path}');

                                                  StorageService
                                                      _storageService =
                                                      StorageService();
                                                  _storageService
                                                      .uploadChildProfilePicFirstTime(
                                                          file)
                                                      .then((value) {
                                                    setState(() {
                                                      childProfileImg = value;
                                                    });
                                                  });
                                                  Navigator.of(context).pop();

                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                          const SnackBar(
                                                    content: Text(
                                                        'New photo successfully submitted!'),
                                                  ));
                                                },
                                                icon: const Icon(
                                                  Icons.photo_library,
                                                  color: Colors.white,
                                                ),
                                                label: const Text("Gallery",
                                                    style: TextStyle(
                                                        color: Colors.white)),
                                              ),
                                            ],
                                          );
                                        });
                                  },
                                  constraints:
                                      BoxConstraints.tight(const Size(30, 30)),
                                  elevation: 2.0,
                                  fillColor:
                                      const Color.fromARGB(255, 216, 216, 216),
                                  child: const Icon(Icons.edit,
                                      color: Colors.black),
                                  padding: const EdgeInsets.all(0.0),
                                  shape: const CircleBorder(),
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 30.0,
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
                            initialValue: childName,
                            decoration: textInputDecoration.copyWith(
                                hintText: 'Child name'),
                            validator: (value) => value == ''
                                ? 'Please enter your child name'
                                : null,
                            onChanged: (value) =>
                                setState(() => childName = value),
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            padding: const EdgeInsets.only(left: 20.0),
                            child: Text(
                              'First Name',
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
                            initialValue: childFirstname,
                            decoration: textInputDecoration.copyWith(
                                hintText: 'Child first name'),
                            validator: (value) => value == ''
                                ? 'Please enter your child first name'
                                : null,
                            onChanged: (value) =>
                                setState(() => childFirstname = value),
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            padding: const EdgeInsets.only(left: 20.0),
                            child: Text(
                              'Last Name',
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
                            initialValue: childLastname,
                            decoration: textInputDecoration.copyWith(
                                hintText: 'Child last name'),
                            validator: (value) => value == ''
                                ? 'Please enter your child last name'
                                : null,
                            onChanged: (value) =>
                                setState(() => childLastname = value),
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            padding: const EdgeInsets.only(left: 20.0),
                            child: Text(
                              'Birthday',
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
                          Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 0.0, horizontal: 20.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Text(
                                  childBirthday.day.toString(),
                                  style: const TextStyle(fontSize: 20.0),
                                ),
                                const Text(' / '),
                                Text(
                                  childBirthday.month.toString(),
                                  style: const TextStyle(fontSize: 20.0),
                                ),
                                const Text(' / '),
                                Text(
                                  childBirthday.year.toString(),
                                  style: const TextStyle(fontSize: 20.0),
                                ),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color.fromARGB(
                                        255, 255, 255, 255),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5),
                                        side: const BorderSide(
                                            width: 1, color: Colors.black)),
                                  ),
                                  onPressed: () {
                                    showDatePicker(
                                      context: context,
                                      initialDate: childBirthday,
                                      firstDate: DateTime(1995),
                                      lastDate: DateTime.now(),
                                    ).then((date) {
                                      setState(() {
                                        childBirthday = date!;
                                      });
                                    });
                                  },
                                  child: const Text(
                                    'Set Birthday',
                                    style: TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                                )
                              ],
                            ),
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
                              'Create child profile',
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                String createdDate = DateTime.now()
                                    .millisecondsSinceEpoch
                                    .toString();

                                final CollectionReference childCollection =
                                    FirebaseFirestore.instance
                                        .collection('Child');

                                final CollectionReference parentCollection =
                                    FirebaseFirestore.instance
                                        .collection('Parent');

                                final document = childCollection.doc();

                                await childCollection.doc(document.id).set({
                                  'childId': document.id,
                                  'parentId': parent!.parentId,
                                  'childCreatedDate': createdDate,
                                  'childName': childName,
                                  'childFirstname': childFirstname,
                                  'childLastname': childLastname,
                                  'childBirthday': childBirthday
                                      .millisecondsSinceEpoch
                                      .toString(),
                                  'childCurrentAge': getAge(childBirthday
                                      .millisecondsSinceEpoch
                                      .toString()),
                                  'childAgeCategory': getAgeCategory(getAge(
                                      childBirthday.millisecondsSinceEpoch
                                          .toString())),
                                  'childProfileImg': childProfileImg,
                                  'educationId': '',
                                  'healthId': '',
                                  'overallStatus': 'normal'
                                });

                                await parentCollection
                                    .doc(parent.parentId)
                                    .collection('Child')
                                    .doc(document.id)
                                    .set({
                                  'childId': document.id,
                                });

                                await parentDatabase(parentId: parent.parentId)
                                    .updateParentData(
                                        parent.parentId,
                                        parent.parentCreatedDate,
                                        parent.parentFullName,
                                        parent.parentFirstName,
                                        parent.parentLastName,
                                        parent.parentEmail,
                                        parent.parentPhoneNumber,
                                        parent.parentProfileImg,
                                        parent.advisorId,
                                        (int.parse(parent.noOfChild) + 1)
                                            .toString());

                                await activityDatabase().createactivityData(
                                    parent.parentId,
                                    document.id,
                                    'Welcome to the UmmiCare family!',
                                    '${childFirstname} has been registered into UmmiCare family!',
                                    'child',
                                    createdDate);

                                Navigator.pop(context);
                              }
                            },
                          ),
                        ],
                      ),
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
