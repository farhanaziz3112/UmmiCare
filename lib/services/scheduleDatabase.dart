import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ummicare/models/scheduleModel.dart';

class scheduleDatabase {
  final CollectionReference academicCalendarScheduleCollection =
      FirebaseFirestore.instance.collection('Academic Calendar Schedule');

  Stream<academicCalendarScheduleModel> academicScheduleData(
      String scheduleId) {
    return academicCalendarScheduleCollection
        .doc(scheduleId)
        .snapshots()
        .map(_createAcademicCalendarScheduleModelObject);
  }

  Stream<List<academicCalendarScheduleModel>>
      scheduleDataWithAcademicCalendarIdExamId(
          String academicCalendarId, String examId, String type) {
    return academicCalendarScheduleCollection
        .where('academicCalendarId', isEqualTo: academicCalendarId)
        .where('eventId', isEqualTo: examId)
        .where('type', isEqualTo: type)
        .snapshots()
        .map(_createAcademicCalendarScheduleModelList);
  }

  academicCalendarScheduleModel _createAcademicCalendarScheduleModelObject(
      DocumentSnapshot snapshot) {
    return academicCalendarScheduleModel(
        academicCalendarScheduleId: snapshot.id,
        title: snapshot['title'],
        date: snapshot['date'],
        from: snapshot['from'],
        to: snapshot['to'],
        academicCalendarId: snapshot['academicCalendarId'],
        eventId: snapshot['eventId'],
        type: snapshot['type']);
  }

  List<academicCalendarScheduleModel> _createAcademicCalendarScheduleModelList(
      QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return academicCalendarScheduleModel(
        academicCalendarScheduleId:
            doc.data().toString().contains('academicCalendarScheduleId')
                ? doc.get('academicCalendarScheduleId')
                : '',
        title: doc.data().toString().contains('title') ? doc.get('title') : '',
        date: doc.data().toString().contains('date') ? doc.get('date') : '',
        from: doc.data().toString().contains('from') ? doc.get('from') : '',
        to: doc.data().toString().contains('to') ? doc.get('to') : '',
        academicCalendarId: doc.data().toString().contains('academicCalendarId')
            ? doc.get('academicCalendarId')
            : '',
        eventId:
            doc.data().toString().contains('eventId') ? doc.get('eventId') : '',
        type: doc.data().toString().contains('type') ? doc.get('type') : '',
      );
    }).toList();
  }

  Future<void> updateAcademicCalendarScheduleData(
    String academicCalendarScheduleId,
    String title,
    String date,
    String from,
    String to,
    String academicCalendarId,
    String eventId,
    String type,
  ) async {
    return await academicCalendarScheduleCollection
        .doc(academicCalendarScheduleId)
        .set({
      'academicCalendarScheduleId': academicCalendarScheduleId,
      'title': title,
      'date': date,
      'from': from,
      'to': to,
      'academicCalendarId': academicCalendarId,
      'eventId': eventId,
      'type': type
    });
  }

  Future<void> createAcademicCalendarScheduleData(
    String title,
    String date,
    String from,
    String to,
    String academicCalendarId,
    String eventId,
    String type,
  ) async {
    final document = academicCalendarScheduleCollection.doc();
    return await academicCalendarScheduleCollection.doc(document.id).set({
      'academicCalendarScheduleId': document.id,
      'title': title,
      'date': date,
      'from': from,
      'to': to,
      'academicCalendarId': academicCalendarId,
      'eventId': eventId,
      'type': type
    });
  }

  final CollectionReference scheduleCollection =
      FirebaseFirestore.instance.collection('Schedule');

  Stream<scheduleModel> scheduleData(String scheduleId) {
    return scheduleCollection
        .doc(scheduleId)
        .snapshots()
        .map(_createScheduleModelObject);
  }

  Stream<List<scheduleModel>> scheduleDataWithParentId(String parentId) {
    return scheduleCollection
        .where('parentId', isEqualTo: parentId)
        .snapshots()
        .map(_createScheduleModelList);
  }

  scheduleModel _createScheduleModelObject(DocumentSnapshot snapshot) {
    return scheduleModel(
        scheduleId: snapshot['scheduleId'],
        scheduleTitle: snapshot['scheduleTitle'],
        parentId: snapshot['parentId'],
        childId: snapshot['childId'],
        from: snapshot['from'],
        to: snapshot['to'],
        type: snapshot['type'],
        isAllDay: snapshot['isAllDay'],);
  }

  List<scheduleModel> _createScheduleModelList(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return scheduleModel(
        scheduleId: doc.data().toString().contains('scheduleId')
            ? doc.get('scheduleId')
            : '',
        scheduleTitle: doc.data().toString().contains('scheduleTitle')
            ? doc.get('scheduleTitle')
            : '',
        parentId: doc.data().toString().contains('parentId')
            ? doc.get('parentId')
            : '',
        childId:
            doc.data().toString().contains('childId') ? doc.get('childId') : '',
        from: doc.data().toString().contains('from') ? doc.get('from') : '',
        to: doc.data().toString().contains('to') ? doc.get('to') : '',
        type: doc.data().toString().contains('type') ? doc.get('type') : '',
        isAllDay: doc.data().toString().contains('isAllDay') ? doc.get('isAllDay') : '',
      );
    }).toList();
  }

  Future<void> updateScheduleData(
      String scheduleId,
      String scheduleTitle,
      String parentId,
      String childId,
      String from,
      String to,
      String type,
      String isAllDay) async {
    return await scheduleCollection.doc(scheduleId).set({
      'scheduleId': scheduleId,
      'scheduleTitle': scheduleTitle,
      'parentId': parentId,
      'childId': childId,
      'from': from,
      'to': to,
      'type': type,
      'isAllDay': isAllDay
    });
  }

  Future<void> createScheduleData(
      String scheduleTitle,
      String parentId,
      String childId,
      String from,
      String to,
      String type,
      String isAllDay) async {
    final document = scheduleCollection.doc();
    return await scheduleCollection.doc(document.id).set({
      'scheduleId': document.id,
      'scheduleTitle': scheduleTitle,
      'parentId': parentId,
      'childId': childId,
      'from': from,
      'to': to,
      'type': type,
      'isAllDay': isAllDay
    });
  }
}
