import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ummicare/models/healthModel.dart';
import 'package:ummicare/models/healthstatusmodel.dart';

class healthDatabaseService {
//------------------------------Health----------------------------------

  //collection reference
  final CollectionReference healthCollection =
      FirebaseFirestore.instance.collection('Health');


  //get Health stream
  Stream<healthModel> healthData (String healthId) {
    return healthCollection
        .doc(healthId)
        .snapshots()
        .map(_createHealthModelObject);
  }

  Stream <List<healthModel>> get allHealthData{
    return healthCollection
          .snapshots()
          .map(_createHealthModelList);
  }

  //create a Health model object
  healthModel _createHealthModelObject(DocumentSnapshot snapshot) {
    return healthModel(
      healthId: snapshot.id,
      childId: snapshot['childId'],
      healthStatusId: snapshot['healthStatusId'],
    );
  }

  //create a list of Health model object
  List<healthModel> _createHealthModelList(QuerySnapshot snapshot) {
    return snapshot.docs.map<healthModel>((doc) {
      return healthModel(
        healthId: doc.id,
        childId: doc.get('childId'),
        healthStatusId: doc.get('healthStatusId'),
      );
    }).toList();
  }


  //create Health data
  Future<void> createHealthData(
      String healthId, 
      String childId, 
      String healthStatusId, 
    ) async {
    return await healthCollection.doc(healthId).set({
      'childId': childId,
      'healthStatusId': healthStatusId,
    });
  }

  //--------------------------------------Bmi------------------------------------

  //collection reference
  final CollectionReference bmiCollection =
      FirebaseFirestore.instance.collection('Bmi');

  //get specific health status document stream
  Stream<BmiModel> bmiData (bmiId) {
    return bmiCollection
        .doc(bmiId)
        .snapshots()
        .map(_createBmiModelObject);
  }

  Stream<List<BmiModel>> get allBmiData {
    return bmiCollection
        .snapshots()
        .map(_createBmiModelList);
  }

  //create a Health Status model object
  BmiModel _createBmiModelObject(DocumentSnapshot snapshot) {
    Timestamp createdAt = snapshot['createdAt'];
    DateTime creationTime = createdAt.toDate();

    return BmiModel(
      bmiId: snapshot.id,
      healthId: snapshot['healthId'],
      currentHeight: snapshot['currentHeight'],
      currentWeight: snapshot['currentWeight'],
      bmiData : snapshot['bmiData'],
      createdAt: creationTime,
    );
  }

  List<BmiModel> _createBmiModelList(QuerySnapshot snapshot) {
    return snapshot.docs.map<BmiModel>((doc) {
      return BmiModel(
        bmiId: doc.id,
        healthId: doc.get('healthId'),
        currentHeight: doc.get('currentHeight') ?? '',
        currentWeight: doc.get('currentWeight') ?? '',
        bmiData: doc.get('bmiData') ?? '',
        createdAt: doc.get('createdAt') ?? '',
      );
    }).toList();
  }

  //create health status data
  Future<void> createBmiData(
    String bmiId,
    String healthId,
    double currentHeight,
    double currentWeight,
    double bmiData
    ) async {
    DateTime now = DateTime.now();
    return await bmiCollection.doc(bmiId).set({
      'healthId' : healthId,
      'currentHeight': currentHeight,
      'currentWeight': currentWeight,
      'bmiData': bmiData,
      'createdAt' :now,
    });
  }

  //------------------------------Health Status----------------------------------

  //collection reference
  final CollectionReference healthStatusCollection =
      FirebaseFirestore.instance.collection('Health Status');

  //get specific health status document stream
  Stream<HealthStatusModel> healthStatusData (healthStatusId) {
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
        healthStatusId: doc.data().toString().contains('healthStatusId') ? doc.get('healthStatusId') : '',
        currentTemperature: doc.data().toString().contains('currentTemperature') ? doc.get('currentTemperature') : '',
        currentHeartRate: doc.data().toString().contains('currentHeartRate') ? doc.get('currentHeartRate') : '',
        healthConditionId: doc.data().toString().contains('healthConditionId') ? doc.get('healthConditionId') : '',
        physicalConditionId: doc.data().toString().contains('physicalConditionId') ? doc.get('physicalConditionId') : '',
        chronicConditionId: doc.data().toString().contains('chronicConditionId') ? doc.get('chronicConditionId') : '',
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
  Stream<HealthConditionModel> healthConditionData (healthConditionId) {
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
  Stream<PhysicalConditionModel> physicalConditionData (physicalConditionId) {
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
  Stream<ChronicConditionModel> chronicConditionData (chronicConditionId) {
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
}