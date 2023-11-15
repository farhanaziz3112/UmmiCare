import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ummicare/models/medicalStaffModel.dart';

class medicalStaffDatabase {

  final String medicalStaffId;
  medicalStaffDatabase({required this.medicalStaffId});

  final CollectionReference medicalStaffCollection =
      FirebaseFirestore.instance.collection('Medical Staff');

  //get specific medicalStaff document stream
  Stream<medicalStaffModel> get medicalStaffData {
    return medicalStaffCollection.doc(medicalStaffId).snapshots().map(_createMedicalStaffModelObject);
  }

  //get all userdetails stream
  Stream<List<medicalStaffModel>> get allMedicalStaffData {
    return medicalStaffCollection.snapshots().map(_createMedicalStaffModelList);
  }

  //create a user model object
  medicalStaffModel _createMedicalStaffModelObject(DocumentSnapshot snapshot) {
    return medicalStaffModel(
      medicalStaffId: snapshot.id,
      medicalStaffCreatedDate: snapshot['medicalStaffCreatedDate'],
      medicalStaffFullName: snapshot['medicalStaffFullName'],
      medicalStaffFirstName: snapshot['medicalStaffFirstName'],
      medicalStaffLastName: snapshot['medicalStaffLastName'],
      medicalStaffEmail: snapshot['medicalStaffEmail'],
      medicalStaffPhoneNumber: snapshot['medicalStaffPhoneNumber'],
      medicalStaffProfileImg: snapshot['medicalStaffProfileImg'],
    );
  }

  //create a list of user model object
  List<medicalStaffModel> _createMedicalStaffModelList(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return medicalStaffModel(
          medicalStaffId: doc.data().toString().contains('medicalStaffId') ? doc.get('medicalStaffId') : '',
          medicalStaffCreatedDate: doc.data().toString().contains('medicalStaffCreatedDate') ? doc.get('medicalStaffCreatedDate') : '',
          medicalStaffFullName: doc.data().toString().contains('medicalStaffFullName') ? doc.get('medicalStaffFullName') : '',
          medicalStaffFirstName: doc.data().toString().contains('medicalStaffFirstName') ? doc.get('medicalStaffFirstName') : '',
          medicalStaffLastName: doc.data().toString().contains('medicalStaffLastName') ? doc.get('medicalStaffLastName') : '',
          medicalStaffEmail: doc.data().toString().contains('medicalStaffEmail') ? doc.get('medicalStaffEmail') : '',
          medicalStaffPhoneNumber: doc.data().toString().contains('medicalStaffPhoneNumber') ? doc.get('medicalStaffPhoneNumber') : '',
          medicalStaffProfileImg: doc.data().toString().contains('medicalStaffProfileImg') ? doc.get('medicalStaffProfileImg') : '');
    }).toList();
  }

  // addParent(Map<String, dynamic> parent, medicalStaffModel medicalStaff, String parentId) {
  //   updatemedicalStaffData(medicalStaffId, medicalStaff.medicalStaffFullName, medicalStaff.medicalStaffFirstName, medicalStaff.medicalStaffLastName, medicalStaff.medicalStaffEmail, medicalStaff.medicalStaffPhoneNumber, medicalStaff.medicalStaffProfileImg);
  //   medicalStaffCollection.doc(medicalStaff.medicalStaffId).collection('Parent').doc(parentId).set(parent);
  // }

  // Stream<List<parentModel>> getParents(String docId) {
  //   return medicalStaffCollection.doc(docId).collection('Parent').snapshots().map(_createParentModelList);
  // }

  // //create a list of user model object
  // List<parentModel> _createParentModelList(QuerySnapshot snapshot) {
  //   return snapshot.docs.map((doc) {
  //     return parentModel(
  //       parentId: doc.data().toString().contains('parentId') ? doc.get('parentId') : '',
  //       parentFullName: doc.data().toString().contains('parentId') ? doc.get('parentFullName') : '',
  //       parentFirstName: doc.data().toString().contains('parentFirstName') ? doc.get('parentFirstName') : '',
  //       parentLastName: doc.data().toString().contains('parentLastName') ? doc.get('parentLastName') : '',
  //       parentEmail: doc.data().toString().contains('parentEmail') ? doc.get('parentEmail') : '',
  //       parentPhoneNumber: doc.data().toString().contains('parentPhoneNumber') ? doc.get('parentPhoneNumber') : '',
  //       parentProfileImg: doc.data().toString().contains('parentProfileImg') ? doc.get('parentProfileImg') : '',
  //     );
  //   }).toList();
  // }

  //update user data
  Future<void> updateMedicalStaffData(
      String medicalStaffId,
      String medicalStaffCreatedDate,
      String medicalStaffFullName,
      String medicalStaffFirstName,
      String medicalStaffLastName,
      String medicalStaffEmail,
      String medicalStaffPhoneNumber,
      String medicalStaffProfileImg,) async {
    return await medicalStaffCollection.doc(medicalStaffId).set({
      'medicalStaffId': medicalStaffId,
      'medicalStaffCreatedDate': medicalStaffCreatedDate,
      'medicalStaffFullName': medicalStaffFullName,
      'medicalStaffFirstName': medicalStaffFirstName,
      'medicalStaffLastName': medicalStaffLastName,
      'medicalStaffEmail': medicalStaffEmail,
      'medicalStaffPhoneNumber': medicalStaffPhoneNumber,
      'medicalStaffProfileImg': medicalStaffProfileImg,
    });
  }
  

}