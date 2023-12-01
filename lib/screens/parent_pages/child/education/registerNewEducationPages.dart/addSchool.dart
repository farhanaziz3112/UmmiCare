import 'package:flutter/material.dart';
import 'package:ummicare/models/childModel.dart';
import 'package:ummicare/models/schoolModel.dart';
import 'package:ummicare/screens/parent_pages/child/education/registerNewEducationPages.dart/schoolList.dart';
import 'package:ummicare/services/childDatabase.dart';
import 'package:ummicare/services/schoolDatabase.dart';
import 'package:ummicare/shared/constant.dart';

class addSchool extends StatefulWidget {
  const addSchool({super.key, required this.childId});
  final String childId;

  @override
  State<addSchool> createState() => _addSchoolState();
}

class _addSchoolState extends State<addSchool> {
  final _formKey = GlobalKey<FormState>();

  String searchName = '';
  List<schoolModel> schoolDetails = [];

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<childModel>(
        stream: childDatabase(childId: widget.childId).childData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            childModel? child = snapshot.data;
            return Scaffold(
              appBar: AppBar(
                title: const Text(
                  'Add New School',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                elevation: 3,
                iconTheme: const IconThemeData(color: Colors.black),
                centerTitle: true,
                backgroundColor: const Color.fromARGB(255, 255, 255, 255),
              ),
              body: SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 30.0, vertical: 30.0),
                  alignment: Alignment.center,
                  child: Column(
                    children: <Widget>[
                      const Text(
                        'Search for school and click to register:',
                        style: TextStyle(fontSize: 17),
                      ),
                      const SizedBox(height: 30),
                      StreamBuilder<List<schoolModel>>(
                          stream: schoolDatabase().allSchoolData,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              List<schoolModel>? schools = snapshot.data;
                              return Form(
                                key: _formKey,
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: TextFormField(
                                        initialValue: searchName,
                                        decoration: textInputDecoration
                                            .copyWith(hintText: 'School Name'),
                                        validator: (value) => value == ''
                                            ? 'Please enter school name'
                                            : null,
                                        onChanged: ((value) => setState(() {
                                              searchName = value;
                                            })),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    IconButton(
                                      icon: const Icon(
                                        Icons.search,
                                        size: 30,
                                        color: Colors.white,
                                      ),
                                      style: IconButton.styleFrom(
                                          backgroundColor:
                                              const Color(0xffF29180)),
                                      onPressed: () async {
                                        schoolDetails.clear();
                                        for (int i = 0;
                                            i < schools!.length;
                                            i++) {
                                          if (schools[i]
                                              .schoolName
                                              .toLowerCase()
                                              .contains(
                                                  searchName.toLowerCase())) {
                                            setState(() {
                                              schoolDetails.add(schools[i]);
                                            });
                                          }
                                        }
                                      },
                                    ),
                                  ],
                                ),
                              );
                            } else {
                              return Container();
                            }
                          }),
                      const SizedBox(height: 30),
                      schoolList(schoolDetails: schoolDetails, childId: child!.childId,),
                    ],
                  ),
                ),
              ),
            );
          } else {
            return Scaffold(
                appBar: AppBar(
                  title: const Text(
                    '',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  elevation: 3,
                  iconTheme: const IconThemeData(color: Colors.black),
                  centerTitle: true,
                  backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                ),
                body: Container());
          }
        });
  }
}
