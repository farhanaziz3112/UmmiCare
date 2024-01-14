import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ummicare/models/activityModel.dart';

class activityDatabase {
  final CollectionReference activityCollection =
      FirebaseFirestore.instance.collection('Activity');

  //get specific buddy document stream
  Stream<activityModel> activityData(String activityId) {
    return activityCollection
        .doc(activityId)
        .snapshots()
        .map(_createactivityModelObject);
  }

  //get all buddies stream
  Stream<List<activityModel>> allactivityDataWithParentId(String parentId) {
    return activityCollection
        .where('parentId', isEqualTo: parentId)
        .snapshots()
        .map(_createactivityModelList);
  }

  //create a list of buddy model object
  List<activityModel> _createactivityModelList(QuerySnapshot snapshot) {
    return snapshot.docs.map<activityModel>((doc) {
      return activityModel(
        activityId: doc.id,
        parentId: doc.get('parentId') ?? '',
        childId: doc.get('childId') ?? '',
        activityTitle: doc.get('activityTitle') ?? '',
        activityDescription: doc.get('activityDescription') ?? '',
        type: doc.get('type') ?? '',
        createdAt: doc.get('createdAt') ?? '',
      );
    }).toList();
  }

  //create a buddy model object
  activityModel _createactivityModelObject(DocumentSnapshot snapshot) {
    return activityModel(
        activityId: snapshot.id,
        parentId: snapshot['parentId'],
        childId: snapshot['childId'],
        activityTitle: snapshot['activityTitle'],
        activityDescription: snapshot['activityDescription'],
        type: snapshot['type'],
        createdAt: snapshot['createdAt']);
  }

  //update buddy data
  Future<void> updateactivityData(String activityId, String parentId,
      String childId, String activityTitle, String activityDescription, String type, String createdAt) async {
    return await activityCollection.doc(activityId).set({
      'activityId': activityId,
      'parentId': parentId,
      'childId': childId,
      'activityTitle': activityTitle,
      'activityDescription': activityDescription,
      'type': type,
      'createdAt': createdAt
    });
  }

  //create child data
  Future<void> createactivityData(
      String parentId, String childId, String activityTitle, String activityDescription, String type, String createdAt) async {
    final document = activityCollection.doc();
    return await activityCollection.doc(document.id).set({
      'activityId': document.id,
      'parentId': parentId,
      'childId': childId,
      'activityTitle': activityTitle,
      'activityDescription': activityDescription,
      'type': type,
      'createdAt': createdAt
    });
  }
}
