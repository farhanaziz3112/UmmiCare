import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ummicare/models/parentModel.dart';

import '../models/childModel.dart';

class parentDatabase {
  final String parentId;
  parentDatabase({required this.parentId});

  // FirebaseAuth _auth = FirebaseAuth.instance;

  //------------------------------USER----------------------------------

  //collection reference
  final CollectionReference parentCollection =
      FirebaseFirestore.instance.collection('Parent');

  //collection reference
  final CollectionReference childCollection =
      FirebaseFirestore.instance.collection('Child');

  //get specific user document stream
  Stream<parentModel> get parentData {
    return parentCollection
        .doc(parentId)
        .snapshots()
        .map(_createparentModelObject);
  }

  //get all userdetails stream
  Stream<List<parentModel>> get allParentData {
    return parentCollection.snapshots().map(_createparentModelList);
  }

  //create a user model object
  parentModel _createparentModelObject(DocumentSnapshot snapshot) {
    return parentModel(
        parentId: parentId,
        parentCreatedDate: snapshot['parentCreatedDate'],
        parentFullName: snapshot['parentFullName'],
        parentFirstName: snapshot['parentFirstName'],
        parentLastName: snapshot['parentLastName'],
        parentEmail: snapshot['parentEmail'],
        parentPhoneNumber: snapshot['parentPhoneNumber'],
        parentProfileImg: snapshot['parentProfileImg'],
        advisorId: snapshot['advisorId'],
        noOfChild: snapshot['noOfChild']);
  }

  //create a list of user model object
  List<parentModel> _createparentModelList(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return parentModel(
          parentId: parentId,
          parentCreatedDate: doc.get('parentCreatedDate'),
          parentFullName: doc.get('parentFullName'),
          parentFirstName: doc.get('parentFirstName'),
          parentLastName: doc.get('parentLastName'),
          parentEmail: doc.get('parentEmail'),
          parentPhoneNumber: doc.get('parentPhoneNumber'),
          parentProfileImg: doc.get('parentProfileImg'),
          advisorId: doc.get('advisorId'),
          noOfChild: doc.get('noOfChild'));
    }).toList();
  }

  //update user data
  Future<void> updateParentData(
      String parentId,
      String parentCreatedDate,
      String parentFullName,
      String parentFirstName,
      String parentLastName,
      String parentEmail,
      String parentPhoneNumber,
      String parentProfileImg,
      String advisorId,
      String noOfChild) async {
    return await parentCollection.doc(parentId).set({
      'parentId': parentId,
      'parentCreatedDate': parentCreatedDate,
      'parentFullName': parentFullName,
      'parentFirstName': parentFirstName,
      'parentLastName': parentLastName,
      'parentEmail': parentEmail,
      'parentPhoneNumber': parentPhoneNumber,
      'parentProfileImg': parentProfileImg,
      'advisorId': advisorId,
      'noOfChild': noOfChild
    });
  }

  //get specific child document stream
  Stream<childModel> get childData {
    return childCollection
        .doc(parentId)
        .snapshots()
        .map(_createchildModelObject);
  }

  //get all childs stream
  Stream<List<childModel>> get allChildData {
    return childCollection
        .where('parentId', isEqualTo: parentId)
        .snapshots()
        .map(_createchildModelList);
  }

  //create a list of child model object
  List<childModel> _createchildModelList(QuerySnapshot snapshot) {
    return snapshot.docs.map<childModel>((doc) {
      return childModel(
        childId: doc.id,
        parentId: doc.get('parentId') ?? '',
        childCreatedDate: doc.get('childCreatedDate') ?? '',
        childName: doc.get('childName') ?? '',
        childFirstname: doc.get('childFirstname') ?? '',
        childLastname: doc.get('childLastname') ?? '',
        childBirthday: doc.get('childBirthday') ?? '',
        childCurrentAge: doc.get('childCurrentAge') ?? '',
        childAgeCategory: doc.get('childAgeCategory') ?? '',
        childProfileImg: doc.get('childProfileImg') ?? '',
        educationId: doc.get('educationId') ?? '',
        healthId: doc.get('healthId') ?? '',
        overallStatus: doc.get('overallStatus') ?? '',
      );
    }).toList();
  }

  //create a child model object
  childModel _createchildModelObject(DocumentSnapshot snapshot) {
    return childModel(
        childId: snapshot.id,
        parentId: snapshot['parentId'],
        childCreatedDate: snapshot['childCreatedDate'],
        childName: snapshot['childName'],
        childFirstname: snapshot['childFirstname'],
        childLastname: snapshot['childLastname'],
        childBirthday: snapshot['childBirthday'],
        childCurrentAge: snapshot['childCurrentAge'],
        childAgeCategory: snapshot['childAgeCategory'],
        childProfileImg: snapshot['childProfileImg'],
        educationId: snapshot['educationId'],
        healthId: snapshot['healthId'],
        overallStatus: snapshot['overallStatus'],);
  }

  //update child data
  Future<void> updateChildData(
      String childId,
      String parentId,
      String childCreatedDate,
      String childName,
      String childFirstname,
      String childLastname,
      String childBirthday,
      int childCurrentAge,
      String childAgeCategory,
      String childProfileImg,
      String educationId,
      String healthId,
      String overallStatus) async {
    return await childCollection.doc(childId).set({
      'childId': childId,
      'parentId': parentId,
      'childCreatedDate': childCreatedDate,
      'childName': childName,
      'childFirstname': childFirstname,
      'childLastname': childLastname,
      'childBirthday': childBirthday,
      'childCurrentAge': childCurrentAge,
      'childAgeCategory': childAgeCategory,
      'childProfileImg': childProfileImg,
      'educationId': educationId,
      'healthId': healthId,
      'overallStatus': overallStatus
    });
  }

  //create child data
  Future<void> createChildData(
      String parentId,
      String childCreatedDate,
      String childName,
      String childFirstname,
      String childLastname,
      String childBirthday,
      int childCurrentAge,
      String childAgeCategory,
      String childProfileImg,
      String educationId,
      String healthId,
      String overallStatus) async {
    final document = childCollection.doc();
    await childCollection.doc(document.id).set({
      'childId': document.id,
      'parentId': parentId,
      'childCreatedDate': childCreatedDate,
      'childName': childName,
      'childFirstname': childFirstname,
      'childLastname': childLastname,
      'childBirthday': childBirthday,
      'childCurrentAge': childCurrentAge,
      'childAgeCategory': childAgeCategory,
      'childProfileImg': childProfileImg,
      'educationId': educationId,
      'healthId': healthId,
      'overallStatus': overallStatus
    });
    return await parentCollection.doc(parentId).collection('Child').doc(document.id).set({
      'childId': document.id,
    });
  }
}


