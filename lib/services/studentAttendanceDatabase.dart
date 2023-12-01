import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ummicare/models/studentAttendanceModel.dart';

class studentAttendanceDatabase {
  final CollectionReference studentAttendanceCollection =
      FirebaseFirestore.instance.collection('Student Attendance');

  //get specific teacher document stream
  Stream<studentAttendanceModel> academicCalendarData(
      String studentAttendanceId) {
    return studentAttendanceCollection
        .doc(studentAttendanceId)
        .snapshots()
        .map(_createStudentAttendanceModelObject);
  }

  //get all userdetails stream
  Stream<List<studentAttendanceModel>>
      allStudentAttendanceWithStudentIdAndSpecificDate(
          String studentId, String day, String month, String year) {
    return studentAttendanceCollection
        .where('studentId', isEqualTo: studentId)
        .where('attendanceDateDay', isEqualTo: day)
        .where('attendanceDateMonth', isEqualTo: month)
        .where('attendanceDateYear', isEqualTo: year)
        .snapshots()
        .map(_createStudentAttendanceModelList);
  }

  //get all userdetails stream
  Stream<List<studentAttendanceModel>>
      allStudentAttendanceWithAcademicCalendarIdAndSpecificDate(
          String academicCalendarId, String day, String month, String year) {
    return studentAttendanceCollection
        .where('academicCalendarId', isEqualTo: academicCalendarId)
        .where('attendanceDateDay', isEqualTo: day)
        .where('attendanceDateMonth', isEqualTo: month)
        .where('attendanceDateYear', isEqualTo: year)
        .snapshots()
        .map(_createStudentAttendanceModelList);
  }

  //create a user model object
  studentAttendanceModel _createStudentAttendanceModelObject(
      DocumentSnapshot snapshot) {
    return studentAttendanceModel(
        studentAttendanceId: snapshot.id,
        studentId: snapshot['studentId'],
        academicCalendarId: snapshot['academicCalendarId'],
        attendanceDateDay: snapshot['attendanceDateDay'],
        attendanceDateMonth: snapshot['attendanceDateMonth'],
        attendanceDateYear: snapshot['attendanceDateYear'],
        recordedTime: snapshot['recordedTime'],
        attendanceStatus: snapshot['attendanceStatus'],
        description: snapshot['description'],);
  }

  //create a list of user model object
  List<studentAttendanceModel> _createStudentAttendanceModelList(
      QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return studentAttendanceModel(
        studentAttendanceId:
            doc.data().toString().contains('studentAttendanceId')
                ? doc.get('studentAttendanceId')
                : '',
        studentId: doc.data().toString().contains('studentId')
            ? doc.get('studentId')
            : '',
        academicCalendarId: doc.data().toString().contains('academicCalendarId')
            ? doc.get('academicCalendarId')
            : '',
        attendanceDateDay: doc.data().toString().contains('attendanceDateDay')
            ? doc.get('attendanceDateDay')
            : '',
        attendanceDateMonth:
            doc.data().toString().contains('attendanceDateMonth')
                ? doc.get('attendanceDateMonth')
                : '',
        attendanceDateYear: doc.data().toString().contains('attendanceDateYear')
            ? doc.get('attendanceDateYear')
            : '',
        recordedTime: doc.data().toString().contains('recordedTime')
            ? doc.get('recordedTime')
            : '',
        attendanceStatus: doc.data().toString().contains('attendanceStatus')
            ? doc.get('attendanceStatus')
            : '',
        description: doc.data().toString().contains('description')
            ? doc.get('description')
            : '',
      );
    }).toList();
  }

  Future<void> updateStudentAttendanceData(
      String studentAttendanceId,
      String studentId,
      String academicCalendarId,
      String attendanceDateDay,
      String attendanceDateMonth,
      String attendanceDateYear,
      String recordedTime,
      String attendanceStatus,
      String description) async {
    return await studentAttendanceCollection.doc(studentAttendanceId).set({
      'studentAttendanceId': studentAttendanceId,
      'studentId': studentId,
      'academicCalendarId': academicCalendarId,
      'attendanceDateDay': attendanceDateDay,
      'attendanceDateMonth': attendanceDateMonth,
      'attendanceDateYear': attendanceDateYear,
      'recordedTime': recordedTime,
      'attendanceStatus': attendanceStatus,
      'description': description
    });
  }

  Future<void> createStudentAttendanceData(
      String studentId,
      String academicCalendarId,
      String attendanceDateDay,
      String attendanceDateMonth,
      String attendanceDateYear,
      String recordedTime,
      String attendanceStatus,
      String description) async {
    final document = studentAttendanceCollection.doc();
    return await studentAttendanceCollection.doc(document.id).set({
      'studentAttendanceId': document.id,
      'studentId': studentId,
      'academicCalendarId': academicCalendarId,
      'attendanceDateDay': attendanceDateDay,
      'attendanceDateMonth': attendanceDateMonth,
      'attendanceDateYear': attendanceDateYear,
      'recordedTime': recordedTime,
      'attendanceStatus': attendanceStatus,
      'description': description
    });
  }
}
