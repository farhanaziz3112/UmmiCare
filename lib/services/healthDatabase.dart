import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ummicare/models/usermodel.dart';
import 'package:ummicare/models/healthmodel.dart';

class HealthDatabaseService {
  final String childId;
  final String? healthId;
  final String? healthStatusId;

  HealthDatabaseService(
      {required this.childId, this.healthId, this.healthStatusId});

//------------------------------Health----------------------------------

  //collection reference
  static final CollectionReference healthCollection =
      FirebaseFirestore.instance.collection('Health');

  //collection reference
  final CollectionReference healthSubjectsCollection =
      FirebaseFirestore.instance.collection('Health');

  //get Health stream
  Stream<List<HealthModel>> get healthData {
    return healthCollection
        .where('childId', isEqualTo: childId)
        .snapshots()
        .map(_createHealthModelList);
  }

  //create a Health model object
  HealthModel _createHealthModelObject(DocumentSnapshot snapshot) {
    return HealthModel(
      healthId: snapshot.id,
      currentHeight: snapshot['currentHeight'],
      currentWeight: snapshot['currentWeight'],
      childId: snapshot['childId'],
      healthStatusId: snapshot['healthStatusId'],
    );
  }

  //create a list of Health model object
  List<HealthModel> _createHealthModelList(QuerySnapshot snapshot) {
    return snapshot.docs.map<HealthModel>((doc) {
      return HealthModel(
        healthId: doc.id,
        currentHeight: doc.get('currentHeight') ?? '',
        currentWeight: doc.get('currentWeight') ?? '',
        childId: doc.get('childId') ?? '',
        healthStatusId: doc.get('healthStatusId') ?? '',
      );
    }).toList();
  }


  //create Health data
  Future<void> createHealthData(
      String healthId, String childId, String healthStatusId, String currentHeight, String currentWeight) async {
    return await healthCollection.doc(healthId).set({
      'childId': childId,
      'healthStatusId': healthStatusId,
      'currentHeight': currentHeight,
      'currentWeight': currentWeight,
    });
  }

  Future<void> updateHealthData(
    String healthId, String childId, String healthStatusId, String currentHeight, String currentWeight) async {
    return await healthCollection.doc(healthId).update({
      'childId': childId,
      'healthStatusId': healthStatusId,
      'currentHeight': currentHeight,
      'currentWeight': currentWeight,
    }).then((value) => print('Data updated successfully!'))
    .catchError((error) => print('Failed to update data: $error'));;;
  }

  Future<void> updateHeight(
    String healthId, String currentHeight) async {
    return await healthCollection.doc(healthId).update({
      'currentHeight': currentHeight,
    }).then((value) => print('Data updated successfully!'))
    .catchError((error) => print('Failed to update data: $error'));;
  }

  Future<void> updateWeight(
    String healthId, String currentWeight) async {
    return await healthCollection.doc(healthId).update({
      'currentWeight': currentWeight,
    }).then((value) => print('Data updated successfully!'))
    .catchError((error) => print('Failed to update data: $error'));;
  }

//------------------------------HealthStatus----------------------------------

  //collection reference
  final CollectionReference healthStatusCollection =
      FirebaseFirestore.instance.collection('Health Status');

  //get specific health document stream
  Stream<HealthStatusModel> get healthStatusData {
    return healthStatusCollection
        .doc(healthStatusId)
        .snapshots()
        .map(_createHealthStatusModelObject);
  }

  //create a health status model
  HealthStatusModel _createHealthStatusModelObject(DocumentSnapshot snapshot) {
    return HealthStatusModel(
      healthStatusId: snapshot.id,
      currentTemperature: snapshot['currentTemperature'],
      currentHeartRate: snapshot['currentHeartRate'],
      healthConditionId: snapshot['healthConditionId'],
      physicalConditionId: snapshot['physicalConditionId'],
      chronicConditionId: snapshot['chronicConditionId'],
    );
  }

  //create health status data
  Future<void> createHealthStatusData(
    String healthStatusId,
    String healthConditionId,
    String physicalConditionId,
    String chronicConditionId) async {
    return await healthStatusCollection.doc(healthStatusId).set({
      'healthConditionId': healthConditionId,
      'physicalConditionId': physicalConditionId,
      'chronicConditionId' : chronicConditionId,
    });
  }  

//------------------------------HealthCondition----------------------------------
  Future<void> createHealthConditionData(
    String healthID,
    String childID,
    String healthStatusId,
    String currentSymptom,
    String currentTemperature,
    String currentHeartRate, 
    String currentIllness,
    String healthConditionId) async {
    return await healthStatusCollection.doc(healthStatusId).set({
      'currentSysmptom' : currentSymptom,
      'currentTemperature': currentTemperature,
      'currentHeartRate': currentHeartRate,
      'currentIllness' : currentIllness,
      'healthConditionId': healthConditionId,
    });
  }

  Future<void> createPhysicalConditionData(
    String healthID,
    String childID,
    String healthStatusId, 
    String currentInjury,
    String details,
    String physicalConditionId) async {
    return await healthStatusCollection.doc(healthStatusId).set({
      'currentInjury': currentInjury,
      'details': details,
      'physicalConditionId': physicalConditionId,
    });
  }
}