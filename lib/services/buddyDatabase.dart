import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ummicare/models/buddyModel.dart';

class buddyDatabase {
  //FirebaseAuth _auth = FirebaseAuth.instance;

  //------------------------------USER----------------------------------

  //collection reference
  final CollectionReference buddyProfileCollection =
      FirebaseFirestore.instance.collection('Buddy Profile');

  //get specific buddy document stream
  Stream<buddyProfileModel> buddyProfileData(String buddyProfileId) {
    return buddyProfileCollection
        .doc(buddyProfileId)
        .snapshots()
        .map(_createBuddyProfileModelObject);
  }

  //get all buddies stream
  Stream<List<buddyProfileModel>> get allBuddyProfileData {
    return buddyProfileCollection.snapshots().map(_createBuddyProfileModelList);
  }

  //create a list of buddy model object
  List<buddyProfileModel> _createBuddyProfileModelList(QuerySnapshot snapshot) {
    return snapshot.docs.map<buddyProfileModel>((doc) {
      return buddyProfileModel(
        buddyProfileId: doc.id,
        buddyProfileUsername: doc.get('buddyProfileUsername') ?? '',
        isPrivate: doc.get('isPrivate') ?? '',
        buddyProfileImageURL: doc.get('buddyProfileImageURL') ?? '',
      );
    }).toList();
  }

  //create a buddy model object
  buddyProfileModel _createBuddyProfileModelObject(DocumentSnapshot snapshot) {
    return buddyProfileModel(
        buddyProfileId: snapshot.id,
        buddyProfileUsername: snapshot['buddyProfileUsername'],
        isPrivate: snapshot['isPrivate'],
        buddyProfileImageURL: snapshot['buddyProfileImageURL']);
  }

  //update buddy data
  Future<void> updateBuddyProfileData(
      String buddyProfileId,
      String buddyProfileUsername,
      String isPrivate,
      String buddyProfileImageURL) async {
    return await buddyProfileCollection.doc(buddyProfileId).set({
      'buddyProfileId': buddyProfileId,
      'buddyProfileUsername': buddyProfileUsername,
      'isPrivate': isPrivate,
      'buddyProfileImageURL': buddyProfileImageURL,
    });
  }

  //create child data
  Future<void> createBuddyProfileData(
      String buddyProfileId,
      String buddyProfileUsername,
      String isPrivate,
      String buddyProfileImageURL) async {
    return await buddyProfileCollection.doc(buddyProfileId).set({
      'buddyProfileId': buddyProfileId,
      'buddyProfileUsername': buddyProfileUsername,
      'isPrivate': isPrivate,
      'buddyProfileImageURL': buddyProfileImageURL,
    });
  }

  //collection reference
  final CollectionReference buddyPostCollection =
      FirebaseFirestore.instance.collection('Buddy Post');

  //get specific buddy document stream
  Stream<buddyPostModel> buddyPostData(String buddyPostId) {
    return buddyPostCollection
        .doc(buddyPostId)
        .snapshots()
        .map(_createBuddyPostModelObject);
  }

  //get all buddies stream
  Stream<List<buddyPostModel>> get allBuddyPostData {
    return buddyPostCollection.snapshots().map(_createBuddyPostModelList);
  }

  Stream<List<buddyPostModel>> allBuddyPostDataWithProfileId(String profileId) {
    return buddyPostCollection
        .where('buddyProfileId', isEqualTo: profileId)
        .snapshots()
        .map(_createBuddyPostModelList);
  }

  Stream<List<buddyPostModel>> allBuddyPostDataWithStatus(String status) {
    return buddyPostCollection
        .where('isPrivate', isEqualTo: status)
        .snapshots()
        .map(_createBuddyPostModelList);
  }

  //create a list of buddy model object
  List<buddyPostModel> _createBuddyPostModelList(QuerySnapshot snapshot) {
    return snapshot.docs.map<buddyPostModel>((doc) {
      return buddyPostModel(
        buddyPostId: doc.id,
        buddyProfileId: doc.get('buddyProfileId') ?? '',
        buddyPostImageURL: doc.get('buddyPostImageURL') ?? '',
        buddyPostCaption: doc.get('buddyPostCaption') ?? '',
        isPrivate: doc.get('isPrivate') ?? '',
        createdAt: doc.get('createdAt') ?? '',
      );
    }).toList();
  }

  //create a buddy model object
  buddyPostModel _createBuddyPostModelObject(DocumentSnapshot snapshot) {
    return buddyPostModel(
        buddyPostId: snapshot.id,
        buddyProfileId: snapshot['buddyProfileId'],
        buddyPostImageURL: snapshot['buddyPostImageURL'],
        buddyPostCaption: snapshot['buddyPostCaption'],
        isPrivate: snapshot['isPrivate'],
        createdAt: snapshot['createdAt']);
  }

