import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ummicare/models/advisorModel.dart';
import 'package:ummicare/models/parentModel.dart';


class advisorDatabase {

  final String advisorId;
  advisorDatabase({required this.advisorId});

  final CollectionReference advisorCollection =
      FirebaseFirestore.instance.collection('Advisor');

  //get specific advisor document stream
  Stream<advisorModel> get advisorData {
    return advisorCollection.doc(advisorId).snapshots().map(_createAdvisorModelObject);
  }

  //get all userdetails stream
  Stream<List<advisorModel>> get allAdvisorData {
    return advisorCollection.snapshots().map(_createAdvisorModelList);
  }

  //create a user model object
  advisorModel _createAdvisorModelObject(DocumentSnapshot snapshot) {
    return advisorModel(
      advisorId: snapshot.id,
      advisorCreatedDate: snapshot['advisorCreatedDate'],
      advisorFullName: snapshot['advisorFullName'],
      advisorFirstName: snapshot['advisorFirstName'],
      advisorLastName: snapshot['advisorLastName'],
      advisorEmail: snapshot['advisorEmail'],
      advisorPhoneNumber: snapshot['advisorPhoneNumber'],
      advisorProfileImg: snapshot['advisorProfileImg'],
      noOfParents: snapshot['noOfParents'],
    );
  }

  //create a list of user model object
  List<advisorModel> _createAdvisorModelList(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return advisorModel(
          advisorId: doc.data().toString().contains('advisorId') ? doc.get('advisorId') : '',
          advisorCreatedDate: doc.data().toString().contains('advisorCreatedDate') ? doc.get('advisorCreatedDate') : '',
          advisorFullName: doc.data().toString().contains('advisorFullName') ? doc.get('advisorFullName') : '',
          advisorFirstName: doc.data().toString().contains('advisorFirstName') ? doc.get('advisorFirstName') : '',
          advisorLastName: doc.data().toString().contains('advisorLastName') ? doc.get('advisorLastName') : '',
          advisorEmail: doc.data().toString().contains('advisorEmail') ? doc.get('advisorEmail') : '',
          advisorPhoneNumber: doc.data().toString().contains('advisorPhoneNumber') ? doc.get('advisorPhoneNumber') : '',
          advisorProfileImg: doc.data().toString().contains('advisorProfileImg') ? doc.get('advisorProfileImg') : '',
          noOfParents: doc.data().toString().contains('noOfParents') ? doc.get('noOfParents') : '');
    }).toList();
  }

  addParent(Map<String, dynamic> parent, advisorModel advisor, String parentId) {
    updateAdvisorData(advisorId, advisor.advisorCreatedDate, advisor.advisorFullName, advisor.advisorFirstName, advisor.advisorLastName, advisor.advisorEmail, advisor.advisorPhoneNumber, advisor.advisorProfileImg, (int.parse(advisor.noOfParents) + 1).toString());
    advisorCollection.doc(advisor.advisorId).collection('Parent').doc(parentId).set(parent);
  }

   Stream<List<parentAdvisorModel>> getParentList(String docId) {
    return advisorCollection.doc(docId).collection('Parent').snapshots().map(_createParentAdvisorModelList);
  }

  //create a list of user model object
  List<parentAdvisorModel> _createParentAdvisorModelList(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return parentAdvisorModel(
        parentId: doc.data().toString().contains('parentId') ? doc.get('parentId') : '',
        assignedDate: doc.data().toString().contains('assignedDate') ? doc.get('assignedDate') : '',
      );
    }).toList();
  }

  //create a list of user model object
  List<parentModel> _createParentModelList(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return parentModel(
        parentId: doc.data().toString().contains('parentId') ? doc.get('parentId') : '',
        parentCreatedDate: doc.data().toString().contains('parentCreatedDate') ? doc.get('parentCreatedDate') : '',
        parentFullName: doc.data().toString().contains('parentFullName') ? doc.get('parentFullName') : '',
        parentFirstName: doc.data().toString().contains('parentFirstName') ? doc.get('parentFirstName') : '',
        parentLastName: doc.data().toString().contains('parentLastName') ? doc.get('parentLastName') : '',
        parentEmail: doc.data().toString().contains('parentEmail') ? doc.get('parentEmail') : '',
        parentPhoneNumber: doc.data().toString().contains('parentPhoneNumber') ? doc.get('parentPhoneNumber') : '',
        parentProfileImg: doc.data().toString().contains('parentProfileImg') ? doc.get('parentProfileImg') : '',
        advisorId: doc.data().toString().contains('advisorId') ? doc.get('advisorId') : '',
        noOfChild: doc.data().toString().contains('noOfChild') ? doc.get('noOfChild') : '',
      );
    }).toList();
  }

  //update user data
  Future<void> updateAdvisorData(
      String advisorId,
      String advisorCreatedDate,
      String advisorFullName,
      String advisorFirstName,
      String advisorLastName,
      String advisorEmail,
      String advisorPhoneNumber,
      String advisorProfileImg,
      String noOfParents,) async {
    return await advisorCollection.doc(advisorId).set({
      'advisorId': advisorId,
      'advisorCreatedDate': advisorCreatedDate,
      'advisorFullName': advisorFullName,
      'advisorFirstName': advisorFirstName,
      'advisorLastName': advisorLastName,
      'advisorEmail': advisorEmail,
      'advisorPhoneNumber': advisorPhoneNumber,
      'advisorProfileImg': advisorProfileImg,
      'noOfParents': noOfParents,
    });
  }
  

}