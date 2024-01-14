import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ummicare/models/examinationModel.dart';

class examDatabase {
  final CollectionReference examCollection =
      FirebaseFirestore.instance.collection('Exam');

  final CollectionReference examResultCollection =
      FirebaseFirestore.instance.collection('Exam Result');

  final CollectionReference subjectResultCollection =
      FirebaseFirestore.instance.collection('Subject Result');

  //Exam database

  Stream<examModel> examData(String examId) {
    return examCollection.doc(examId).snapshots().map(_createExamModelObject);
  }

  Stream<List<examModel>> allExamDataWithAcademicCalendarId(
      String academicCalendarId) {
    return examCollection
        .where('academicCalendarId', isEqualTo: academicCalendarId)
        .snapshots()
        .map(_createExamModelList);
  }

  Stream<List<subjectResultModel>> allSubjectResultDataWithAcademicCalendarAndStudentId(
      String studentId, String academicCalendarId) {
    return subjectResultCollection
        .where('studentId', isEqualTo: studentId)
        .where('academicCalendarId', isEqualTo: academicCalendarId)
        .snapshots()
        .map(_createSubjectResultModelList);
  }

  //create a user model object
  examModel _createExamModelObject(DocumentSnapshot snapshot) {
    return examModel(
        examId: snapshot.id,
        academicCalendarId: snapshot['academicCalendarId'],
        examTitle: snapshot['examTitle'],
        examStartDate: snapshot['examStartDate'],
        examEndDate: snapshot['examEndDate'],
        examStatus: snapshot['examStatus']);
  }

