import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ummicare/models/vaccinationAppointmentModel.dart';

class VaccinationAppointmentDatabaseService {
  final String healthId;
  final String? vaccinationAppointmentId;

  VaccinationAppointmentDatabaseService(
    {required this.healthId, this.vaccinationAppointmentId}
  );

  //collection reference
  final CollectionReference vaccinationAppointmentCollection =
      FirebaseFirestore.instance.collection('Vaccination Appointment');

  //get specific Vaccincation Appointment document stream
  Stream<VaccinationAppointmentModel> get vaccincationAppointmentData {
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
      doctorId: snapshot['doctorId']
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
        doctorId: doc.get('doctorId') ?? '',
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
    String doctorId,) async {
    return await vaccinationAppointmentCollection.doc(vaccinationAppointmentId).set({
      'vaccineType': vaccineType,
      'vaccineDate': vaccineDate,
      'vaccineTime': vaccineTime,
      'healthId': healthId,
      'clinicId': clinicId,
      'doctorId': doctorId,
    });
  }

  Future<void> updateVaccinationAppointmentData(
    String vaccinationAppointmentId,
    String vaccineType,
    String vaccineDate,
    String vaccineTime,
    String healthId,
    String clinicId,
    String doctorId,) async {
    return await vaccinationAppointmentCollection.doc(vaccinationAppointmentId).update({
      'vaccineType': vaccineType,
      'vaccineDate': vaccineDate,
      'vaccineTime': vaccineTime,
      'healthId': healthId,
      'clinicId': clinicId,
      'doctorId': doctorId,
    }).then((value) => print('Data updated successfully!'))
    .catchError((error) => print('Failed to update data: $error'));
  }
}