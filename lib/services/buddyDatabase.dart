import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ummicare/models/buddymodel.dart';


class BuddyDatabaseService {
  final String userId;
  final String? buddyId;
  BuddyDatabaseService({required this.userId, this.buddyId});

  FirebaseAuth _auth = FirebaseAuth.instance;

  //------------------------------USER----------------------------------

  //collection reference
  final CollectionReference buddyCollection =
      FirebaseFirestore.instance.collection('Buddy');

  //get specific buddy document stream
  Stream<BuddyModel> get buddyData {
    return buddyCollection.doc(userId).snapshots().map(_createBuddyModelObject);
  }

  //get all buddies stream
  Stream<List<BuddyModel>> get allBuddyData {
    return buddyCollection
        .where('userId', isEqualTo: userId)
        .snapshots()
        .map(_createBuddyModelList);
  }

  //create a list of buddy model object
  List<BuddyModel> _createBuddyModelList(QuerySnapshot snapshot) {
    return snapshot.docs.map<BuddyModel>((doc) {
      return BuddyModel(
        buddyId: doc.id,
        username: doc.get('username') ?? '',
        private: doc.get('private') ?? '',
        imageURL: doc.get('imageURL') ?? '',
        userId: doc.get('userId') ?? '',
      );
    }).toList();
  }

  //create a buddy model object
  BuddyModel _createBuddyModelObject(DocumentSnapshot snapshot) {
    return BuddyModel(
      buddyId: snapshot.id,
      username: snapshot['username'],
      private: snapshot['private'],
      imageURL: snapshot['imageURL'],
      userId: snapshot['userId'],
    );
  }

  //update buddy data
  Future<void> updateChildData(
      String buddyId,
      String username,
      String private,
      String imageURL,
      String userId) async {
    return await buddyCollection.doc(buddyId).set({
      'username': username,
      'private': private,
      'imageURL': imageURL,
      'userId': userId,
    });
  }

  //create child data
  Future<void> createChildData(
      String buddyId,
      String username,
      String private,
      String imageURL,
      String userId) async {
    return await buddyCollection.doc(buddyId).set({
      'username': username,
      'private': private,
      'imageURL': imageURL,
      'userId': userId,
    });
  }
}