  //update buddy data
  Future<void> updateBuddyPostData(
      String buddyPostId,
      String buddyProfileId,
      String buddyPostImageURL,
      String buddyPostCaption,
      String isPrivate,
      String createdAt) async {
    return await buddyPostCollection.doc(buddyPostId).set({
      'buddyPostId': buddyPostId,
      'buddyProfileId': buddyProfileId,
      'buddyPostImageURL': buddyPostImageURL,
      'buddyPostCaption': buddyPostCaption,
      'isPrivate': isPrivate,
      'createdAt': createdAt,
    });
  }

  //create child data
  Future<void> createBuddyPostData(
      String buddyProfileId,
      String buddyPostImageURL,
      String buddyPostCaption,
      String isPrivate,
      String createdAt) async {
    final document = buddyPostCollection.doc();
    return await buddyPostCollection.doc(document.id).set({
      'buddyPostId': document.id,
      'buddyProfileId': buddyProfileId,
      'buddyPostImageURL': buddyPostImageURL,
      'buddyPostCaption': buddyPostCaption,
      'isPrivate': isPrivate,
      'createdAt': createdAt,
    });
  }

  //collection reference
  final CollectionReference friendRequestCollection =
      FirebaseFirestore.instance.collection('Buddy Friend Request');

  //get specific buddy document stream
  Stream<friendRequestModel> friendRequestData(String friendRequestId) {
    return friendRequestCollection
        .doc(friendRequestId)
        .snapshots()
        .map(_createFriendRequestModelObject);
  }

  //get all buddies stream
  Stream<List<friendRequestModel>> get allFriendRequestData {
    return friendRequestCollection
        .snapshots()
        .map(_createFriendRequestModelList);
  }

  Stream<List<friendRequestModel>> allFriendRequestDataWithId (String senderId, String receiverId) {
    return friendRequestCollection
        .where('senderId', isEqualTo: senderId)
        .where('receiverId', isEqualTo: receiverId)
        .snapshots()
        .map(_createFriendRequestModelList);
  }

  Stream<List<friendRequestModel>> allFriendRequestDataWithReceiverIdAndStatus (String status, String receiverId) {
    return friendRequestCollection
        .where('status', isEqualTo: status)
        .where('receiverId', isEqualTo: receiverId)
        .snapshots()
        .map(_createFriendRequestModelList);
  }

  //create a list of buddy model object
  List<friendRequestModel> _createFriendRequestModelList(
      QuerySnapshot snapshot) {
    return snapshot.docs.map<friendRequestModel>((doc) {
      return friendRequestModel(
        friendRequestId: doc.id,
        senderId: doc.get('senderId') ?? '',
        receiverId: doc.get('receiverId') ?? '',
        status: doc.get('status') ?? '',
      );
    }).toList();
  }

  //create a buddy model object
  friendRequestModel _createFriendRequestModelObject(
      DocumentSnapshot snapshot) {
    return friendRequestModel(
      friendRequestId: snapshot.id,
      senderId: snapshot['senderId'],
      receiverId: snapshot['receiverId'],
      status: snapshot['status'],
    );
  }

  //update buddy data
  Future<void> updateFriendRequestData(String friendRequestId, String senderId,
      String receiverId, String status) async {
    return await friendRequestCollection.doc(friendRequestId).set({
      'friendRequestId': friendRequestId,
      'senderId': senderId,
      'receiverId': receiverId,
      'status': status,
    });
  }

  //create child data
  Future<void> createFriendRequestData(
      String senderId, String receiverId, String status) async {
    final document = friendRequestCollection.doc();
    return await friendRequestCollection.doc(document.id).set({
      'friendRequestId': document.id,
      'senderId': senderId,
      'receiverId': receiverId,
      'status': status,
    });
  }


  //get specific buddy document stream
  Stream<friendModel> friendData(String profile, String friendId) {
    return buddyProfileCollection
        .doc(profile).collection('Friends').doc(friendId)
        .snapshots()
        .map(_createFriendModelObject);
  }

  //get all buddies stream
  Stream<List<friendModel>> allFriendData (String profile) {
    return buddyProfileCollection.doc(profile).collection('Friends')
        .snapshots()
        .map(_createFriendModelList);
  }

  //create a list of buddy model object
  List<friendModel> _createFriendModelList(
      QuerySnapshot snapshot) {
    return snapshot.docs.map<friendModel>((doc) {
      return friendModel(
        friendModelId: doc.id,
        friendStatus: doc.get('friendStatus') ?? '',
      );
    }).toList();
  }

  //create a buddy model object
  friendModel _createFriendModelObject(
      DocumentSnapshot snapshot) {
    return friendModel(
      friendModelId: snapshot.id,
      friendStatus: snapshot['friendStatus'],
    );
  }

  //update buddy data
  Future<void> updateFriendData(String profile, String friendModelId, String friendStatus) async {
    return await buddyProfileCollection.doc(profile).collection('Friends').doc(friendModelId).set({
      'friendModelId': friendModelId,
      'friendStatus': friendStatus,
    });
  }

  //create child data
  Future<void> createFriendData(String profile, String friendModelId, String friendStatus) async {
    return await buddyProfileCollection.doc(profile).collection('Friends').doc(friendModelId).set({
      'friendModelId': friendModelId,
      'friendStatus': friendStatus,
    });
  }
}
