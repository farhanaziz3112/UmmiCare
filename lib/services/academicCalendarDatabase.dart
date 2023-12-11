import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ummicare/models/academicCalendarModel.dart';
import 'package:ummicare/models/subjectModel.dart';

class academicCalendarDatabase {
  final CollectionReference academicCalendarCollection =
      FirebaseFirestore.instance.collection('Academic Calendar');

  final CollectionReference subjectCollection =
      FirebaseFirestore.instance.collection('Subject');

  Stream<academicCalendarModel> academicCalendarData(
      String academicCalendarId) {
    return academicCalendarCollection
        .doc(academicCalendarId)
        .snapshots()
        .map(_createAcademicCalendarModelObject);
  }

  //get all userdetails stream
  Stream<List<academicCalendarModel>> allAcademicCalendarDataWithTeacherId(
      String teacherId) {
    return academicCalendarCollection
        .where('teacherId', isEqualTo: teacherId)
        .snapshots()
        .map(_createAcademicCalendarModelList);
  }

  //get all userdetails stream
  Stream<List<academicCalendarModel>> allOpenAcademicCalendarDataWithSchoolId(
      String schoolId) {
    return academicCalendarCollection
        .where('schoolId', isEqualTo: schoolId)
        .where('registrationStatus', isEqualTo: 'open')
        .snapshots()
        .map(_createAcademicCalendarModelList);
  }

  // //get all userdetails stream
  // Stream<List<academicCalendarModel>> get allAcademicCalendarData {
  //   return academicCalendarCollection
  //       .snapshots()
  //       .map(_createAcademicCalendarModelList);
  // }

  //create a user model object
  academicCalendarModel _createAcademicCalendarModelObject(
      DocumentSnapshot snapshot) {
    return academicCalendarModel(
      academicCalendarId: snapshot.id,
      schoolId: snapshot['schoolId'],
      classId: snapshot['classId'],
      teacherId: snapshot['teacherId'],
      academicCalendarStartDate: snapshot['academicCalendarStartDate'],
      academicCalendarEndDate: snapshot['academicCalendarEndDate'],
      noOfStudent: snapshot['noOfStudent'],
      registrationStatus: snapshot['registrationStatus'],
    );
  }

  //create a list of user model object
  List<academicCalendarModel> _createAcademicCalendarModelList(
      QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return academicCalendarModel(
        academicCalendarId: doc.data().toString().contains('academicCalendarId')
            ? doc.get('academicCalendarId')
            : '',
        schoolId: doc.data().toString().contains('schoolId')
            ? doc.get('schoolId')
            : '',
        classId:
            doc.data().toString().contains('classId') ? doc.get('classId') : '',
        teacherId: doc.data().toString().contains('teacherId')
            ? doc.get('teacherId')
            : '',
        academicCalendarStartDate:
            doc.data().toString().contains('academicCalendarStartDate')
                ? doc.get('academicCalendarStartDate')
                : '',
        academicCalendarEndDate:
            doc.data().toString().contains('academicCalendarEndDate')
                ? doc.get('academicCalendarEndDate')
                : '',
        noOfStudent: doc.data().toString().contains('noOfStudent')
            ? doc.get('noOfStudent')
            : '',
        registrationStatus: doc.data().toString().contains('registrationStatus')
            ? doc.get('registrationStatus')
            : '',
      );
    }).toList();
  }

  Future<void> updateAcademicCalendarData(
      String academicCalendarId,
      String schoolId,
      String classId,
      String teacherId,
      String academicCalendarStartDate,
      String academicCalendarEndDate,
      String noOfStudent,
      String registrationStatus) async {
    return await academicCalendarCollection.doc(academicCalendarId).set({
      'academicCalendarId': academicCalendarId,
      'schoolId': schoolId,
      'classId': classId,
      'teacherId': teacherId,
      'academicCalendarStartDate': academicCalendarStartDate,
      'academicCalendarEndDate': academicCalendarEndDate,
      'noOfStudent': noOfStudent,
      'registrationStatus': registrationStatus
    });
  }

  Future<void> createAcademicCalendarData(
      String schoolId,
      String classId,
      String teacherId,
      String academicCalendarStartDate,
      String academicCalendarEndDate,
      String noOfStudent,
      String registrationStatus) async {
    final document = academicCalendarCollection.doc();
    return await academicCalendarCollection.doc(document.id).set({
      'academicCalendarId': document.id,
      'schoolId': schoolId,
      'classId': classId,
      'teacherId': teacherId,
      'academicCalendarStartDate': academicCalendarStartDate,
      'academicCalendarEndDate': academicCalendarEndDate,
      'noOfStudent': noOfStudent,
      'registrationStatus': registrationStatus
    });
  }

  Future<void> addStudents(
      String academicCalendarId, String studentId) async {
    return await academicCalendarCollection
        .doc(academicCalendarId)
        .collection('Students')
        .doc(studentId)
        .set({
      'studentId': studentId,
    });
  }

  //  //get specific teacher document stream
  // Stream<subjectModel> subjectData(
  //     String subjectId) {
  //   return subjectCollection
  //       .doc(subjectId)
  //       .snapshots()
  //       .map(_createSubjectModelObject);
  // }

  // //get all userdetails stream
  // Stream<List<subjectModel>> get allSubjectData {
  //   return subjectCollection
  //       .snapshots()
  //       .map(_createSubjectModelList);
  // }

  // //get all userdetails stream
  // Stream<List<academicCalendarModel>> get allAcademicCalendarData {
  //   return academicCalendarCollection
  //       .snapshots()
  //       .map(_createAcademicCalendarModelList);
  // }


  Stream<subjectModel> subjectData(
      String subjectId, String academicCalendarId) {
    return academicCalendarCollection
        .doc(academicCalendarId)
        .collection('Subjects')
        .doc(subjectId)
        .snapshots()
        .map(_createSubjectModelObject);
  }

  //get all userdetails stream
  Stream<List<subjectModel>> allSubjectData(String academicCalendarId) {
    return academicCalendarCollection
        .doc(academicCalendarId)
        .collection('Subjects')
        .snapshots()
        .map(_createSubjectModelList);
  }

  //create a user model object
  subjectModel _createSubjectModelObject(DocumentSnapshot snapshot) {
    return subjectModel(
        subjectId: snapshot.id, subjectName: snapshot['subjectName']);
  }

  //create a list of user model object
  List<subjectModel> _createSubjectModelList(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return subjectModel(
        subjectId: doc.get('subjectId'),
        subjectName: doc.get('subjectName'),
      );
    }).toList();
  }
}
