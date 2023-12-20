import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ummicare/models/healthmodel.dart';

class HealthDatabaseService {
  final String childId;
  final String? healthId;
  final String? healthStatusId;
  final String? healthConditionId;
  final String? physicalConditionId;
  final String? chronicConditionId;
  final String? vaccinationAppointmentId;
  final String? clinicId;
  final String? doctorId;

  HealthDatabaseService(
      {required this.childId, this.healthId, this.healthStatusId, this.healthConditionId,
      this.physicalConditionId, this.chronicConditionId, this.vaccinationAppointmentId,
      this.clinicId,this.doctorId});

//------------------------------Health----------------------------------

  //collection reference
  static final CollectionReference healthCollection =
      FirebaseFirestore.instance.collection('Health');


  //get Health stream
  Stream<HealthModel> get healthData {
    return healthCollection
        .doc(healthId)
        .snapshots()
        .map(_createHealthModelObject);
  }

  Stream <List<HealthModel>> get allHealthData{
    return healthCollection
          .snapshots()
          .map(_createHealthModelList);
  }

  //create a Health model object
  HealthModel _createHealthModelObject(DocumentSnapshot snapshot) {
    return HealthModel(
      healthId: snapshot.id,
      childId: snapshot['childId'],
      healthStatusId: snapshot['healthStatusId'],
      currentHeight: snapshot['currentHeight'],
      currentWeight: snapshot['currentWeight'],
      bmi: snapshot['bmi'],
    );
  }

  //create a list of Health model object
  List<HealthModel> _createHealthModelList(QuerySnapshot snapshot) {
    return snapshot.docs.map<HealthModel>((doc) {
      return HealthModel(
        healthId: doc.id,
        childId: doc.get('childId') ?? '',
        healthStatusId: doc.get('healthStatusId') ?? '',
        currentHeight: doc.get('currentHeight') ?? '',
        currentWeight: doc.get('currentWeight') ?? '',
        bmi: doc.get('bmi') ?? '',
      );
    }).toList();
  }


  //create Health data
  Future<void> createHealthData(
      String healthId, String childId, String healthStatusId, double currentHeight, double currentWeight, double bmi) async {
    return await healthCollection.doc(healthId).set({
      'childId': childId,
      'healthStatusId': healthStatusId,
      'currentHeight': currentHeight,
      'currentWeight': currentWeight,
      'bmi' : bmi,
    });
  }

  Future<void> updateHealthData(
    String healthId, String childId, String healthStatusId, double currentHeight, double currentWeight, double bmi) async {
    return await healthCollection.doc(healthId).update({
      'childId': childId,
      'healthStatusId': healthStatusId,
      'currentHeight': currentHeight,
      'currentWeight': currentWeight,
      'bmi' : bmi,
    }).then((value) => print('Data updated successfully!'))
    .catchError((error) => print('Failed to update data: $error'));
  }

  Future<void> updateHeight(
    String healthId, double currentHeight) async {
    return await healthCollection.doc(healthId).update({
      'currentHeight': currentHeight,
    }).then((value) => print('Data updated successfully!'))
    .catchError((error) => print('Failed to update data: $error'));
  }

  Future<void> updateWeight(
    String healthId, double currentWeight) async {
    return await healthCollection.doc(healthId).update({
      'currentWeight': currentWeight,
    }).then((value) => print('Data updated successfully!'))
    .catchError((error) => print('Failed to update data: $error'));
  }

//------------------------------Health Status----------------------------------

  //collection reference
  final CollectionReference healthStatusCollection =
      FirebaseFirestore.instance.collection('Health Status');

  //get specific health status document stream
  Stream<HealthStatusModel> get healthStatusData {
    return healthStatusCollection
        .doc(healthStatusId)
        .snapshots()
        .map(_createHealthStatusModelObject);
  }

  Stream<List<HealthStatusModel>> get allHealthStatusData {
    return healthStatusCollection
        .snapshots()
        .map(_createHealthStatusModelList);
  }

  //create a Health Status model object
  HealthStatusModel _createHealthStatusModelObject(DocumentSnapshot snapshot) {
    return HealthStatusModel(
      healthStatusId: snapshot.id,
      currentTemperature: snapshot['currentTemperature'],
      currentHeartRate: snapshot['currentHeartRate'],
      healthConditionId: snapshot['healthConditionId'],
      physicalConditionId: snapshot['physicalConditionId'],
      chronicConditionId: snapshot['chronicConditionId']
    );
  }

  List<HealthStatusModel> _createHealthStatusModelList(QuerySnapshot snapshot) {
    return snapshot.docs.map<HealthStatusModel>((doc) {
      return HealthStatusModel(
        healthStatusId: doc.id,
        currentTemperature: doc.get('currentTemperature') ?? '',
        currentHeartRate: doc.get('currentHeartRate') ?? '',
        healthConditionId: doc.get('healthConditionId') ?? '',
        physicalConditionId: doc.get('physicalConditionId') ?? '',
        chronicConditionId: doc.get('chronicConditionId') ?? '',
      );
    }).toList();
  }

  //create health status data
  Future<void> createHealthStatusData(
    String healthStatusId,
    String currentTemperature,
    String currentHeartRate,
    String healthConditionId,
    String physicalConditionId,
    String chronicConditionId) async {
    return await healthStatusCollection.doc(healthStatusId).set({
      'currentTemperature': currentTemperature,
      'currentHeartRate': currentHeartRate,
      'healthConditionId': healthConditionId,
      'physicalConditionId': physicalConditionId,
      'chronicConditionId' : chronicConditionId,
    });
  }  

//------------------------------Health Condition----------------------------------
  //collection reference
  final CollectionReference healthConditionCollection =
      FirebaseFirestore.instance.collection('Health Condition');

