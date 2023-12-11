import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ummicare/models/scheduleModel.dart';

class scheduleDatabase {
  final CollectionReference academicCalendarScheduleCollection =
      FirebaseFirestore.instance.collection('Academic Calendar Schedule');

  Stream<academicCalendarScheduleModel> scheduleData(String scheduleId) {
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
    return await academicCalendarScheduleCollection.doc(academicCalendarScheduleId).set({
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

}
