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
      clinicId : snapshot['clinicId'],
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
          medicalStaffProfileImg: doc.data().toString().contains('medicalStaffProfileImg') ? doc.get('medicalStaffProfileImg') : '',
          clinicId: doc.data().toString().contains('clinicId') ? doc.get('clinicId'): '',);
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
      String medicalStaffProfileImg,
      String clinicId) async {
    return await medicalStaffCollection.doc(medicalStaffId).set({
      'medicalStaffId': medicalStaffId,
      'medicalStaffCreatedDate': medicalStaffCreatedDate,
      'medicalStaffFullName': medicalStaffFullName,
      'medicalStaffFirstName': medicalStaffFirstName,
      'medicalStaffLastName': medicalStaffLastName,
      'medicalStaffEmail': medicalStaffEmail,
      'medicalStaffPhoneNumber': medicalStaffPhoneNumber,
      'medicalStaffProfileImg': medicalStaffProfileImg,
      'clinicId' : clinicId,
    });
  }
  

 //------------------------------Clinic----------------------------------
  //collection reference
  final CollectionReference clinicCollection =
      FirebaseFirestore.instance.collection('Clinic');

  //get specific Clinic document stream
  Stream<ClinicModel> clinicData (String clinicId) {
    return clinicCollection
        .doc(clinicId)
        .snapshots()
        .map(_createClinicModelObject);
  }

  //create a Clinic model object
  ClinicModel _createClinicModelObject(DocumentSnapshot snapshot) {
    return ClinicModel(
      clinicId: snapshot.id,
      clinicName: snapshot['clinicName'],
      clinicAddress: snapshot['clinicAddress'],
      clinicEmail: snapshot['clinicEmail'],
      clinicPhoneNumber: snapshot['clinicPhoneNumber']
    );
  }

  Stream<List<ClinicModel>> get allClinicData {
    return clinicCollection.snapshots().map(_createClinicModelList);
  }

  List<ClinicModel> _createClinicModelList(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return ClinicModel(
          clinicId: doc.get('clinicId'),
          clinicName: doc.get('clinicName'),
          clinicAddress: doc.get('clinicAddress'),
          clinicEmail: doc.get('clinicEmail'),
          clinicPhoneNumber: doc.get('clinicPhoneNumber'));
    }).toList();
  }

  Stream<List<ClinicModel>> clinicSearch(String search) {
    return clinicCollection
        .where('ClinicModelName', isGreaterThanOrEqualTo: search)
        .where('search', isLessThan: search + 'z')
        .snapshots()
        .map(_createClinicModelList);
  }

  String searchClinicModelNameFormatting(String clinicName) {
    if (clinicName == '') {
      return clinicName;
    }
    String temp = clinicName[0].toUpperCase() + clinicName.substring(1);
    if (temp.length > 2) {
      for (int i = 0; i < temp.length; i++) {
        if (temp[i] == ' ' && temp[i + 1] != ' ') {
          temp = temp.substring(0, i + 1) +
              temp[i + 1].toUpperCase() +
              temp.substring(i + 2);
        }
      }
    }

    return temp;
  }

  Future<void> updateClinicData(
    String clinicId,
    String clinicName,
    String clinicAddress,
    String clinicPhoneNumber) async {
    return await clinicCollection.doc(clinicId).set({
      'clinicName': clinicName,
      'clinicAddress': clinicAddress,
      'clinicPhoneNumber': clinicPhoneNumber,
    });
  }

  //create Clinic data
  Future<void> createClinicData(
    String clinicName,
    String clinicAddress,
    String clinicPhoneNumber) async {
    final document = clinicCollection.doc();
    return await clinicCollection.doc(document.id).set({
      'clinicId': document.id,
      'clinicName': clinicName,
      'clinicAddress': clinicAddress,
      'clinicPhoneNumber': clinicPhoneNumber,
    });
  }

}