  //create a list of user model object
  List<examModel> _createExamModelList(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return examModel(
        examId:
            doc.data().toString().contains('examId') ? doc.get('examId') : '',
        academicCalendarId: doc.data().toString().contains('academicCalendarId')
            ? doc.get('academicCalendarId')
            : '',
        examTitle: doc.data().toString().contains('examTitle')
            ? doc.get('examTitle')
            : '',
        examStartDate: doc.data().toString().contains('examStartDate')
            ? doc.get('examStartDate')
            : '',
        examEndDate: doc.data().toString().contains('examEndDate')
            ? doc.get('examEndDate')
            : '',
        examStatus: doc.data().toString().contains('examStatus')
            ? doc.get('examStatus')
            : '',
      );
    }).toList();
  }

  Future<void> updateExamData(
      String examId,
      String academicCalendarId,
      String examTitle,
      String examStartDate,
      String examEndDate,
      String examStatus) async {
    return await examCollection.doc(examId).set({
      'examId': examId,
      'academicCalendarId': academicCalendarId,
      'examTitle': examTitle,
      'examStartDate': examStartDate,
      'examEndDate': examEndDate,
      'examStatus': examStatus
    });
  }

  Future<void> createExamData(String academicCalendarId, String examTitle,
      String examStartDate, String examEndDate, String examStatus) async {
    final document = examCollection.doc();
    return await examCollection.doc(document.id).set({
      'examId': document.id,
      'academicCalendarId': academicCalendarId,
      'examTitle': examTitle,
      'examStartDate': examStartDate,
      'examEndDate': examEndDate,
      'examStatus': examStatus
    });
  }

  //Exam Result Database

  Stream<examResultModel> examResultData(String examResultId) {
    return examResultCollection
        .doc(examResultId)
        .snapshots()
        .map(_createExamResultModelObject);
  }

  Stream<List<examResultModel>> allExamResultDataWithExamId(String examId) {
    return examResultCollection
        .where('examId', isEqualTo: examId)
        .snapshots()
        .map(_createExamResultModelList);
  }

  examResultModel _createExamResultModelObject(DocumentSnapshot snapshot) {
    return examResultModel(
        examResultId: snapshot.id,
        examId: snapshot['examId'],
        academicCalendarId: snapshot['academicCalendarId'],
        studentId: snapshot['studentId'],
        examOverallResult: snapshot['examOverallResult']);
  }

  List<examResultModel> _createExamResultModelList(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return examResultModel(
        examResultId: doc.data().toString().contains('examResultId')
            ? doc.get('examResultId')
            : '',
        examId:
            doc.data().toString().contains('examId') ? doc.get('examId') : '',
        academicCalendarId: doc.data().toString().contains('academicCalendarId')
            ? doc.get('academicCalendarId')
            : '',
        studentId: doc.data().toString().contains('studentId')
            ? doc.get('studentId')
            : '',
        examOverallResult: doc.data().toString().contains('examOverallResult')
            ? doc.get('examOverallResult')
            : '',
      );
    }).toList();
  }

  Future<void> updateExamResultData(
      String examResultId,
      String examId,
      String academicCalendarId,
      String studentId,
      String examOverallResult) async {
    return await examResultCollection.doc(examResultId).set({
      'examResultId': examResultId,
      'examId': examId,
      'academicCalendarId': academicCalendarId,
      'studentId': studentId,
      'examOverallResult': examOverallResult
    });
  }

  Future<void> createExamResultData(String examId, String academicCalendarId,
      String studentId, String examOverallResult) async {
    final document = examResultCollection.doc();
    return await examResultCollection.doc(document.id).set({
      'examResultId': document.id,
      'examId': examId,
      'academicCalendarId': academicCalendarId,
      'studentId': studentId,
      'examOverallResult': examOverallResult
    });
  }

  //Subject Result Database

  Stream<subjectResultModel> subjectResultData(String subjectResultId) {
    return subjectResultCollection
        .doc(subjectResultId)
        .snapshots()
        .map(_createSubjectResultModelObject);
  }

  Stream<List<subjectResultModel>> allSubjectResultDataWithExamId(
      String examResultId) {
    return subjectResultCollection
        .where('examResultId', isEqualTo: examResultId)
        .snapshots()
        .map(_createSubjectResultModelList);
  }

  Stream<List<subjectResultModel>> subjectResultDataWithStudentIdAndSubjectId(
      String studentId, String subjectId, String examId) {
    return subjectResultCollection
        .where('studentId', isEqualTo: studentId)
        .where('subjectId', isEqualTo: subjectId)
        .where('examId', isEqualTo: examId)
        .snapshots()
        .map(_createSubjectResultModelList);
  }

  Stream<List<subjectResultModel>> subjectResultDataWithStudentIdExamId(
      String studentId, String examId) {
    return subjectResultCollection
        .where('studentId', isEqualTo: studentId)
        .where('examId', isEqualTo: examId)
        .snapshots()
        .map(_createSubjectResultModelList);
  }

  Stream<List<subjectResultModel>> subjectResultDataWithSubjectIdAndExamId(
      String subjectId, String examId) {
    return subjectResultCollection
        .where('subjectId', isEqualTo: subjectId)
        .where('examId', isEqualTo: examId)
        .snapshots()
        .map(_createSubjectResultModelList);
  }

  subjectResultModel _createSubjectResultModelObject(
      DocumentSnapshot snapshot) {
    return subjectResultModel(
        subjectResultId: snapshot.id,
        subjectId: snapshot['subjectId'],
        examId: snapshot['examId'],
        examResultId: snapshot['examResultId'],
        studentId: snapshot['studentId'],
        academicCalendarId: snapshot['academicCalendarId'],
        subjectMark: snapshot['subjectMark'],
        subjectGrade: snapshot['subjectGrade'],
        subjectGradeStatus: snapshot['subjectGradeStatus']);
  }

  List<subjectResultModel> _createSubjectResultModelList(
      QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return subjectResultModel(
        subjectResultId: doc.data().toString().contains('subjectResultId')
            ? doc.get('subjectResultId')
            : '',
        subjectId: doc.data().toString().contains('subjectId')
            ? doc.get('subjectId')
            : '',
        examId: doc.data().toString().contains('examId')
            ? doc.get('examId')
            : '',
        examResultId: doc.data().toString().contains('examResultId')
            ? doc.get('examResultId')
            : '',
        studentId: doc.data().toString().contains('studentId')
            ? doc.get('studentId')
            : '',
        academicCalendarId: doc.data().toString().contains('academicCalendarId')
            ? doc.get('academicCalendarId')
            : '',
        subjectMark: doc.data().toString().contains('subjectMark')
            ? doc.get('subjectMark')
            : '',
        subjectGrade: doc.data().toString().contains('subjectGrade')
            ? doc.get('subjectGrade')
            : '',
        subjectGradeStatus: doc.data().toString().contains('subjectGradeStatus')
            ? doc.get('subjectGradeStatus')
            : '',
      );
    }).toList();
  }

  Future<void> updateSubjectResultData(
      String subjectResultId,
      String subjectId,
      String examId,
      String examResultId,
      String studentId,
      String academicCalendarId,
      String subjectMark,
      String subjectGrade,
      String subjectGradeStatus) async {
    return await subjectResultCollection.doc(subjectResultId).set({
      'subjectResultId': subjectResultId,
      'subjectId': subjectId,
      'examId': examId,
      'examResultId': examResultId,
      'studentId': studentId,
      'academicCalendarId': academicCalendarId,
      'subjectMark': subjectMark,
      'subjectGrade': subjectGrade,
      'subjectGradeStatus': subjectGradeStatus
    });
  }

  Future<void> createSubjectResultData(
      String subjectId,
      String examId,
      String examResultId,
      String studentId,
      String academicCalendarId,
      String subjectMark,
      String subjectGrade,
      String subjectGradeStatus) async {
    final document = subjectResultCollection.doc();
    return await subjectResultCollection.doc(document.id).set({
      'subjectResultId': document.id,
      'subjectId': subjectId,
      'examId': examId,
      'examResultId': examResultId,
      'studentId': studentId,
      'academicCalendarId': academicCalendarId,
      'subjectMark': subjectMark,
      'subjectGrade': subjectGrade,
      'subjectGradeStatus': subjectGradeStatus
    });
  }
}