  //get specific health Condition document stream
  Stream<HealthConditionModel> get healthConditionData {
    return healthConditionCollection
        .doc(healthConditionId)
        .snapshots()
        .map(_createHealthConditionModelObject);
  }

  //create a Health Condition model object
  HealthConditionModel _createHealthConditionModelObject(DocumentSnapshot snapshot) {
    return HealthConditionModel(
      healthConditionId: snapshot.id,
      currentSymptom: snapshot['currentSymptom'],
      currentIllness: snapshot['currentIllness'],
      notes: snapshot['notes']
    );
  }

  //create health condition data
  Future<void> createHealthConditionData(
    String healthConditionId,
    String currentSymptom,
    String currentIllness,
    String notes) async {
    return await healthConditionCollection.doc(healthConditionId).set({
      'currentSysmptom' : currentSymptom,
      'currentIllness' : currentIllness,
      'notes': notes,
    });
  }

//------------------------------Physical Condition----------------------------------
  //collection reference
  final CollectionReference physicalConditionCollection =
      FirebaseFirestore.instance.collection('Physical Condition');

  //get specific physical Condition document stream
  Stream<PhysicalConditionModel> get physicalConditionData {
    return physicalConditionCollection
        .doc(physicalConditionId)
        .snapshots()
        .map(_createPhysicalConditionModelObject);
  }

  //create a Physical Condition model object
  PhysicalConditionModel _createPhysicalConditionModelObject(DocumentSnapshot snapshot) {
    return PhysicalConditionModel(
      physicalConditionId: snapshot.id,
      currentInjury: snapshot['currentInjur'],
      details: snapshot['details']
    );
  }

  //create physical condition data
  Future<void> createPhysicalConditionData(
    String physicalConditionId,
    String currentInjury,
    String details) async {
    return await physicalConditionCollection.doc(physicalConditionId).set({
      'currentInjury': currentInjury,
      'details': details,
    });
  }

  //------------------------------Chronic Condition----------------------------------
  //collection reference
  final CollectionReference chronicConditionCollection =
      FirebaseFirestore.instance.collection('Chronic Condition');

  //get specific chronic Condition document stream
  Stream<ChronicConditionModel> get chronicConditionData {
    return chronicConditionCollection
        .doc(chronicConditionId)
        .snapshots()
        .map(_createChronicConditionModelObject);
  }

  //create a Chronic Condition model object
  ChronicConditionModel _createChronicConditionModelObject(DocumentSnapshot snapshot) {
    return ChronicConditionModel(
      chronicConditionId: snapshot.id,
      childAllergies: snapshot['childAllergies'],
      childChronic: snapshot['childChronic']
    );
  }

  //create chronic condition data
  Future<void> createChronicConditionData(
    String chronicConditionId,
    String childAllergies,
    String childChronic) async {
    return await chronicConditionCollection.doc(chronicConditionId).set({
      'childAllergies': childAllergies,
      'childChronic': childChronic,
    });
  }

  //------------------------------Vaccincation Appointment----------------------------------
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

  //------------------------------Clinic----------------------------------
  //collection reference
  final CollectionReference clinicCollection =
      FirebaseFirestore.instance.collection('Clinic');

  //get specific Clinic document stream
  Stream<ClinicModel> get clinicData {
    return clinicCollection
        .doc(clinicId)
        .snapshots()
        .map(_createClinicModelObject);
  }

  //create a Clinic model object
  ClinicModel _createClinicModelObject(DocumentSnapshot snapshot) {
    return ClinicModel(
      clinicId: snapshot.id,
      clinicName: snapshot['clinicName'],
      clinicAddress: snapshot['clinicAddress'],
      clinicPhoneNumber: snapshot['clinicPhoneNumber']
    );
  }

  //create Clinic data
  Future<void> createClinicData(
    String clinicId,
    String clinicName,
    String clinicAddress,
    String clinicPhoneNumber) async {
    return await clinicCollection.doc(clinicId).set({
      'clinicName': clinicName,
      'clinicAddress': clinicAddress,
      'clinicPhoneNumber': clinicPhoneNumber,
    });
  }

  //------------------------------Doctor----------------------------------
  //collection reference
  final CollectionReference doctorCollection =
      FirebaseFirestore.instance.collection('Doctor');

  //get specific Doctor document stream
  Stream<DoctorModel> get doctorData {
    return doctorCollection
        .doc(doctorId)
        .snapshots()
        .map(_createDoctorModelObject);
  }

  //create a Doctor model object
  DoctorModel _createDoctorModelObject(DocumentSnapshot snapshot) {
    return DoctorModel(
      doctorId: snapshot.id,
      doctorFullName: snapshot['doctorFullName'],
      doctorPhoneNumber: snapshot['doctorPhoneNumber'],
    );
  }

  //create Doctor data
  Future<void> createDoctorData(
    String doctorId,
    String doctorFullName,
    String doctorPhoneNumber) async {
    return await doctorCollection.doc(doctorId).set({
      'doctorFullName': doctorFullName,
      'doctorPhoneNumber': doctorPhoneNumber,
    });
  }
}