// //------------------------------EDUCATION----------------------------------

// //collection reference
// final CollectionReference educationCollection =
//     FirebaseFirestore.instance.collection('Education');

// //get education stream
// Stream<List<EducationModel>> get educationData {
//   return educationCollection
//       .where('childId', isEqualTo: parentId)
//       .where('status', isEqualTo: 'current')
//       .snapshots()
//       .map(_createEducationModelList);
// }

// //create a child model object
//   EducationModel _createEducationModelObject(DocumentSnapshot snapshot) {
//     return EducationModel(
//       educationId: snapshot.id,
//       calendarEndDate: snapshot['calendarEndDate'],
//       calendarStartDate: snapshot['calendarStartDate'],
//       childId: snapshot['childId'],
//       classId: snapshot['classId'],
//       schoolId: snapshot['schoolId'],
//       currentYear: snapshot['currentYear'],
//       status: snapshot['status'],
//       subjects: snapshot['subjects'],
//     );
//   }

//   //create a list of education model object
//   List<EducationModel> _createEducationModelList(QuerySnapshot snapshot) {
//     return snapshot.docs.map<EducationModel>((doc) {
//       return EducationModel(
//         educationId: doc.id,
//         calendarEndDate: doc.get('calendarEndDate') ?? '',
//         calendarStartDate: doc.get('calendarStartDate') ?? '',
//         childId: doc.get('childId') ?? '',
//         classId: doc.get('classId') ?? '',
//         schoolId: doc.get('schoolId') ?? '',
//         currentYear: doc.get('currentYear') ?? 2,
//         status: doc.get('status') ?? '',
//         subjects: doc.get('subjects') ?? '',
//       );
//     }).toList();
//   }

// //------------------------------SCHOOL----------------------------------

//   //collection reference
//   final CollectionReference schoolCollection =
//     FirebaseFirestore.instance.collection('School');

//   //create a school model
//   SchoolModel _createSchoolModelObject(DocumentSnapshot snapshot) {
//     return SchoolModel(
//       schoolId: snapshot.id,
//       schoolAddress: snapshot['schoolAddress'],
//       schoolEmail: snapshot['schoolEmail'],
//       schoolName: snapshot['schoolName'],
//       schoolPhoneNumber: snapshot['schoolPhoneNumber'],
//     );
//   }

// //------------------------------CLASS----------------------------------

//   //collection reference
//   final CollectionReference classCollection =
//     FirebaseFirestore.instance.collection('Class');

//   //create a school model
//   ClassModel _createClassModelObject(DocumentSnapshot snapshot) {
//     return ClassModel(
//       classId: snapshot.id,
//       className: snapshot['className'],
//       classTeacherId: snapshot['classTeacherId'],
//       schoolId: snapshot['schoolId'],
//     );
//   }

// //------------------------------TEACHER----------------------------------

//   final CollectionReference teacherCollection =
//     FirebaseFirestore.instance.collection('Teacher');

//   //create a school model
//   TeacherModel _createTeacherModelObject(DocumentSnapshot snapshot) {
//     return TeacherModel(
//       teacherId: snapshot.id,
//       teacherEmail: snapshot['teacherEmail'],
//       teacherName: snapshot['teacherName'],
//       teacherPhoneNumber: snapshot['teacherPhoneNumber'],
//       schoolId: snapshot['schoolId'],
//       classId: snapshot['classId'],
//     );
//   }

