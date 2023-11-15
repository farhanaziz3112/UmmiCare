import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ummicare/models/childModel.dart';

class childDatabase {
  final String childId;

  childDatabase({
    required this.childId
  });

    //collection reference
  final CollectionReference childCollection =
      FirebaseFirestore.instance.collection('Child');

  //get specific child document stream
  Stream<childModel> get childData {
    return childCollection
        .doc(childId)
        .snapshots()
        .map(_createchildModelObject);
  }

  //create a list of child model object
  List<childModel> _createchildModelList(QuerySnapshot snapshot) {
    return snapshot.docs.map<childModel>((doc) {
      return childModel(
        childId: doc.id,
        parentId: doc.get('parentId') ?? '',
        childCreatedDate: doc.get('childCreatedDate') ?? '',
        childName: doc.get('childName') ?? '',
        childFirstname: doc.get('childFirstname') ?? '',
        childLastname: doc.get('childLastname') ?? '',
        childBirthday: doc.get('childBirthday') ?? '',
        childCurrentAge: doc.get('childCurrentAge') ?? '',
        childAgeCategory: doc.get('childAgeCategory') ?? '',
        childProfileImg: doc.get('childProfileImg') ?? '',
        educationId: doc.get('educationId') ?? '',
        healthId: doc.get('healthId') ?? '',
      );
    }).toList();
  }

  //create a child model object
  childModel _createchildModelObject(DocumentSnapshot snapshot) {
    return childModel(
      childId: snapshot.id,
      parentId: snapshot['parentId'],
      childCreatedDate: snapshot['childCreatedDate'],
      childName: snapshot['childName'],
      childFirstname: snapshot['childFirstname'],
      childLastname: snapshot['childLastname'],
      childBirthday: snapshot['childBirthday'],
      childCurrentAge: snapshot['childCurrentAge'],
      childAgeCategory: snapshot['childAgeCategory'],
      childProfileImg: snapshot['childProfileImg'],
      educationId: snapshot['educationId'],
      healthId: snapshot['healthId']
    );
  }

  //update child data
  Future<void> updateChildData(
      String childId,
      String parentId,
      String childCreatedDate,
      String childName,
      String childFirstname,
      String childLastname,
      String childBirthday,
      int childCurrentAge,
      String childAgeCategory,
      String childProfileImg,
      String educationId,
      String healthId) async {
    return await childCollection.doc(childId).set({
      'childId': childId,
      'parentId': parentId,
      'childCreatedDate': childCreatedDate,
      'childName': childName,
      'childFirstname': childFirstname,
      'childLastname': childLastname,
      'childBirthday': childBirthday,
      'childCurrentAge': childCurrentAge,
      'childAgeCategory': childAgeCategory,
      'childProfileImg': childProfileImg,
      'educationId': educationId,
      'healthId': healthId
    });
  }

  //create child data
  Future<void> createChildData(
      String parentId,
      String childCreatedDate,
      String childName,
      String childFirstname,
      String childLastname,
      String childBirthday,
      int childCurrentAge,
      String childAgeCategory,
      String childProfileImg,
      String educationId,
      String healthId) async {
        final document = childCollection.doc();
    return await childCollection.doc(document.id).set({
      'childId': document.id,
      'parentId': parentId,
      'childCreatedDate': childCreatedDate,
      'childName': childName,
      'childFirstname': childFirstname,
      'childLastname': childLastname,
      'childBirthday': childBirthday,
      'childCurrentAge': childCurrentAge,
      'childAgeCategory': childAgeCategory,
      'childProfileImg': childProfileImg,
      'educationId': educationId,
      'healthId': healthId
    });
  }

}