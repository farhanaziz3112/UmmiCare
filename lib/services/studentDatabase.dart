import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ummicare/models/studentModel.dart';

class studentDatabase {
  final CollectionReference studentCollection =
      FirebaseFirestore.instance.collection('Student');

  //get specific teacher document stream
  Stream<studentModel> studentData(String studentId) {
    return studentCollection
        .doc(studentId)
        .snapshots()
        .map(_createStudentModelObject);
  }

  // //get specific teacher document stream
  // Stream<studentModel> studentDataWithChildId(String childId) {
  //   return studentCollection
  //       .where('childId', isEqualTo: childId)
  //       .snapshots()
  //       .map(_createStudentModelObject);
  // }

  //get all userdetails stream
  Stream<List<studentModel>> allStudentWithAcademicCalendar(
      String academicCalendarId) {
    return studentCollection
        .where('academicCalendarId', isEqualTo: academicCalendarId)
        .snapshots()
        .map(_createStudentListModelObject);
  }

  //create a user model object
  studentModel _createStudentModelObject(DocumentSnapshot snapshot) {
    return studentModel(
      studentId: snapshot.id,
      childId: snapshot['childId'],
      schoolId: snapshot['schoolId'],
      academicCalendarId: snapshot['academicCalendarId'],
      classId: snapshot['classId'],
      feeId: snapshot['feeId'],
      activationStatus: snapshot['activationStatus'],
    );
  }

  //create a list of user model object
  List<studentModel> _createStudentListModelObject(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return studentModel(
        studentId: doc.data().toString().contains('studentId')
            ? doc.get('studentId')
            : '',
        childId:
            doc.data().toString().contains('childId') ? doc.get('childId') : '',
        schoolId: doc.data().toString().contains('schoolId')
            ? doc.get('schoolId')
            : '',
        academicCalendarId: doc.data().toString().contains('academicCalendarId')
            ? doc.get('academicCalendarId')
            : '',
        classId:
            doc.data().toString().contains('classId') ? doc.get('classId') : '',
        feeId: doc.data().toString().contains('feeId') ? doc.get('feeId') : '',
        activationStatus: doc.data().toString().contains('activationStatus')
            ? doc.get('activationStatus')
            : '',
      );
    }).toList();
  }

  Future<void> updateStudentData(
      String studentId,
      String childId,
      String schoolId,
      String academicCalendarId,
      String classId,
      String feeId,
      String activationStatus) async {
    return await studentCollection.doc(studentId).set({
      'studentId': studentId,
      'childId': childId,
      'schoolId': schoolId,
      'academicCalendarId': academicCalendarId,
      'classId': classId,
      'feeId': feeId,
      'activationStatus': activationStatus
    });
  }

  Future<void> createStudentData(
      String childId,
      String schoolId,
      String academicCalendarId,
      String classId,
      String feeId,
      String activationStatus) async {
    final document = studentCollection.doc();
    return await studentCollection.doc(document.id).set({
      'studentId': document.id,
      'childId': childId,
      'schoolId': schoolId,
      'academicCalendarId': academicCalendarId,
      'classId': classId,
      'feeId': feeId,
      'activationStatus': activationStatus
    });
  }

  //get all userdetails stream
  Stream<List<studentAcademicCalendarModel>> allStudentAcademicCalendar(
      String studentId) {
    return studentCollection
        .doc(studentId)
        .collection('Student Academic Calendar')
        .snapshots()
        .map(_createStudentAcademicCalendarModelObject);
  }

  //create a list of user model object
  List<studentAcademicCalendarModel> _createStudentAcademicCalendarModelObject(
      QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return studentAcademicCalendarModel(
        studentAcademicCalendarId:
            doc.data().toString().contains('studentAcademicCalendarId')
                ? doc.get('studentAcademicCalendarId')
                : '',
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
        currentStatus: doc.data().toString().contains('currentStatus')
            ? doc.get('currentStatus')
            : '',
      );
    }).toList();
  }

  Future<void> updateStudentAcademicCalendarData(
      String studentId,
      String academicCalendarId,
      String schoolId,
      String classId,
      String teacherId,
      String academicCalendarStartDate,
      String academicCalendarEndDate,
      String currentStatus) async {
    final document = studentCollection
        .doc(studentId)
        .collection('Student Academic Calendar')
        .doc();
    return await studentCollection
        .doc(studentId)
        .collection('Student Academic Calendar')
        .doc(document.id)
        .set({
      'studentAcademicCalendarId': document.id,
      'academicCalendarId': academicCalendarId,
      'schoolId': schoolId,
      'classId': classId,
      'teacherId': teacherId,
      'academicCalendarStartDate': academicCalendarStartDate,
      'academicCalendarEndDate': academicCalendarEndDate,
      'currentStatus': currentStatus
    });
  }
}
