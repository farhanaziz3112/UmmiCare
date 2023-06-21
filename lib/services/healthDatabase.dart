import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ummicare/models/educationmodel.dart';
import 'package:ummicare/models/usermodel.dart';
import 'package:ummicare/models/healthmodel.dart';

class HealthDatabaseService {
  final String childId;
  final String? healthId;
  final String? healthStatusId;

  HealthDatabaseService({required this.childId, this.healthId, this.healthStatusId});

//------------------------------Health----------------------------------

  //collection reference
  final CollectionReference healthCollection =
      FirebaseFirestore.instance.collection('Health');

  //collection reference
  final CollectionReference healthSubjectsCollection = FirebaseFirestore
      .instance
      .collection('Health');

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
      physicalList: [],
      childId: snapshot['childId'],
      healthStatusId: snapshot['healthStatusId'],
    );
  }

  //create a list of education model object
  List<HealthModel> _createHealthModelList(QuerySnapshot snapshot) {
    return snapshot.docs.map<HealthModel>((doc) {
      return HealthModel(
        healthId: doc.id,
        physicalList: [],
        childId: doc.get('childId') ?? '',
        healthStatusId: doc.get('healthStatusId') ?? '',
      );
    }).toList();
  }

  Future<List<PhysicalModel>> getPhysicalList(String healthId) async {
    Future<DocumentSnapshot<Map<String, dynamic>>> querySnapshot =
        healthCollection.doc(healthId).collection('physical').doc().get();
    print(querySnapshot.toString());
    return [];
  }

  //create a list of Health model object
  //List<HealthModel> _createHealthModelList(QuerySnapshot snapshot) {
  //  return snapshot.docs.map<HealthModel>((doc) {
  //    return HealthModel(
  //     healthId: doc.id,
  //      physicalList: [],
  //      childId: doc.get('childId') ?? '',
  //      healthStatusId: doc.get('healthStatusId') ?? '',
  //    );
  //  }).toList();
  //}

  //create Health data
  Future<void> createHealthData(
      String healthId,
      String childId,
      String healthStatusId) async {
    return await healthCollection.doc().set({
      'childId': childId,
      'healthStatusId': healthStatusId,
    });
  }


  //------------------------------SUBJECTS LIST----------------------------------

  // //get education stream
  // Stream<Future<List<PhysicalModel>>> get physicalListData (String id){
  //    return healthCollection
  //        .where('childId', isEqualTo: childId)
  //        .where('status', isEqualTo: 'active')
  //        .snapshots()
  //        .map(getPhysicalList(id));
  // }
}