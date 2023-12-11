import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ummicare/models/studentAttendanceModel.dart';

class studentAttendanceDatabase {
  final CollectionReference studentAttendanceCollection =
      FirebaseFirestore.instance.collection('Student Attendance');

  Stream<studentAttendanceModel> studentAttendanceData(
      String studentAttendanceId) {
    return studentAttendanceCollection
        .doc(studentAttendanceId)
        .snapshots()
        .map(_createStudentAttendanceModelObject);
  }

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

  Stream<List<studentAttendanceModel>>
      allStudentAttendanceWithStudentIdAndMonth(
          String studentId, String month) {
    return studentAttendanceCollection
        .where('studentId', isEqualTo: studentId)
        .where('attendanceDateMonth', isEqualTo: month)
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
      description: snapshot['description'],
    );
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

  final CollectionReference studentLeaveCollection =
      FirebaseFirestore.instance.collection('Student Leave');

  Stream<studentLeaveModel> studentLeaveData(String studentLeaveId) {
    return studentLeaveCollection
        .doc(studentLeaveId)
        .snapshots()
        .map(_createStudentLeaveModelObject);
  }

  Stream<List<studentLeaveModel>> allStudentLeaveWithStudentId(
      String studentId) {
    return studentLeaveCollection
        .where('studentId', isEqualTo: studentId)
        .snapshots()
        .map(_createStudentLeaveModelList);
  }

  //create a user model object
  studentLeaveModel _createStudentLeaveModelObject(DocumentSnapshot snapshot) {
    return studentLeaveModel(
      studentLeaveId: snapshot.id,
      studentId: snapshot['studentId'],
      reason: snapshot['reason'],
      leaveDate: snapshot['leaveDate'],
      leaveProofImg: snapshot['leaveProofImg'],
      status: snapshot['status'],
    );
  }

  //create a list of user model object
  List<studentLeaveModel> _createStudentLeaveModelList(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return studentLeaveModel(
        studentLeaveId: doc.data().toString().contains('studentLeaveId')
            ? doc.get('studentLeaveId')
            : '',
        studentId: doc.data().toString().contains('studentId')
            ? doc.get('studentId')
            : '',
        reason:
            doc.data().toString().contains('reason') ? doc.get('reason') : '',
        leaveDate: doc.data().toString().contains('leaveDate')
            ? doc.get('leaveDate')
            : '',
        leaveProofImg: doc.data().toString().contains('leaveProofImg')
            ? doc.get('leaveProofImg')
            : '',
        status:
            doc.data().toString().contains('status') ? doc.get('status') : '',
      );
    }).toList();
  }

  Future<void> updateStudentLeaveData(String studentLeaveId, String studentId,
      String reason, String leaveDate, String leaveProofImg, String status) async {
    return await studentLeaveCollection.doc(studentLeaveId).set({
      'studentLeaveId': studentLeaveId,
      'studentId': studentId,
      'reason': reason,
      'leaveDate': leaveDate,
      'leaveProofImg': leaveProofImg,
      'status': status
    });
  }

  Future<void> createStudentLeaveData(
      String studentId, String reason, String leaveDate, String leaveProofImg, String status) async {
    final document = studentLeaveCollection.doc();
    return await studentLeaveCollection.doc(document.id).set({
      'studentLeaveId': document.id,
      'studentId': studentId,
      'reason': reason,
      'leaveDate': leaveDate,
      'leaveProofImg': leaveProofImg,
      'status': status
    });
  }
}
