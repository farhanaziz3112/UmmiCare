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

  Future<void> addStudents(String academicCalendarId, String studentId) async {
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

  final CollectionReference withdrawalRequestCollection =
      FirebaseFirestore.instance.collection('Class Withdrawal Request');

  Stream<withdrawalRequestModel> withdrawalRequestData(
      String withdrawalRequestId) {
    return withdrawalRequestCollection
        .doc(withdrawalRequestId)
        .snapshots()
        .map(_createWithdrawalRequestModelObject);
  }

  withdrawalRequestModel _createWithdrawalRequestModelObject(
      DocumentSnapshot snapshot) {
    return withdrawalRequestModel(
      withdrawalRequestModelId: snapshot.id,
      academicCalendarId: snapshot['academicCalendarId'],
      classId: snapshot['classId'],
      schoolId: snapshot['schoolId'],
      teacherId: snapshot['teacherId'],
      studentId: snapshot['studentId'],
      reason: snapshot['reason'],
      supportingImage: snapshot['supportingImage'],
      createdAt: snapshot['createdAt'],
      status: snapshot['status'],
    );
  }

  //create a list of user model object
  List<withdrawalRequestModel> _createWithdrawalRequestModelList(
      QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return withdrawalRequestModel(
        withdrawalRequestModelId:
            doc.data().toString().contains('withdrawalRequestModelId')
                ? doc.get('withdrawalRequestModelId')
                : '',
        academicCalendarId: doc.data().toString().contains('academicCalendarId')
            ? doc.get('academicCalendarId')
            : '',
        classId:
            doc.data().toString().contains('classId') ? doc.get('classId') : '',
        schoolId: doc.data().toString().contains('schoolId')
            ? doc.get('schoolId')
            : '',
        teacherId: doc.data().toString().contains('teacherId')
            ? doc.get('teacherId')
            : '',
        studentId: doc.data().toString().contains('studentId')
            ? doc.get('studentId')
            : '',
        reason:
            doc.data().toString().contains('reason') ? doc.get('reason') : '',
        supportingImage: doc.data().toString().contains('supportingImage')
            ? doc.get('supportingImage')
            : '',
        createdAt: doc.data().toString().contains('createdAt')
            ? doc.get('createdAt')
            : '',
        status:
            doc.data().toString().contains('status') ? doc.get('status') : '',
      );
    }).toList();
  }

  Future<void> updateWithdrawalRequestData(
      String withdrawalRequestModelId,
      String academicCalendarId,
      String classId,
      String schoolId,
      String teacherId,
      String studentId,
      String reason,
      String supportingImage,
      String createdAt,
      String status) async {
    return await withdrawalRequestCollection.doc(withdrawalRequestModelId).set({
      'withdrawalRequestModelId': withdrawalRequestModelId,
      'academicCalendarId': academicCalendarId,
      'classId': classId,
      'schoolId': schoolId,
      'teacherId': teacherId,
      'studentId': studentId,
      'reason': reason,
      'supportingImage': supportingImage,
      'createdAt': createdAt,
      'status': status
    });
  }

  Future<void> createWithdrawalRequestData(
      String academicCalendarId,
      String classId,
      String schoolId,
      String teacherId,
      String studentId,
      String reason,
      String supportingImage,
      String createdAt,
      String status) async {
    final document = withdrawalRequestCollection.doc();
    return await withdrawalRequestCollection.doc(document.id).set({
      'withdrawalRequestModelId': document.id,
      'academicCalendarId': academicCalendarId,
      'classId': classId,
      'schoolId': schoolId,
      'teacherId': teacherId,
      'studentId': studentId,
      'reason': reason,
      'supportingImage': supportingImage,
      'createdAt': createdAt,
      'status': status
    });
  }

  final CollectionReference classEventCollection =
      FirebaseFirestore.instance.collection('Class Event');

  Stream<classEvent> classEventData(String classEventId) {
    return classEventCollection
        .doc(classEventId)
        .snapshots()
        .map(_createClassEventModelObject);
  }

  classEvent _createClassEventModelObject(DocumentSnapshot snapshot) {
    return classEvent(
      classEventId: snapshot.id,
      academicCalendarId: snapshot['academicCalendarId'],
      eventName: snapshot['eventName'],
      eventDescription: snapshot['eventDescription'],
      eventStartDate: snapshot['eventStartDate'],
      eventEndDate: snapshot['eventEndDate'],
      createdAt: snapshot['createdAt'],
    );
  }

  //create a list of user model object
  List<classEvent> _createClassEventModelList(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return classEvent(
        classEventId: doc.data().toString().contains('classEventId')
            ? doc.get('classEventId')
            : '',
        academicCalendarId: doc.data().toString().contains('academicCalendarId')
            ? doc.get('academicCalendarId')
            : '',
        eventName: doc.data().toString().contains('eventName')
            ? doc.get('eventName')
            : '',
        eventDescription: doc.data().toString().contains('eventDescription')
            ? doc.get('eventDescription')
            : '',
        eventStartDate: doc.data().toString().contains('eventStartDate')
            ? doc.get('eventStartDate')
            : '',
        eventEndDate: doc.data().toString().contains('eventEndDate')
            ? doc.get('eventEndDate')
            : '',
        createdAt: doc.data().toString().contains('createdAt')
            ? doc.get('createdAt')
            : '',
      );
    }).toList();
  }

  Future<void> updateClassEventData(
      String classEventId,
      String academicCalendarId,
      String eventName,
      String eventDescription,
      String eventStartDate,
      String eventEndDate,
      String createdAt) async {
    return await classEventCollection.doc(classEventId).set({
      'classEventId': classEventId,
      'academicCalendarId': academicCalendarId,
      'eventName': eventName,
      'eventDescription': eventDescription,
      'eventStartDate': eventStartDate,
      'eventEndDate': eventEndDate,
      'createdAt': createdAt,
    });
  }

  Future<void> createClassEventData(
      String academicCalendarId,
      String eventName,
      String eventDescription,
      String eventStartDate,
      String eventEndDate,
      String createdAt) async {
    final document = classEventCollection.doc();
    return await classEventCollection.doc(document.id).set({
      'classEventId': document.id,
      'academicCalendarId': academicCalendarId,
      'eventName': eventName,
      'eventDescription': eventDescription,
      'eventStartDate': eventStartDate,
      'eventEndDate': eventEndDate,
      'createdAt': createdAt,
    });
  }

  final CollectionReference classAnnouncementCollection =
      FirebaseFirestore.instance.collection('Class Announcement');

  Stream<classAnnouncement> classAnnouncementData(String classAnnouncementId) {
    return classAnnouncementCollection
        .doc(classAnnouncementId)
        .snapshots()
        .map(_createClassAnnouncementModelObject);
  }

  classAnnouncement _createClassAnnouncementModelObject(
      DocumentSnapshot snapshot) {
    return classAnnouncement(
      classAnnouncementId: snapshot.id,
      academicCalendarId: snapshot['academicCalendarId'],
      announcementTitle: snapshot['announcementTitle'],
      announcementDescription: snapshot['announcementDescription'],
      createdAt: snapshot['createdAt'],
    );
  }

  //create a list of user model object
  List<classAnnouncement> _createClassAnnouncementModelList(
      QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return classAnnouncement(
        classAnnouncementId:
            doc.data().toString().contains('classAnnouncementId')
                ? doc.get('classAnnouncementId')
                : '',
        academicCalendarId: doc.data().toString().contains('academicCalendarId')
            ? doc.get('academicCalendarId')
            : '',
        announcementTitle: doc.data().toString().contains('announcementTitle')
            ? doc.get('announcementTitle')
            : '',
        announcementDescription:
            doc.data().toString().contains('announcementDescription')
                ? doc.get('announcementDescription')
                : '',
        createdAt: doc.data().toString().contains('createdAt')
            ? doc.get('createdAt')
            : '',
      );
    }).toList();
  }

  Future<void> updateClassAnnouncementData(
      String classAnnouncementId,
      String academicCalendarId,
      String announcementTitle,
      String announcementDescription,
      String createdAt) async {
    return await classAnnouncementCollection.doc(classAnnouncementId).set({
      'classAnnouncementId': classAnnouncementId,
      'academicCalendarId': academicCalendarId,
      'announcementTitle': announcementTitle,
      'announcementDescription': announcementDescription,
      'createdAt': createdAt,
    });
  }

  Future<void> createClassAnnouncementData(
      String academicCalendarId,
      String announcementTitle,
      String announcementDescription,
      String createdAt) async {
    final document = classAnnouncementCollection.doc();
    return await classAnnouncementCollection.doc(document.id).set({
      'classAnnouncementId': document.id,
      'academicCalendarId': academicCalendarId,
      'announcementTitle': announcementTitle,
      'announcementDescription': announcementDescription,
      'createdAt': createdAt,
    });
  }
}
