import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:ummicare/models/childModel.dart';
import 'package:ummicare/models/educationmodel.dart';
import 'package:ummicare/models/healthmodel.dart';
import 'package:ummicare/screens/parent_pages/child/childprofile/editChildProfile.dart';
import 'package:ummicare/screens/parent_pages/child/education/addNewEduCalendar.dart';
import 'package:ummicare/screens/parent_pages/child/education/educationMain.dart';
import 'package:ummicare/screens/parent_pages/child/health/addNewHealthData.dart';
import 'package:ummicare/screens/parent_pages/child/health/healthMain.dart';
import 'package:ummicare/services/childDatabase.dart';
import 'package:ummicare/services/healthDatabase.dart';
import 'package:ummicare/shared/function.dart';

import '../../../../services/eduDatabase.dart';

class childProfile extends StatefulWidget {
  const childProfile({super.key, required this.child});
  final childModel child;

  @override
  State<childProfile> createState() => _childProfileState();
}

class _childProfileState extends State<childProfile> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<childModel>(
        stream: childDatabase(childId: widget.child.childId)
            .childData,
        builder: (context, snapshot) {
          childModel? child = snapshot.data;
          return Scaffold(
            appBar: AppBar(
              title: Text(
                '${child!.childName}\'s Profile',
                style: const TextStyle(
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
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    CircleAvatar(
                      backgroundImage: NetworkImage(child.childProfileImg),
                      radius: 50.0,
                      backgroundColor: Colors.grey,
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Text(
                      child.childName,
                      style:
                          const TextStyle(fontSize: 25.0, color: Colors.black),
                    ),
                    const SizedBox(
                      height: 13.0,
                    ),
                    Container(
                      width: double.infinity,
                      alignment: Alignment.centerLeft,
                      decoration: const BoxDecoration(
                          color: Color(0xff71CBCA),
                          borderRadius:
                              BorderRadius.all(Radius.circular(10.0))),
                      child: Container(
                        padding:
                            const EdgeInsets.fromLTRB(20.0, 10.0, 10.0, 20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                const Icon(
                                  Icons.account_circle,
                                  size: 30.0,
                                  color: Colors.white,
                                ),
                                const Text(
                                  ' Personal Information',
                                  style: TextStyle(
                                      fontSize: 20.0, color: Colors.white),
                                ),
                                Flexible(
                                  child: Container(
                                    alignment: Alignment.centerRight,
                                    child: IconButton(
                                      icon: const Icon(
                                        Icons.edit,
                                        size: 25.0,
                                        color: Colors.white,
                                      ),
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  editChildProfile(
                                                      child: child),
                                            ));
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 5.0,
                            ),
                            Text(
                              'First Name: ${child.childFirstname}',
                            ),
                            Text(
                              'Last Name: ${child.childLastname}',
                            ),
                            Text(
                              'Birthday: ${convertTimeToDate(child.childBirthday)}',
                            ),
                            Text(
                              'Current Age: ${getAge(child.childBirthday)}',
                            ),
                            Text(
                              'Age Category: ${child.childAgeCategory}',
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15.0,
                    ),
                    StreamBuilder<List<EducationModel>>(
                        stream:
                            EduDatabaseService(childId: widget.child.childId)
                                .educationData,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Container(
                              width: double.infinity,
                              alignment: Alignment.centerLeft,
                              decoration: const BoxDecoration(
                                  color: Color(0xffF29180),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0))),
                              child: Container(
                                padding: const EdgeInsets.fromLTRB(
                                    20.0, 10.0, 10.0, 20.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    const Row(
                                      children: <Widget>[
                                        Icon(
                                          Icons.school,
                                          size: 30.0,
                                          color: Colors.white,
                                        ),
                                        Text(
                                          ' Education',
                                          style: TextStyle(
                                              fontSize: 20.0,
                                              color: Colors.white),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 5.0,
                                    ),
                                    Container(
                                        alignment: Alignment.center,
                                        child: const SpinKitPulse(
                                          color: Colors.black,
                                          size: 20.0,
                                        ))
                                  ],
                                ),
                              ),
                            );
                          } else {
                            List<EducationModel> educationModelData = [];
                            if (snapshot.hasData) {
                              educationModelData = snapshot.data!;
                            }
                            if (educationModelData.isEmpty) {
                              return Container(
                                width: double.infinity,
                                alignment: Alignment.centerLeft,
                                decoration: const BoxDecoration(
                                    color: Color(0xffF29180),
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(10.0))),
                                child: Container(
                                  padding: const EdgeInsets.fromLTRB(
                                      20.0, 10.0, 10.0, 20.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      const Row(
                                        children: <Widget>[
                                          Icon(
                                            Icons.school,
                                            size: 30.0,
                                            color: Colors.white,
                                          ),
                                          Text(
                                            ' Education',
                                            style: TextStyle(
                                                fontSize: 20.0,
                                                color: Colors.white),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 5.0,
                                      ),
                                      Container(
                                        alignment: Alignment.center,
                                        child: Column(
                                          children: [
                                            Text(
                                              "*Your child currently does not have Education Module. Please register by clicking the button below.",
                                              style: TextStyle(
                                                  color: Colors.grey[800],
                                                  fontSize: 13.0),
                                            ),
                                            const SizedBox(height: 3),
                                            ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: Colors.white,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5)),
                                              ),
                                              onPressed: () async {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            addNewEduCalendar(
                                                                childId: widget
                                                                    .child
                                                                    .childId)));
                                              },
                                              child: const Text(
                                                'Register Education Module',
                                                style: TextStyle(
                                                    color: Colors.black),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            } else {
                              return Container(
                                width: double.infinity,
                                alignment: Alignment.centerLeft,
                                decoration: const BoxDecoration(
                                    color: Color(0xffF29180),
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(10.0))),
                                child: Container(
                                  padding: const EdgeInsets.fromLTRB(
                                      20.0, 10.0, 10.0, 20.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          const Icon(
                                            Icons.school,
                                            size: 30.0,
                                            color: Colors.white,
                                          ),
                                          const Text(
                                            ' Education',
                                            style: TextStyle(
                                                fontSize: 20.0,
                                                color: Colors.white),
                                          ),
                                          Flexible(
                                            child: Container(
                                              alignment: Alignment.centerRight,
                                              child: IconButton(
                                                icon: Transform.scale(
                                                  scaleX: -1,
                                                  child: const Icon(
                                                    Icons.arrow_back,
                                                    size: 25.0,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                onPressed: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            educationMain(
                                                                childId: child
                                                                    .childId),
                                                      ));
                                                },
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 5.0,
                                      ),
                                      Text(
                                          'Current Year: ${educationModelData[0].currentYear}'),
                                      Text(
                                          'Status: ${educationModelData[0].status}')
                                    ],
                                  ),
                                ),
                              );
                            }
                          }
                        }),
                    const SizedBox(
                      height: 15.0,
                    ),
                    StreamBuilder<List<HealthModel>>(
                      stream: HealthDatabaseService(childId: widget.child.childId).healthData,
                      builder: (context, snapshot) {
                        if(snapshot.connectionState == ConnectionState.waiting){
                          return Container(
                            width: double.infinity,
                            alignment: Alignment.centerLeft,
                            decoration: const BoxDecoration(
                                color: Color(0xff8290F0),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0))),
                            child: Container(
                              padding: const EdgeInsets.fromLTRB(20.0, 10.0, 10.0, 20.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  const Row(
                                    children: <Widget>[
                                      Icon(
                                        Icons.health_and_safety,
                                        size: 30.0,
                                        color: Colors.white,
                                      ),
                                      Text(
                                        ' Health',
                                        style: TextStyle(
                                            fontSize: 20.0, color: Colors.white),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 5.0,
                                  ),
                                  Container(
                                      alignment: Alignment.center,
                                      child: const SpinKitPulse(
                                        color: Colors.black,
                                        size: 20.0,
                                      )
                                    )

                                ],
                              ),
                            ),
                          );
                        }else {
                        List<HealthModel> healthModelData = [];
                        if (snapshot.hasData) {
                          healthModelData = snapshot.data!;
                        }
                        if (healthModelData.isEmpty) {
                          return Container(
                            width: double.infinity,
                            alignment: Alignment.centerLeft,
                            decoration: const BoxDecoration(
                                color: Color(0xff8290F0),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0))),
                            child: Container(
                              padding:
                                  const EdgeInsets.fromLTRB(20.0, 10.0, 10.0, 20.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  const Row(
                                    children: <Widget>[
                                      Icon(
                                        Icons.health_and_safety,
                                        size: 30.0,
                                        color: Colors.white,
                                      ),
                                      Text(
                                        ' Health',
                                        style: TextStyle(
                                            fontSize: 20.0,
                                            color: Colors.white),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 5.0,
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    child: Column(
                                      children: [
                                        Text(
                                          "*Your child currently does not have Health Module. Please register by clicking the button below.",
                                          style: TextStyle(
                                              color: Colors.grey[800],
                                              fontSize: 13.0),
                                        ),
                                        ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.white),
                                          onPressed: () async {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        addNewHealthData(
                                                            childId: widget.child.childId)));
                                          },
                                          child: const Text(
                                            'Register Health Module',
                                            style: TextStyle(
                                                color: Colors.black),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        }else {
                          return Container(
                            width: double.infinity,
                            alignment: Alignment.centerLeft,
                            decoration: const BoxDecoration(
                                color: Color(0xff8290F0),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0))),
                            child: Container(
                              padding:
                                  const EdgeInsets.fromLTRB(20.0, 10.0, 10.0, 20.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      const Icon(
                                        Icons.health_and_safety,
                                        size: 30.0,
                                        color: Colors.white,
                                      ),
                                      const Text(
                                        ' Health',
                                        style: TextStyle(
                                            fontSize: 20.0,
                                            color: Colors.white),
                                      ),
                                      Flexible(
                                        child: Container(
                                          alignment: Alignment.centerRight,
                                          child: IconButton(
                                            icon: Transform.scale(
                                              scaleX: -1,
                                              child: const Icon(
                                                Icons.arrow_back,
                                                size: 25.0,
                                                color: Colors.white,
                                              ),
                                            ),
                                            onPressed: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        healthMain(
                                                            childId: child.childId,
                                                            healthId: healthModelData[0].currentHeight,
                                                            healthStatusId: healthModelData[0].healthStatusId,),
                                                  ));
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 5.0,
                                  ),
                                  Text(
                                    'Current Height:' '${healthModelData[0].currentHeight}'
                                  ),
                                  Text(
                                    'Current Weight:' '${healthModelData[0].currentWeight}'
                                  )
                                ],
                              ),
                            ),
                          );

                        }
                        }
                      }
                    ),
                    // ),
                    // TextButton(
                    //   style: TextButton.styleFrom(primary: Colors.blue),
                    //   onPressed: () {
                    //     Navigator.of(context)
                    //         .pushNamed('/parent/child/childprofile/childstory');
                    //   },
                    //   child: Text('Child story'),
                    // ),
                    // TextButton(
                    //   style: TextButton.styleFrom(primary: Colors.blue),
                    //   onPressed: () {
                    //     Navigator.of(context).pushNamed(
                    //         '/parent/child/childprofile/addnewchildstory');
                    //   },
                    //   child: Text('Add new child story'),
                    // ),
                    // TextButton(
                    //   style: TextButton.styleFrom(primary: Colors.blue),
                    //   onPressed: () {
                    //     Navigator.of(context)
                    //         .pushNamed('/parent/child/childprofile/education');
                    //   },
                    //   child: Text('Education'),
                    // ),
                    // TextButton(
                    //   style: TextButton.styleFrom(primary: Colors.blue),
                    //   onPressed: () {
                    //     Navigator.of(context)
                    //         .pushNamed('/parent/child/childprofile/health');
                    //   },
                    //   child: Text('Health'),
                    //
                  ],
                ),
              ),
            ),
          );
        });
  }
}
