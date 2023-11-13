import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ummicare/models/parentModel.dart';

import '../models/childmodel.dart';

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
        .map(_createParentModelObject);
  }

  //get all userdetails stream
  Stream<List<parentModel>> get allParentData {
    return parentCollection.snapshots().map(_createParentModelList);
  }

  //create a user model object
  parentModel _createParentModelObject(DocumentSnapshot snapshot) {
    return parentModel(
      parentId: parentId,
      parentFullName: snapshot['parentFullName'],
      parentFirstName: snapshot['parentFirstName'],
      parentLastName: snapshot['parentLastName'],
      parentEmail: snapshot['parentEmail'],
      parentPhoneNumber: snapshot['parentPhoneNumber'],
      parentProfileImg: snapshot['parentProfileImg'],
      advisorId: snapshot['advisorId'],
    );
  }

  //create a list of user model object
  List<parentModel> _createParentModelList(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return parentModel(
          parentId: parentId,
          parentFullName: doc.get('parentFullName'),
          parentFirstName: doc.get('parentFirstName'),
          parentLastName: doc.get('parentLastName'),
          parentEmail: doc.get('parentEmail'),
          parentPhoneNumber: doc.get('parentPhoneNumber'),
          parentProfileImg: doc.get('parentProfileImg'),
          advisorId: doc.get('advisorId'));
    }).toList();
  }

  //update user data
  Future<void> updateParentData(
      String parentId,
      String parentFullName,
      String parentFirstName,
      String parentLastName,
      String parentEmail,
      String parentPhoneNumber,
      String parentProfileImg,
      String advisorId) async {
    return await parentCollection.doc(parentId).set({
      'parentId': parentId,
      'parentFullName': parentFullName,
      'parentFirstName': parentFirstName,
      'parentLastName': parentLastName,
      'parentEmail': parentEmail,
      'parentPhoneNumber': parentPhoneNumber,
      'parentProfileImg': parentProfileImg,
      'advisorId' : advisorId
    });
  }

  //get specific child document stream
  Stream<ChildModel> get childData {
    return childCollection
        .doc(parentId)
        .snapshots()
        .map(_createChildModelObject);
  }

  //get all childs stream
  Stream<List<ChildModel>> get allChildData {
    return childCollection
        .where('parentId', isEqualTo: parentId)
        .snapshots()
        .map(_createChildModelList);
  }

  //create a list of child model object
  List<ChildModel> _createChildModelList(QuerySnapshot snapshot) {
    return snapshot.docs.map<ChildModel>((doc) {
      return ChildModel(
        childId: doc.id,
        parentId: doc.get('parentId') ?? '',
        childName: doc.get('childName') ?? '',
        childFirstname: doc.get('childFirstname') ?? '',
        childLastname: doc.get('childLastname') ?? '',
        childBirthday: doc.get('childBirthday') ?? '',
        childCurrentAge: doc.get('childCurrentAge') ?? 2,
        childAgeCategory: doc.get('childAgeCategory') ?? '',
        childProfileImg: doc.get('childProfileImg') ?? '',
      );
    }).toList();
  }

  //create a child model object
  ChildModel _createChildModelObject(DocumentSnapshot snapshot) {
    return ChildModel(
      childId: snapshot.id,
      parentId: snapshot['parentId'],
      childName: snapshot['childName'],
      childFirstname: snapshot['childFirstname'],
      childLastname: snapshot['childLastname'],
      childBirthday: snapshot['childBirthday'],
      childCurrentAge: snapshot['childCurrentAge'],
      childAgeCategory: snapshot['childAgeCategory'],
      childProfileImg: snapshot['childProfileImg'],
    );
  }

  //update child data
  Future<void> updateChildData(
      String childId,
      String parentId,
      String childName,
      String childFirstname,
      String childLastname,
      String childBirthday,
      int childCurrentAge,
      String childAgeCategory,
      String childProfileImg) async {
    return await childCollection.doc(childId).set({
      'parentId': parentId,
      'childName': childName,
      'childFirstname': childFirstname,
      'childLastname': childLastname,
      'childBirthday': childBirthday,
      'childCurrentAge': childCurrentAge,
      'childAgeCategory': childAgeCategory,
      'childProfileImg': childProfileImg,
    });
  }

  //create child data
  Future<void> createChildData(
      String parentId,
      String childName,
      String childFirstname,
      String childLastname,
      String childBirthday,
      int childCurrentAge,
      String childAgeCategory,
      String childProfileImg) async {
    return await childCollection.doc().set({
      'parentId': parentId,
      'childName': childName,
      'childFirstname': childFirstname,
      'childLastname': childLastname,
      'childBirthday': childBirthday,
      'childCurrentAge': childCurrentAge,
      'childAgeCategory': childAgeCategory,
      'childProfileImg': childProfileImg,
    });
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
}
