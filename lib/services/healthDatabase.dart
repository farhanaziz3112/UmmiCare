import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ummicare/models/healthModel.dart';

class HealthDatabaseService {
  final String childId;
  final String? healthId;
  final String? healthStatusId;
  final String? bmiId;

  HealthDatabaseService(
      {required this.childId, this.healthId, this.healthStatusId, this.bmiId});

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
      bmiId: snapshot['bmiId'],
    );
  }

  //create a list of Health model object
  List<HealthModel> _createHealthModelList(QuerySnapshot snapshot) {
    return snapshot.docs.map<HealthModel>((doc) {
      return HealthModel(
        healthId: doc.id,
        childId: doc.get('childId') ?? '',
        healthStatusId: doc.get('healthStatusId') ?? '',
        bmiId: doc.get('bmiId') ?? '',
      );
    }).toList();
  }


  //create Health data
  Future<void> createHealthData(
      String healthId, String childId, String healthStatusId, String bmiId) async {
    return await healthCollection.doc(healthId).set({
      'childId': childId,
      'healthStatusId': healthStatusId,
      'bmiId' : bmiId,
    });
  }

  //--------------------------------------Bmi------------------------------------

  //collection reference
  final CollectionReference BmiCollection =
      FirebaseFirestore.instance.collection('Bmi');

  //get specific health status document stream
  Stream<BmiModel> get BmiData {
    return BmiCollection
        .doc(bmiId)
        .snapshots()
        .map(_createBmiModelObject);
  }

  Stream<List<BmiModel>> get allBmiData {
    return BmiCollection
        .snapshots()
        .map(_createBmiModelList);
  }

  //create a Health Status model object
  BmiModel _createBmiModelObject(DocumentSnapshot snapshot) {
    Timestamp createdAt = snapshot['createdAt'];
    DateTime creationTime = createdAt.toDate();

    return BmiModel(
      bmiId: snapshot.id,
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
        currentHeight: doc.get('currentHeight') ?? '',
        currentWeight: doc.get('currentWeight') ?? '',
        bmiData: doc.get('bmiData') ?? '',
        createdAt: doc.get('createdAt') ?? '',
      );
    }).toList();
  }

  //create health status data
  Future<void> createBmiData(
    String BmiId,
    double currentHeight,
    double currentWeight,
    double bmiData
    ) async {
    DateTime now = DateTime.now();
    return await BmiCollection.doc(BmiId).set({
      'currentHeight': currentHeight,
      'currentWeight': currentWeight,
      'bmiData': bmiData,
      'createdAt' :now,
    });
  }
}