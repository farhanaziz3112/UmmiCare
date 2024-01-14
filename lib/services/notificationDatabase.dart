import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ummicare/models/notificationModel.dart';

class notificationDatabase {
  final CollectionReference notiCollection =
      FirebaseFirestore.instance.collection('Notification');

  //get specific buddy document stream
  Stream<notificationModel> notificationData(String notificationId) {
    return notiCollection
        .doc(notificationId)
        .snapshots()
        .map(_createnotificationModelObject);
  }

  //get all buddies stream
  Stream<List<notificationModel>> allnotificationDataWithParentId(
      String parentId) {
    return notiCollection
        .where('parentId', isEqualTo: parentId)
        .snapshots()
        .map(_createnotificationModelList);
  }

  Stream<List<notificationModel>> allnotificationDataWithParentIdWithStatus(
      String parentId, String status) {
    return notiCollection
        .where('parentId', isEqualTo: parentId)
        .where('status', isEqualTo: status)
        .snapshots()
        .map(_createnotificationModelList);
  }

  //create a list of buddy model object
  List<notificationModel> _createnotificationModelList(QuerySnapshot snapshot) {
    return snapshot.docs.map<notificationModel>((doc) {
      return notificationModel(
        notificationId: doc.id,
        parentId: doc.get('parentId') ?? '',
        childId: doc.get('childId') ?? '',
        type: doc.get('type') ?? '',
        title: doc.get('title') ?? '',
        description: doc.get('description') ?? '',
        status: doc.get('status') ?? '',
        createdAt: doc.get('createdAt') ?? '',
      );
    }).toList();
  }

  //create a buddy model object
  notificationModel _createnotificationModelObject(DocumentSnapshot snapshot) {
    return notificationModel(
      notificationId: snapshot.id,
      parentId: snapshot['parentId'],
      childId: snapshot['childId'],
      type: snapshot['type'],
      title: snapshot['title'],
      description: snapshot['description'],
      status: snapshot['status'],
      createdAt: snapshot['createdAt'],
    );
  }

  //update buddy data
  Future<void> updateNotificationData(
      String notificationId,
      String parentId,
      String childId,
      String type,
      String title,
      String description,
      String status,
      String createdAt) async {
    return await notiCollection.doc(notificationId).set({
      'notificationId': notificationId,
      'parentId': parentId,
      'childId': childId,
      'type': type,
      'title': title,
      'description': description,
      'status': status,
      'createdAt': createdAt
    });
  }

  //create child data
  Future<void> createNotificationData(
      String notificationId,
      String parentId,
      String childId,
      String type,
      String title,
      String description,
      String status,
      String createdAt) async {
    final document = notiCollection.doc();
    return await notiCollection.doc(document.id).set({
      'notificationId': document.id,
      'parentId': parentId,
      'childId': childId,
      'type': type,
      'title': title,
      'description': description,
      'status': status,
      'createdAt': createdAt
    });
  }
}
