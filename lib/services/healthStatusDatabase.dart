import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ummicare/models/healthStatusModel.dart';

class HealthStatusDatabaseService {
  final String healthStatusId;
  final String? healthConditionId;
  final String? physicalConditionId;
  final String? chronicConditionId;

  HealthStatusDatabaseService(
    {required this.healthStatusId, this.healthConditionId, this.physicalConditionId, this.chronicConditionId}
  );

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
}