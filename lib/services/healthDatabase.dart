import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ummicare/models/healthmodel.dart';

class HealthDatabaseService {
  final String childId;
  final String? healthId;

  HealthDatabaseService({required this.childId, this.healthId});

//------------------------------Health----------------------------------

  //collection reference
  final CollectionReference healthCollection =
      FirebaseFirestore.instance.collection('Health');

  //collection reference
  final CollectionReference healthSubjectsCollection = FirebaseFirestore
      .instance
      .collection('Health');

  //get Health stream
  Stream<List<HealthModel>> get healthData {
    return healthCollection
        .where('childId', isEqualTo: childId)
        .snapshots()
        .map(_createHealthModelList);
  }

  //create a Health model object
  HealthModel _createHealthModelObject(DocumentSnapshot snapshot) {
    return HealthModel(
      healthId: snapshot.id,
      currentHeight: snapshot['currentHeight'],
      currentWeight: snapshot['currentWeight'],
      childId: snapshot['childId'],
      healthStatusId: snapshot['healthStatusId'],
    );
  }

  //create a list of Health model object
  List<HealthModel> _createHealthModelList(QuerySnapshot snapshot) {
    return snapshot.docs.map<HealthModel>((doc) {
      return HealthModel(
        healthId: doc.id,
        currentHeight: doc.get('currentHeight') ?? '',
        currentWeight: doc.get('currentWeight') ?? '',
        childId: doc.get('childId') ?? '',
        healthStatusId: doc.get('healthStatusId') ?? '',
      );
    }).toList();
  }

  //create Health data
  Future<void> createHealthData(
      String healthId,
      String currentHeight,
      String currentWeight,
      String childId,
      String healthStatusId) async {
    return await healthCollection.doc().set({
      'currentHeight': currentHeight,
      'currentWeight': currentWeight,
      'childId': childId,
      'healthStatusId': healthStatusId,
    });
  }

/**------------------------------SCHOOL----------------------------------

  //collection reference
  final CollectionReference schoolCollection =
      FirebaseFirestore.instance.collection('School');

  //create a school model
  SchoolModel _createSchoolModelObject(DocumentSnapshot snapshot) {
    return SchoolModel(
      schoolId: snapshot.id,
      schoolAddress: snapshot['schoolAddress'],
      schoolEmail: snapshot['schoolEmail'],
      schoolName: snapshot['schoolName'],
      schoolPhoneNumber: snapshot['schoolPhoneNumber'],
    );
  }

  //create school data
  Future<void> createSchoolData(String schoolId, String schoolAddress,
      String schoolEmail, String schoolName, String schoolPhoneNumber) async {
    return await schoolCollection.doc(schoolId).set({
      'schoolAddress': schoolAddress,
      'schoolEmail': schoolEmail,
      'schoolName': schoolName,
      'schoolPhoneNumber': schoolPhoneNumber
    });
  }

//------------------------------CLASS----------------------------------

  //collection reference
  final CollectionReference classCollection =
      FirebaseFirestore.instance.collection('Class');

  //create a school model
  ClassModel _createClassModelObject(DocumentSnapshot snapshot) {
    return ClassModel(
      classId: snapshot.id,
      className: snapshot['className'],
      classTeacherId: snapshot['classTeacherId'],
      schoolId: snapshot['schoolId'],
    );
  }

//------------------------------TEACHER----------------------------------

  final CollectionReference teacherCollection =
      FirebaseFirestore.instance.collection('Teacher');

  //create a school model
  TeacherModel _createTeacherModelObject(DocumentSnapshot snapshot) {
    return TeacherModel(
      teacherId: snapshot.id,
      teacherEmail: snapshot['teacherEmail'],
      teacherName: snapshot['teacherName'],
      teacherPhoneNumber: snapshot['teacherPhoneNumber'],
      schoolId: snapshot['schoolId'],
      classId: snapshot['classId'],
    );
  }*/
}