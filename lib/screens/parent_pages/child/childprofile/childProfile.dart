import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:ummicare/models/academicCalendarModel.dart';
import 'package:ummicare/models/childModel.dart';
import 'package:ummicare/models/healthModel.dart';
import 'package:ummicare/models/medicalStaffModel.dart';
import 'package:ummicare/models/patientModel.dart';
import 'package:ummicare/models/schoolModel.dart';
import 'package:ummicare/models/studentModel.dart';
import 'package:ummicare/models/teacherModel.dart';
import 'package:ummicare/screens/parent_pages/child/childprofile/editChildProfile.dart';
import 'package:ummicare/screens/parent_pages/child/education/educationMain.dart';
import 'package:ummicare/screens/parent_pages/child/education/registerNewEducationPages.dart/addSchool.dart';
import 'package:ummicare/screens/parent_pages/child/health/addNewHealthData.dart';
import 'package:ummicare/screens/parent_pages/child/health/healthMain.dart';
import 'package:ummicare/services/academicCalendarDatabase.dart';
import 'package:ummicare/services/childDatabase.dart';
import 'package:ummicare/services/healthDatabase.dart';
import 'package:ummicare/services/medicalStaffDatabase.dart';
import 'package:ummicare/services/patientDatabase.dart';
import 'package:ummicare/services/schoolDatabase.dart';
import 'package:ummicare/services/studentDatabase.dart';
import 'package:ummicare/services/teacherDatabase.dart';
import 'package:ummicare/shared/function.dart';
import 'package:ummicare/shared/loading.dart';

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
        stream: childDatabase(childId: widget.child.childId).childData,
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
                            const Text(
                              'First Name',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              child.childFirstname
                            ),
                            const SizedBox(height: 5,),
                            const Text(
                              'Last Name',
                              style: TextStyle(
                                fontWeight: FontWeight.bold
                              ),
                            ),
                            Text(child.childLastname),
                            const SizedBox(height: 5),
                            const Text(
                              'Birthday',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(convertTimeToDateString(child.childBirthday)),
                            const SizedBox(height: 5,),
                            const Text(
                              'Current Age',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(getAge(child.childBirthday).toString()),
                            const SizedBox(height: 5,),
                            const Text(
                              'Age Category',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(child.childAgeCategory)
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15.0,
                    ),
                    child.educationId == ''
                        ? Container(
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
                                                    BorderRadius.circular(5)),
                                          ),
                                          onPressed: () async {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        addSchool(
                                                          childId: widget
                                                              .child.childId,
                                                        )));
                                          },
                                          child: const Text(
                                            'Register Education Module',
                                            style:
                                                TextStyle(color: Colors.black),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )
                        : StreamBuilder<studentModel>(
                            stream: studentDatabase()
                                .studentData(child.educationId),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
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
                                            child: const SpinKitPulse(
                                              color: Colors.black,
                                              size: 20.0,
                                            ))
                                      ],
                                    ),
                                  ),
                                );
                              } else {
                                if (snapshot.hasData) {
                                  studentModel? student = snapshot.data;
                                  return StreamBuilder<academicCalendarModel>(
                                      stream: academicCalendarDatabase()
                                          .academicCalendarData(
                                              student!.academicCalendarId),
                                      builder: (context, snapshot) {
                                        if (snapshot.hasData) {
                                          academicCalendarModel?
                                              academicCalendar = snapshot.data;
                                          return Container(
                                            width: double.infinity,
                                            alignment: Alignment.centerLeft,
                                            decoration: const BoxDecoration(
                                                color: Color(0xffF29180),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10.0))),
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
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
                                                            color:
                                                                Colors.white),
                                                      ),
                                                      Flexible(
                                                        child: Container(
                                                          alignment: Alignment
                                                              .centerRight,
                                                          child: IconButton(
                                                            icon:
                                                                Transform.scale(
                                                              scaleX: -1,
                                                              child: const Icon(
                                                                Icons
                                                                    .arrow_back,
                                                                size: 25.0,
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                            ),
                                                            onPressed: () {
                                                              Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                    builder:
                                                                        (context) =>
                                                                            educationMain(
                                                                      studentId:
                                                                          child
                                                                              .educationId,
                                                                      childId: child
                                                                          .childId,
                                                                    ),
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
                                                  StreamBuilder<schoolModel>(
                                                      stream: schoolDatabase()
                                                          .schoolData(
                                                              student.schoolId),
                                                      builder:
                                                          (context, snapshot) {
                                                        if (snapshot.hasData) {
                                                          return Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              const Text(
                                                                'School',
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ),
                                                              Text(snapshot
                                                                  .data!
                                                                  .schoolName),
                                                            ],
                                                          );
                                                        } else {
                                                          return Container();
                                                        }
                                                      }),
                                                  const SizedBox(
                                                    height: 5.0,
                                                  ),
                                                  StreamBuilder<classModel>(
                                                      stream: schoolDatabase()
                                                          .classData(
                                                              student.classId),
                                                      builder:
                                                          (context, snapshot) {
                                                        if (snapshot.hasData) {
                                                          return Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              const Text(
                                                                'Class',
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ),
                                                              Text(
                                                                  '${snapshot.data!.classYear} - ${snapshot.data!.className}'),
                                                            ],
                                                          );
                                                        } else {
                                                          return Container();
                                                        }
                                                      }),
                                                  const SizedBox(
                                                    height: 5.0,
                                                  ),
                                                  StreamBuilder<teacherModel>(
                                                      stream: teacherDatabase(
                                                              teacherId:
                                                                  academicCalendar!
                                                                      .teacherId)
                                                          .teacherData,
                                                      builder:
                                                          (context, snapshot) {
                                                        if (snapshot.hasData) {
                                                          return Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              const Text(
                                                                'Teacher',
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ),
                                                              Text(snapshot
                                                                  .data!
                                                                  .teacherFullName)
                                                            ],
                                                          );
                                                        } else {
                                                          return Container();
                                                        }
                                                      })
                                                ],
                                              ),
                                            ),
                                          );
                                        } else {
                                          return const Loading();
                                        }
                                      });
                                } else {
                                  return const Loading();
                                }
                              }
                            }),
                    const SizedBox(
                      height: 15.0,
                    ),
                    child.healthId == ''
                      ? Container(
                        width: double.infinity,
                        alignment: Alignment.centerLeft,
                        decoration: const BoxDecoration(
                            color: Color(0xff8290F0),
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
                                    Icons.health_and_safety,
                                    size: 30.0,
                                    color: Colors.white,
                                  ),
                                  Text(
                                    'Health',
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
                                          backgroundColor:
                                              Colors.white),
                                      onPressed: () async {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    addNewHealthData(
                                                        child: child)));
                                        
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
                      )
                    : StreamBuilder<HealthModel>(
                        stream: HealthDatabaseService().healthData(child.healthId),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Container(
                              width: double.infinity,
                              alignment: Alignment.centerLeft,
                              decoration: const BoxDecoration(
                                  color: Color(0xff8290F0),
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
                                          Icons.health_and_safety,
                                          size: 30.0,
                                          color: Colors.white,
                                        ),
                                        Text(
                                          'Health',
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
                            if (snapshot.hasData) {
                              HealthModel? healthData = snapshot.data;
                              return Container(
                                width: double.infinity,
                                alignment: Alignment.centerLeft,
                                decoration: const BoxDecoration(
                                    color: Color(0xff8290F0),
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
                                            Icons.health_and_safety,
                                            size: 30.0,
                                            color: Colors.white,
                                          ),
                                          const Text(
                                            'Health',
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
                                                          childId:
                                                              child.childId,
                                                          healthId:
                                                              healthData!.healthId,
                                                        ),
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
                                      StreamBuilder<patientModel>(
                                        stream: PatientDatabaseService().patientData(healthData!.patientId),
                                        builder: (context, snapshot) {
                                          if(snapshot.hasData){
                                            StreamBuilder<ClinicModel>(
                                              stream: medicalStaffDatabase().clinicData(snapshot.data!.clinicId),
                                              builder: (context, snapshot) {
                                                if (snapshot.hasData) {
                                                  return Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      const Text(
                                                        'Clinic',
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      Text(snapshot
                                                          .data!
                                                          .clinicName),
                                                    ],
                                                  );
                                                } else {
                                                  return Text("nn");
                                                }
                                              },
                                            );
                                          } else{
                                            return Text("ss");
                                          }
                                          return Text("pp");
                                        },
                                      ),
                                      const SizedBox(
                                        height: 5.0,
                                      ),
                                      StreamBuilder<List<BmiHealthModel>>(
                                        stream: HealthDatabaseService().allBmiHealthData(healthData.healthId),
                                        builder:(context, snapshot) {
                                          if(snapshot.hasData){
                                            List<BmiHealthModel>? bmi = snapshot.data;
                                            String bmiStatus = 'ss';
                                            double lastBmiData = bmi![0].bmiData;
                                            if (lastBmiData < 16) {
                                              bmiStatus = "Severe Thinness";
                                            } else if (lastBmiData < 17) {
                                              bmiStatus = "Moderate Thinness";
                                            } else if (lastBmiData < 18.5) {
                                              bmiStatus = "Mild Thinness";
                                            } else if (lastBmiData < 25) {
                                              bmiStatus = "Normal";
                                            } else if (lastBmiData < 30) {
                                              bmiStatus = "Overweight";
                                            } else if (lastBmiData < 35) {
                                              bmiStatus = "Obese Class I";
                                            } else if (lastBmiData < 40) {
                                              bmiStatus = "Obese Class II";
                                            } else if (lastBmiData >= 40) {
                                              bmiStatus = "Obese Class III";
                                            } else {
                                              bmiStatus = "No Status";
                                            }
                                            return Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment
                                                      .start,
                                              children: [
                                                const Text(
                                                  'Current BMI Status',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight
                                                              .bold),
                                                ),
                                                Text(bmiStatus),
                                              ],
                                            );
                                          } else {
                                            return Text("ss");
                                          }
                                          
                                        },
                                      )
                                    ],
                                  ),
                                ),
                              );
                            }else {
                              return const Loading();
                            }
                          }
                        }),
                  ],
                ),
              ),
            ),
          );
        });
  }
}