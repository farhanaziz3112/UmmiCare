import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ummicare/models/patientModel.dart';

class PatientDatabaseService {
  //------------------------------Patient----------------------------------
  final CollectionReference patientCollection =
      FirebaseFirestore.instance.collection('Patient');

  //get specific patient document stream
  Stream<patientModel> patientData(String patientId) {
    return patientCollection
        .doc(patientId)
        .snapshots()
        .map(_createPatientModelObject);
  }
  
  //create a patient model object
  patientModel _createPatientModelObject(DocumentSnapshot snapshot) {
    return patientModel(
        patientId: snapshot.id,
        healthId: snapshot['healthId'],
        childId: snapshot['childId'],
        clinicId: snapshot['clinicId'],
        healthStatusId: snapshot['healthStatusId'],
        vaccinationAppointmentId: snapshot['vaccinationAppointmentId'],
        patientProfileImage: snapshot['patientProfileImage'],
        patientName: snapshot['patientName'],
        patientCurrentAge: snapshot['patientCurrentAge'],
    );
  }

  Stream<List<patientModel>> allPatientData (String clinicId){
    return patientCollection
        .where('clinicId', isEqualTo: clinicId)
        .snapshots()
        .map(_createPatientList);
  }

  //create a list of patient model object
  List<patientModel> _createPatientList(QuerySnapshot snapshot) {
    return snapshot.docs.map<patientModel>((doc) {
      return patientModel(
        patientId: doc.id,
        healthId: doc.get('healthId') ?? '',
        childId: doc.get('childId') ?? '',
        clinicId: doc.get('clinicId') ?? '',
        healthStatusId: doc.get('healthStatusId') ?? '',
        vaccinationAppointmentId: doc.get('vaccinationAppointmentId') ?? '',
        patientProfileImage: doc.get('patientProfileImage') ?? '',
        patientName: doc.get('patientName') ?? '',
        patientCurrentAge: doc.get('patientCurrentAge') ?? '',
      );
    }).toList();
  }

  Future<void> updateStudentData(
      String patientId,
      String healthId,
      String childId,
      String clinicId,
      String healthStatusId,
      String vaccinationAppointmentId,
      String patientProfileImage,
      String patientName,
      int patientCurrentAge) async {
    return await patientCollection.doc(patientId).set({
      'patientId': patientId,
      'childId': childId,
      'healthId': healthId,
      'clinicId': clinicId,
      'healthStatusId': healthStatusId,
      'vaccinationAppointmentId': vaccinationAppointmentId,
      'patientProfileImage': patientProfileImage,
      'patientName': patientName,
      'patientCurrentAge': patientCurrentAge,
    });
  }

  Future<void> createStudentData(
      String childId,
      String healthId,
      String clinicId,
      String healthStatusId,
      String vaccinationAppointmentId,
      String patientProfileImage,
      String patientName,
      int patientCurrentAge) async {
    final document = patientCollection.doc();
    return await patientCollection.doc(document.id).set({
      'patientId': document.id,
      'healthId': healthId,
      'childId': childId,
      'clinicId': clinicId,
      'healthStatusId': healthStatusId,
      'vaccinationAppointmentId': vaccinationAppointmentId,
      'patientProfileImage': patientProfileImage,
      'patientName': patientName,
      'patientCurrentAge': patientCurrentAge,
    });
  }

  //------------------------------Vaccination Appointment----------------------------------
  //collection reference
  final CollectionReference vaccinationAppointmentCollection =
      FirebaseFirestore.instance.collection('Vaccination Appointment');

  //get specific Vaccincation Appointment document stream
  Stream<VaccinationAppointmentModel>vaccincationAppointmentData (String vaccinationAppointmentId) {
    return vaccinationAppointmentCollection
      .doc(vaccinationAppointmentId)
      .snapshots()
      .map(_createVaccinationAppointmentModelObject);
  }

  Stream<List<VaccinationAppointmentModel>> get allVaccincationAppointmentData {
    return vaccinationAppointmentCollection
      .snapshots()
      .map(_createVaccinationAppointmentModelList);
  }

  //create a Vaccincation Appointment model object
  VaccinationAppointmentModel _createVaccinationAppointmentModelObject(DocumentSnapshot snapshot) {
    return VaccinationAppointmentModel(
      vaccinationAppointmentId: snapshot.id,
      vaccineType: snapshot['vaccineType'],
      vaccineDate: snapshot['vaccineDate'],
      vaccineTime: snapshot['vaccineTime'],
      healthId: snapshot['healthId'],
      clinicId: snapshot['clinicId'],
      medicalStaffId: snapshot['medicalStaffId']
    );
  }

  List<VaccinationAppointmentModel> _createVaccinationAppointmentModelList(QuerySnapshot snapshot) {
    return snapshot.docs.map<VaccinationAppointmentModel>((doc) {
      return VaccinationAppointmentModel(
        vaccinationAppointmentId: doc.id,
        vaccineType: doc.get('vaccineType') ?? '',
        vaccineDate: doc.get('vaccineDate') ?? '',
        vaccineTime: doc.get('vaccineTime') ?? '',
        healthId: doc.get('healthId') ?? '',
        clinicId: doc.get('clinicId') ?? '',
        medicalStaffId: doc.get('medicalStaffId') ?? '',
      );
    }).toList();
  }

  //create Vaccincation Appointment data
  Future<void> createVaccinationAppointmentData(
    String vaccinationAppointmentId,
    String vaccineType,
    String vaccineDate,
    String vaccineTime,
    String healthId,
    String clinicId,
    String medicalStaffId,) async {
    return await vaccinationAppointmentCollection.doc(vaccinationAppointmentId).set({
      'vaccineType': vaccineType,
      'vaccineDate': vaccineDate,
      'vaccineTime': vaccineTime,
      'healthId': healthId,
      'clinicId': clinicId,
      'medicalStaffId': medicalStaffId,
    });
  }

  Future<void> updateVaccinationAppointmentData(
    String vaccinationAppointmentId,
    String vaccineType,
    String vaccineDate,
    String vaccineTime,
    String healthId,
    String clinicId,
    String medicalStaffId,) async {
    return await vaccinationAppointmentCollection.doc(vaccinationAppointmentId).update({
      'vaccineType': vaccineType,
      'vaccineDate': vaccineDate,
      'vaccineTime': vaccineTime,
      'healthId': healthId,
      'clinicId': clinicId,
      'doctorId': medicalStaffId,
    }).then((value) => print('Data updated successfully!'))
    .catchError((error) => print('Failed to update data: $error'));
  }
}