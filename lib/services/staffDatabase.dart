import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ummicare/models/staffUserModel.dart';

class staffDatabase {

  final String staffId;
  staffDatabase({required this.staffId});

  // FirebaseAuth _auth = FirebaseAuth.instance;

  final CollectionReference staffCollection =
      FirebaseFirestore.instance.collection('Staff');

 //------------------------------ADVISOR----------------------------------

  //get specific advisor document stream
  Stream<staffUserModel> get staffData {
    return staffCollection.doc(staffId).snapshots().map(_createStaffModelObject);
  }

  //get all userdetails stream
  Stream<List<staffUserModel>> get allStaffData {
    return staffCollection.snapshots().map(_createStaffModelList);
  }

  //create a user model object
  staffUserModel _createStaffModelObject(DocumentSnapshot snapshot) {
    return staffUserModel(
      staffId: snapshot.id,
      staffCreatedDate: snapshot['staffCreatedDate'],
      staffUserType: snapshot['staffUserType'],
      staffFullName: snapshot['staffFullName'],
      staffFirstName: snapshot['staffFirstName'],
      staffLastName: snapshot['staffLastName'],
      staffEmail: snapshot['staffEmail'],
      staffPhoneNumber: snapshot['staffPhoneNumber'],
      staffSupportingDocumentLink: snapshot['staffSupportingDocumentLink'],
      staffProfileImg: snapshot['staffProfileImg'],
      isVerified: snapshot['isVerified']
    );
  }

  //create a list of user model object
  List<staffUserModel> _createStaffModelList(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return staffUserModel(
          staffId: doc.get('staffId'),
          staffCreatedDate: doc.get('staffCreatedDate'),
          staffUserType: doc.get('staffUserType'),
          staffFullName: doc.get('staffFullName'),
          staffFirstName: doc.get('staffFirstName'),
          staffLastName: doc.get('staffLastName'),
          staffEmail: doc.get('staffEmail'),
          staffPhoneNumber: doc.get('staffPhoneNumber'),
          staffSupportingDocumentLink: doc.get('staffSupportingDocumentLink'),
          staffProfileImg: doc.get('staffProfileImg'),
          isVerified: doc.get('isVerified'));
    }).toList();
  }

  //update user data
  Future<void> updateStaffData(
      String staffId,
      String staffCreatedDate,
      String staffUserType,
      String staffFullName,
      String staffFirstName,
      String staffLastName,
      String staffEmail,
      String staffPhoneNumber,
      String staffSupportingDocumentLink,
      String staffProfileImg,
      String isVerified,) async {
    return await staffCollection.doc(staffId).set({
      'staffId': staffId,
      'staffCreatedDate': staffCreatedDate,
      'staffUserType': staffUserType,
      'staffFullName': staffFullName,
      'staffFirstName': staffFirstName,
      'staffLastName': staffLastName,
      'staffEmail': staffEmail,
      'staffPhoneNumber': staffPhoneNumber,
      'staffSupportingDocumentLink': staffSupportingDocumentLink,
      'staffProfileImg': staffProfileImg,
      'isVerified': isVerified,
    });
  }


}

