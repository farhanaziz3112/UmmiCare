import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ummicare/models/childModel.dart';
import 'package:ummicare/services/childDatabase.dart';

import '../../../../services/storage.dart';
import '../../../../shared/constant.dart';

class editChildProfile extends StatefulWidget {
  const editChildProfile({super.key, required this.child});
  final childModel child;

  @override
  State<editChildProfile> createState() => _editChildProfileState();
}

class _editChildProfileState extends State<editChildProfile> {
  final _formKey = GlobalKey<FormState>();

  //form values holder
  String _currentChildName = "";
  String _currentChildFirstName = "";
  String _currentChildLastName = "";

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<childModel>(
        stream: childDatabase(childId: widget.child.childId).childData,
        builder: (context, snapshot) {
          childModel? child = snapshot.data;
          return Scaffold(
            appBar: AppBar(
              title: const Text(
                'Edit Child Profile',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              elevation: 3,
              centerTitle: true,
              iconTheme: const IconThemeData(color: Colors.black),
              backgroundColor: const Color.fromARGB(255, 255, 255, 255),
            ),
            resizeToAvoidBottomInset: false,
            body: Padding(
              padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
              child: SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        Stack(
                          clipBehavior: Clip.none,
                          children: [
                            CircleAvatar(
                              backgroundImage:
                                  NetworkImage(child!.childProfileImg),
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
                                  _storageService.uploadChildProfilePic(
                                      child, file);
                                },
                                constraints: BoxConstraints.tight(const Size(30, 30)),
                                elevation: 2.0,
                                fillColor: const Color.fromARGB(255, 216, 216, 216),
                                child: const Icon(Icons.edit, color: Colors.black),
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
                                color: Colors.grey[500]),
                          ),
                        ),
                        const SizedBox(
                          height: 5.0,
                        ),
                        TextFormField(
                          initialValue: _currentChildName == ''
                              ? child.childName
                              : _currentChildName,
                          decoration: textInputDecoration,
                          validator: (value) => value == ''
                              ? 'Please enter your child\'s username'
                              : null,
                          onChanged: (value) =>
                              setState(() => _currentChildName = value),
                        ),
                        const SizedBox(
                          height: 10.0,
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
                          initialValue: _currentChildFirstName == ''
                              ? child.childFirstname
                              : _currentChildFirstName,
                          decoration: textInputDecoration,
                          validator: (value) =>
                              value == '' ? 'Please enter your first name' : null,
                          onChanged: (value) =>
                              setState(() => _currentChildFirstName = value),
                        ),
                        const SizedBox(
                          height: 10.0,
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
                          initialValue: _currentChildLastName == ''
                              ? child.childLastname
                              : _currentChildLastName,
                          decoration: textInputDecoration,
                          validator: (value) =>
                              value == '' ? 'Please enter your first name' : null,
                          onChanged: (value) =>
                              setState(() => _currentChildLastName = value),
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xff8290F0),
                              shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)
                            ),
                          ),
                          child: const Text(
                            'Update Child Details',
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              await childDatabase(childId: widget.child.childId)
                                  .updateChildData(
                                      child.childId,
                                      child.parentId,
                                      child.childCreatedDate,
                                      _currentChildName == ''
                                          ? child.childName
                                          : _currentChildName,
                                      _currentChildFirstName == ''
                                          ? child.childFirstname
                                          : _currentChildFirstName,
                                      _currentChildLastName == ''
                                          ? child.childLastname
                                          : _currentChildLastName,
                                      child.childBirthday,
                                      child.childCurrentAge,
                                      child.childAgeCategory,
                                      child.childProfileImg,
                                      child.educationId,
                                      child.healthId,
                                      child.overallStatus);
                              Navigator.pop(context);
                            }
                          },
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }
}
