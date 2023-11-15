import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ummicare/models/teacherModel.dart';

class teacherDatabase {

  final String teacherId;
  teacherDatabase({required this.teacherId});

  final CollectionReference teacherCollection =
      FirebaseFirestore.instance.collection('Teacher');

  //get specific teacher document stream
  Stream<teacherModel> get teacherData {
    return teacherCollection.doc(teacherId).snapshots().map(_createTeacherModelObject);
  }

  //get all userdetails stream
  Stream<List<teacherModel>> get allTeacherData {
    return teacherCollection.snapshots().map(_createTeacherModelList);
  }

  //create a user model object
  teacherModel _createTeacherModelObject(DocumentSnapshot snapshot) {
    return teacherModel(
      teacherId: snapshot.id,
      teacherCreatedDate: snapshot['teacherCreatedDate'],
      teacherFullName: snapshot['teacherFullName'],
      teacherFirstName: snapshot['teacherFirstName'],
      teacherLastName: snapshot['teacherLastName'],
      teacherEmail: snapshot['teacherEmail'],
      teacherPhoneNumber: snapshot['teacherPhoneNumber'],
      teacherProfileImg: snapshot['teacherProfileImg'],
    );
  }

  //create a list of user model object
  List<teacherModel> _createTeacherModelList(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return teacherModel(
          teacherId: doc.data().toString().contains('teacherId') ? doc.get('teacherId') : '',
          teacherCreatedDate: doc.data().toString().contains('teacherCreatedDate') ? doc.get('teacherCreatedDate') : '',
          teacherFullName: doc.data().toString().contains('teacherFullName') ? doc.get('teacherFullName') : '',
          teacherFirstName: doc.data().toString().contains('teacherFirstName') ? doc.get('teacherFirstName') : '',
          teacherLastName: doc.data().toString().contains('teacherLastName') ? doc.get('teacherLastName') : '',
          teacherEmail: doc.data().toString().contains('teacherEmail') ? doc.get('teacherEmail') : '',
          teacherPhoneNumber: doc.data().toString().contains('teacherPhoneNumber') ? doc.get('teacherPhoneNumber') : '',
          teacherProfileImg: doc.data().toString().contains('teacherProfileImg') ? doc.get('teacherProfileImg') : '');
    }).toList();
  }

  // addParent(Map<String, dynamic> parent, teacherModel teacher, String parentId) {
  //   updateTeacherData(teacherId, teacher.teacherFullName, teacher.teacherFirstName, teacher.teacherLastName, teacher.teacherEmail, teacher.teacherPhoneNumber, teacher.teacherProfileImg);
  //   teacherCollection.doc(teacher.teacherId).collection('Parent').doc(parentId).set(parent);
  // }

  // Stream<List<parentModel>> getParents(String docId) {
  //   return teacherCollection.doc(docId).collection('Parent').snapshots().map(_createParentModelList);
  // }

  // //create a list of user model object
  // List<parentModel> _createParentModelList(QuerySnapshot snapshot) {
  //   return snapshot.docs.map((doc) {
  //     return parentModel(
  //       parentId: doc.data().toString().contains('parentId') ? doc.get('parentId') : '',
  //       parentFullName: doc.data().toString().contains('parentId') ? doc.get('parentFullName') : '',
  //       parentFirstName: doc.data().toString().contains('parentFirstName') ? doc.get('parentFirstName') : '',
  //       parentLastName: doc.data().toString().contains('parentLastName') ? doc.get('parentLastName') : '',
  //       parentEmail: doc.data().toString().contains('parentEmail') ? doc.get('parentEmail') : '',
  //       parentPhoneNumber: doc.data().toString().contains('parentPhoneNumber') ? doc.get('parentPhoneNumber') : '',
  //       parentProfileImg: doc.data().toString().contains('parentProfileImg') ? doc.get('parentProfileImg') : '',
  //     );
  //   }).toList();
  // }

  //update user data
  Future<void> updateTeacherData(
      String teacherId,
      String teacherCreatedDate,
      String teacherFullName,
      String teacherFirstName,
      String teacherLastName,
      String teacherEmail,
      String teacherPhoneNumber,
      String teacherProfileImg,) async {
    return await teacherCollection.doc(teacherId).set({
      'teacherId': teacherId,
      'teacherCreatedDate': teacherCreatedDate,
      'teacherFullName': teacherFullName,
      'teacherFirstName': teacherFirstName,
      'teacherLastName': teacherLastName,
      'teacherEmail': teacherEmail,
      'teacherPhoneNumber': teacherPhoneNumber,
      'teacherProfileImg': teacherProfileImg,
    });
  }
  

}