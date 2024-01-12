import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ummicare/models/healthmodel.dart';
import 'package:ummicare/models/healthstatusmodel.dart';

class HealthDatabaseService {
//------------------------------Health----------------------------------

  //collection reference
  final CollectionReference healthCollection =
      FirebaseFirestore.instance.collection('Health');


  //get Health stream
  Stream<HealthModel> healthData (String healthId) {
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
      patientId: snapshot['patientId'],
    );
  }

  //create a list of Health model object
  List<HealthModel> _createHealthModelList(QuerySnapshot snapshot) {
    return snapshot.docs.map<HealthModel>((doc) {
      return HealthModel(
        healthId: doc.id,
        childId: doc.get('childId'),
        healthStatusId: doc.get('healthStatusId'),
        patientId: doc.get('patientId')
      );
    }).toList();
  }


  //create Health data
  Future<void> createHealthData(
      String healthId,
      String childId, 
      String healthStatusId,
      String patientId,
    ) async {
    return await healthCollection.doc(healthId).set({
      'childId': childId,
      'healthStatusId': healthStatusId,
      'patientId': patientId,
    });
  }

  Future<void> addBmi(
      String healthId, String bmiId, double bmiData) async {
    return await healthCollection
        .doc(healthId)
        .collection('Bmi')
        .doc(bmiId)
        .set({
      'bmiId': bmiId,
      'bmiData': bmiData,
    });
  }

  Future<void> updateBmi(
    String healthId,
    String bmiId,
    double bmiData,) async {
      return await healthCollection.doc(healthId).collection('Bmi').doc(bmiId).set({
        'bmiId': bmiId,
        'bmiData' : bmiId,
      });
    }

  Stream<BmiHealthModel> bmiHealthData(String healthId, String bmiId) {
    return healthCollection
        .doc(healthId)
        .collection('Bmi')
        .doc(bmiId)
        .snapshots()
        .map(_createBmiHealthModelObject);
  }

  //create a user model object
  BmiHealthModel _createBmiHealthModelObject(DocumentSnapshot snapshot) {
    return BmiHealthModel(
        bmiId: snapshot.id, 
        bmiData: snapshot['bmiData']);
  }

  Stream<List<BmiHealthModel>> allBmiHealthData(String healthId) {
    return healthCollection
        .doc(healthId)
        .collection('Bmi')
        .snapshots()
        .map(_createBmiHealthModelList);
  }

  List<BmiHealthModel> _createBmiHealthModelList(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return BmiHealthModel(
        bmiId: doc.get('bmiId'),
        bmiData: doc.get('bmiData'),
      );
    }).toList();
  }

  //--------------------------------------Bmi------------------------------------

  //collection reference
  final CollectionReference bmiCollection =
      FirebaseFirestore.instance.collection('Bmi');

  //get specific health status document stream
  Stream<BmiModel> bmiData (String bmiId) {
    return bmiCollection
        .doc(bmiId)
        .snapshots()
        .map(_createBmiModelObject);
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

  Stream<List<BmiModel>> allBmiDataWithSameHealthId (String healthId){
    return bmiCollection
        .where('healthId' ,isEqualTo: healthId)
        .snapshots()
        .map(_createBmiModelList);
  }

  List<BmiModel> _createBmiModelList(QuerySnapshot snapshot) {
    return snapshot.docs.map<BmiModel>((doc) {
      Timestamp createdAt = doc.get('createdAt');
      DateTime creationTime = createdAt.toDate();
      return BmiModel(
        bmiId: doc.id,
        healthId: doc.get('healthId'),
        currentHeight: doc.get('currentHeight') ?? '',
        currentWeight: doc.get('currentWeight') ?? '',
        bmiData: doc.get('bmiData') ?? '',
        createdAt: creationTime,
      );
    }).toList();
  }

  Stream<List<BmiModel>> allBmiData(){
    return bmiCollection
        .snapshots()
        .map(_createBmiModelList2);
  }

  List<BmiModel> _createBmiModelList2(QuerySnapshot snapshot) {
    return snapshot.docs.map<BmiModel>((doc) {
      Timestamp createdAt = doc.get('createdAt');
      DateTime creationTime = createdAt.toDate();
      return BmiModel(
        bmiId: doc.id,
        healthId: doc.get('healthId'),
        currentHeight: doc.get('currentHeight') ?? '',
        currentWeight: doc.get('currentWeight') ?? '',
        bmiData: doc.get('bmiData') ?? '',
        createdAt: creationTime,
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
  Stream<HealthStatusModel> healthStatusData (String healthStatusId) {
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
      healthConditionId: snapshot['healthConditionId'],
      physicalConditionId: snapshot['physicalConditionId'],
      chronicConditionId: snapshot['chronicConditionId'],
      patientId: snapshot['patientId'],
    );
  }

  List<HealthStatusModel> _createHealthStatusModelList(QuerySnapshot snapshot) {
    return snapshot.docs.map<HealthStatusModel>((doc) {
      return HealthStatusModel(
        healthStatusId: doc.data().toString().contains('healthStatusId') ? doc.get('healthStatusId') : '',
        healthConditionId: doc.data().toString().contains('healthConditionId') ? doc.get('healthConditionId') : '',
        physicalConditionId: doc.data().toString().contains('physicalConditionId') ? doc.get('physicalConditionId') : '',
        chronicConditionId: doc.data().toString().contains('chronicConditionId') ? doc.get('chronicConditionId') : '',
        patientId: doc.data().toString().contains('patientId') ? doc.get('patientId') : '',
      );
    }).toList();
  }

  //create health status data
  Future<void> createHealthStatusData(
    String healthStatusId,
    String healthConditionId,
    String physicalConditionId,
    String chronicConditionId,
    String patientId) async {
    return await healthStatusCollection.doc(healthStatusId).set({
      'healthConditionId': healthConditionId,
      'physicalConditionId': physicalConditionId,
      'chronicConditionId' : chronicConditionId,
      'patientId': patientId,
    });
  }

  Future<void> updateHealthStatusData(
    String healthStatusId,
    String healthConditionId,
    String physicalConditionId,
    String chronicConditionId,
    String patientId) async {
    return await healthStatusCollection.doc(healthStatusId).set({
      'healthConditionId': healthConditionId,
      'physicalConditionId': physicalConditionId,
      'chronicConditionId' : chronicConditionId,
      'patientId': patientId,
    });
  }

  //------------------------------Health Condition----------------------------------
  //collection reference
  final CollectionReference healthConditionCollection =
      FirebaseFirestore.instance.collection('Health Condition');

  //get specific health Condition document stream
  Stream<HealthConditionModel> healthConditionData (String healthConditionId) {
    return healthConditionCollection
        .doc(healthConditionId)
        .snapshots()
        .map(_createHealthConditionModelObject);
  }

  //create a Health Condition model object
  HealthConditionModel _createHealthConditionModelObject(DocumentSnapshot snapshot) {
    return HealthConditionModel(
      healthConditionId: snapshot.id,
      currentTemperature: snapshot['currentTemperature'],
      currentHeartRate: snapshot['currentHeartRate'],
      currentSymptom: snapshot['currentSymptom'],
      currentIllness: snapshot['currentIllness'],
      notes: snapshot['notes'],
      patientId: snapshot['patientId'],
    );
  }

  Stream<List<HealthConditionModel>> allHealthConditionData (String patientId){
    return healthConditionCollection
        .where('patientId', isEqualTo: patientId)
        .snapshots()
        .map(_createHealthConditionModelList);
  }

  List<HealthConditionModel> _createHealthConditionModelList(QuerySnapshot snapshot){
    return snapshot.docs.map<HealthConditionModel>((doc) {
      return HealthConditionModel(
        healthConditionId: doc.id,
        currentTemperature: doc.get('currentTemperature'),
        currentHeartRate: doc.get('currentHeartRate'),
        currentSymptom: doc.get('currentSymptom'),
        currentIllness: doc.get('currentIllness'),
        notes: doc.get('notes'),
        patientId: doc.get('patientId'),
      );
    }).toList();
  }

  //create health condition data
  Future<void> createHealthConditionData(
    String healthConditionId,
    String currentTemperature,
    String currentHeartRate,
    String currentSymptom,
    String currentIllness,
    String notes,
    String patientId) async {
    return await healthConditionCollection.doc(healthConditionId).set({
      'currentTemperature': currentTemperature,
      'currentHeartRate': currentHeartRate,
      'currentSymptom' : currentSymptom,
      'currentIllness' : currentIllness,
      'notes': notes,
      'patientId': patientId,
    });
  }

  Future<void> updateHealthConditionData(
    String healthConditionId,
    String currentTemperature,
    String currentHeartRate,
    String currentSymptom,
    String currentIllness,
    String notes,
    String patientId) async {
    return await healthConditionCollection.doc(healthConditionId).set({
      'currentTemperature': currentTemperature,
      'currentHeartRate': currentHeartRate,
      'currentSymptom' : currentSymptom,
      'currentIllness' : currentIllness,
      'notes': notes,
      'patientId': patientId,
    });
  }

//------------------------------Physical Condition----------------------------------
  //collection reference
  final CollectionReference physicalConditionCollection =
      FirebaseFirestore.instance.collection('Physical Condition');

  //get specific physical Condition document stream
  Stream<PhysicalConditionModel> physicalConditionData (String physicalConditionId) {
    return physicalConditionCollection
        .doc(physicalConditionId)
        .snapshots()
        .map(_createPhysicalConditionModelObject);
  }

  //create a Physical Condition model object
  PhysicalConditionModel _createPhysicalConditionModelObject(DocumentSnapshot snapshot) {
    return PhysicalConditionModel(
      physicalConditionId: snapshot.id,
      currentInjury: snapshot['currentInjury'],
      details: snapshot['details'],
      patientId: snapshot['patientId'],
    );
  }

  Stream<List<PhysicalConditionModel>> allPhysicalConditionData (String patientId){
    return physicalConditionCollection
        .where('patientId', isEqualTo: patientId)
        .snapshots()
        .map(_createPhysicalConditionModelList);
  }

  List<PhysicalConditionModel> _createPhysicalConditionModelList(QuerySnapshot snapshot){
    return snapshot.docs.map<PhysicalConditionModel>((doc) {
      return PhysicalConditionModel(
        physicalConditionId: doc.id,
        currentInjury: doc.data().toString().contains('currentInjury') ? doc.get('currentInjury') : '',
        details: doc.data().toString().contains('details') ? doc.get('details') : '',
        patientId: doc.data().toString().contains('patientId') ? doc.get('patientId') : '',
      );
    }).toList();
  }

  //create physical condition data
  Future<void> createPhysicalConditionData(
    String physicalConditionId,
    String currentInjury,
    String details,
    String patientId) async {
    return await physicalConditionCollection.doc(physicalConditionId).set({
      'currentInjury': currentInjury,
      'details': details,
      'patientId': patientId,
    });
  }

  Future<void> updatePhysicalConditionData(
    String physicalConditionId,
    String currentInjury,
    String details,
    String patientId) async {
    return await physicalConditionCollection.doc(physicalConditionId).set({
      'currentInjury': currentInjury,
      'details': details,
      'patientId': patientId,
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
      childChronic: snapshot['childChronic'],
      patientId: snapshot['patientId'],
    );
  }

  Stream<List<ChronicConditionModel>> allChronicConditionData (String patientId){
    return chronicConditionCollection
        .where('patientId', isEqualTo: patientId)
        .snapshots()
        .map(_createChronicConditionModelList);
  }

  List<ChronicConditionModel> _createChronicConditionModelList(QuerySnapshot snapshot){
    return snapshot.docs.map<ChronicConditionModel>((doc) {
      return ChronicConditionModel(
        chronicConditionId: doc.id,
        childAllergies: doc.data().toString().contains('childAllergies') ? doc.get('childAllergies') : '',
        childChronic: doc.data().toString().contains('childChronic') ? doc.get('childChronic') : '',
        patientId: doc.data().toString().contains('patientId') ? doc.get('patientId') : '',
      );
    }).toList();
  }

  //create chronic condition data
  Future<void> createChronicConditionData(
    String chronicConditionId,
    String childAllergies,
    String childChronic,
    String patientId) async {
    return await chronicConditionCollection.doc(chronicConditionId).set({
      'childAllergies': childAllergies,
      'childChronic': childChronic,
      'patientId': patientId,
    });
  }

  Future<void> updateChronicConditionData(
    String chronicConditionId,
    String childAllergies,
    String childChronic,
    String patientId) async {
    return await chronicConditionCollection.doc(chronicConditionId).set({
      'childAllergies': childAllergies,
      'childChronic': childChronic,
      'patientId': patientId,
    });
  }
}