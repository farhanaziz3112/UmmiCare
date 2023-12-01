import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ummicare/models/feeModel.dart';

class feeDatabase {
  final CollectionReference feeCollection =
      FirebaseFirestore.instance.collection('Fee');

  final CollectionReference feePaymentCollection =
      FirebaseFirestore.instance.collection('Fee Payment');

  Stream<feeModel> feeData(String academicCalendarId) {
    return feeCollection
        .doc(academicCalendarId)
        .snapshots()
        .map(_createFeeModelObject);
  }

  Stream<List<feeModel>> allFeeDataWithAcademicCalendarId(
      String academicCalendarId) {
    return feeCollection
        .where('academicCalendarId', isEqualTo: academicCalendarId)
        .snapshots()
        .map(_createFeeModelList);
  }

  //create a user model object
  feeModel _createFeeModelObject(DocumentSnapshot snapshot) {
    return feeModel(
        feeId: snapshot.id,
        academicCalendarId: snapshot['academicCalendarId'],
        feeTitle: snapshot['feeTitle'],
        feeAmount: snapshot['feeAmount'],
        feeDescription: snapshot['feeDescription'],
        feeDeadline: snapshot['feeDeadline']);
  }

  //create a list of user model object
  List<feeModel> _createFeeModelList(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return feeModel(
        feeId: doc.data().toString().contains('feeId') ? doc.get('feeId') : '',
        academicCalendarId: doc.data().toString().contains('academicCalendarId')
            ? doc.get('academicCalendarId')
            : '',
        feeTitle: doc.data().toString().contains('feeTitle')
            ? doc.get('feeTitle')
            : '',
        feeAmount: doc.data().toString().contains('feeAmount')
            ? doc.get('feeAmount')
            : '',
        feeDescription: doc.data().toString().contains('feeDescription')
            ? doc.get('feeDescription')
            : '',
        feeDeadline: doc.data().toString().contains('feeDeadline')
            ? doc.get('feeDeadline')
            : '',
      );
    }).toList();
  }

  Future<void> updateFeeData(String feeId, String academicCalendarId, String feeTitle,
      String feeAmount, String feeDescription, String feeDeadline) async {
    return await feeCollection.doc(feeId).set({
      'feeId': feeId,
      'academicCalendarId': academicCalendarId,
      'feeTitle': feeTitle,
      'feeAmount': feeAmount,
      'feeDescription': feeDescription,
      'feeDeadline': feeDeadline
    });
  }

  Future<void> createFeeData(String academicCalendarId, String feeTitle, String feeAmount,
      String feeDescription, String feeDeadline) async {
    final document = feeCollection.doc();
    return await feeCollection.doc(document.id).set({
      'feeId': document.id,
      'academicCalendarId': academicCalendarId,
      'feeTitle': feeTitle,
      'feeAmount': feeAmount,
      'feeDescription': feeDescription,
      'feeDeadline': feeDeadline
    });
  }

  Stream<feePaymentModel> feePaymentData(String feePaymentId) {
    return feePaymentCollection
        .doc(feePaymentId)
        .snapshots()
        .map(_createFeePaymentModelObject);
  }

  Stream<List<feePaymentModel>>
      allFeePaymentDataWithAcademicCalendarIdAndStudentId(
          String academicCalendarId, String studentId) {
    return feePaymentCollection
        .where('academicCalendarId', isEqualTo: academicCalendarId)
        .where('studentId', isEqualTo: studentId)
        .snapshots()
        .map(_createFeePaymentModelList);
  }

  Stream<List<feePaymentModel>>
      allFeePaymentDataWithAcademicCalendarIdFeeIdAndPaymentStatus(
          String academicCalendarId, String feeId, String feePaymentStatus) {
    return feePaymentCollection
        .where('academicCalendarId', isEqualTo: academicCalendarId)
        .where('feeId', isEqualTo: feeId)
        .where('feePaymentStatus', isEqualTo: feePaymentStatus)
        .snapshots()
        .map(_createFeePaymentModelList);
  }

  Stream<List<feePaymentModel>>
      allFeePaymentDataWithAcademicCalendarIdStudentIdPaymentStatus(
          String academicCalendarId, String feePaymentStatus, String studentId) {
    return feePaymentCollection
        .where('academicCalendarId', isEqualTo: academicCalendarId)
        .where('feePaymentStatus', isEqualTo: feePaymentStatus)
        .where('studentId', isEqualTo: studentId)
        .snapshots()
        .map(_createFeePaymentModelList);
  }

  //create a user model object
  feePaymentModel _createFeePaymentModelObject(DocumentSnapshot snapshot) {
    return feePaymentModel(
        feePaymentId: snapshot.id,
        feeId: snapshot['feeId'],
        studentId: snapshot['studentId'],
        academicCalendarId: snapshot['academicCalendarId'],
        feePaymentAmountPaid: snapshot['feePaymentAmountPaid'],
        feePaymentStatus: snapshot['feePaymentStatus'],
        feePaymentDate: snapshot['feePaymentDate'],
        feePaymentProofImg: snapshot['feePaymentProofImg']);
  }

  //create a list of user model object
  List<feePaymentModel> _createFeePaymentModelList(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return feePaymentModel(
        feePaymentId: doc.data().toString().contains('feePaymentId')
            ? doc.get('feePaymentId')
            : '',
        feeId: doc.data().toString().contains('feeId') ? doc.get('feeId') : '',
        studentId: doc.data().toString().contains('studentId')
            ? doc.get('studentId')
            : '',
        academicCalendarId: doc.data().toString().contains('academicCalendarId')
            ? doc.get('academicCalendarId')
            : '',
        feePaymentAmountPaid:
            doc.data().toString().contains('feePaymentAmountPaid')
                ? doc.get('feePaymentAmountPaid')
                : '',
        feePaymentStatus: doc.data().toString().contains('feePaymentStatus')
            ? doc.get('feePaymentStatus')
            : '',
        feePaymentDate: doc.data().toString().contains('feePaymentDate')
            ? doc.get('feePaymentDate')
            : '',
        feePaymentProofImg: doc.data().toString().contains('feePaymentProofImg')
            ? doc.get('feePaymentProofImg')
            : '',
      );
    }).toList();
  }

  Future<void> updateFeePaymentData(
      String feePaymentId,
      String feeId,
      String studentId,
      String academicCalendarId,
      String feePaymentAmountPaid,
      String feePaymentStatus,
      String feePaymentDate,
      String feePaymentProofImg) async {
    return await feePaymentCollection.doc(feePaymentId).set({
      'feePaymentId': feePaymentId,
      'feeId': feeId,
      'studentId': studentId,
      'academicCalendarId': academicCalendarId,
      'feePaymentAmountPaid': feePaymentAmountPaid,
      'feePaymentStatus': feePaymentStatus,
      'feePaymentDate': feePaymentDate,
      'feePaymentProofImg': feePaymentProofImg
    });
  }

  Future<void> createFeePaymentData(
      String feeId,
      String studentId,
      String academicCalendarId,
      String feePaymentAmountPaid,
      String feePaymentStatus,
      String feePaymentDate,
      String feePaymentProofImg) async {
    final document = feePaymentCollection.doc();
    return await feePaymentCollection.doc(document.id).set({
      'feePaymentId': document.id,
      'feeId': feeId,
      'studentId': studentId,
      'academicCalendarId': academicCalendarId,
      'feePaymentAmountPaid': feePaymentAmountPaid,
      'feePaymentStatus': feePaymentStatus,
      'feePaymentDate': feePaymentDate,
      'feePaymentProofImg': feePaymentProofImg
    });
  }
}
