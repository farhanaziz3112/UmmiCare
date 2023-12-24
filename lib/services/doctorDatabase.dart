import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ummicare/models/doctorModel.dart';

class DoctorDatabaseService{
  final String doctorId;
  final String? clinicId;

  DoctorDatabaseService(
    {required this.doctorId, this.clinicId}
  );

  //------------------------------Doctor----------------------------------
  //collection reference
  final CollectionReference doctorCollection =
      FirebaseFirestore.instance.collection('Doctor');

  //get specific Doctor document stream
  Stream<DoctorModel> get doctorData {
    return doctorCollection
        .doc(doctorId)
        .snapshots()
        .map(_createDoctorModelObject);
  }

  //create a Doctor model object
  DoctorModel _createDoctorModelObject(DocumentSnapshot snapshot) {
    return DoctorModel(
      doctorId: snapshot.id,
      doctorFullName: snapshot['doctorFullName'],
      doctorPhoneNumber: snapshot['doctorPhoneNumber'],
    );
  }

  //create Doctor data
  Future<void> createDoctorData(
    String doctorId,
    String doctorFullName,
    String doctorPhoneNumber) async {
    return await doctorCollection.doc(doctorId).set({
      'doctorFullName': doctorFullName,
      'doctorPhoneNumber': doctorPhoneNumber,
    });
  }

  //------------------------------Clinic----------------------------------
  //collection reference
  final CollectionReference clinicCollection =
      FirebaseFirestore.instance.collection('Clinic');

  //get specific Clinic document stream
  Stream<ClinicModel> get clinicData {
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
      clinicPhoneNumber: snapshot['clinicPhoneNumber']
    );
  }

  //create Clinic data
  Future<void> createClinicData(
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
}