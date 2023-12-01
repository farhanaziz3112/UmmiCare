import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ummicare/models/schoolModel.dart';

class schoolDatabase {
  //staff collection reference
  final CollectionReference schoolCollection =
      FirebaseFirestore.instance.collection('School');

  //staff collection reference
  final CollectionReference classCollection =
      FirebaseFirestore.instance.collection('Class');

  //get specific staff
  Stream<schoolModel> schoolData(String schoolId) {
    return schoolCollection.doc(schoolId).snapshots().map(_createSchoolModel);
  }

  schoolModel _createSchoolModel(DocumentSnapshot snapshot) {
    return schoolModel(
      schoolId: snapshot.id,
      schoolName: snapshot['schoolName'],
      schoolAddress: snapshot['schoolAddress'],
      schoolEmail: snapshot['schoolEmail'],
      schoolPhoneNumber: snapshot['schoolPhoneNumber'],
    );
  }

  Stream<List<schoolModel>> get allSchoolData {
    return schoolCollection.snapshots().map(_createSchoolModelList);
  }

  // Stream<List<schoolModel>> schoolSearch(String schoolNameSearch) {
  //   String temp;
  //   if (schoolNameSearch == ''){
  //     temp = '';
  //   } else {
  //     temp = schoolNameSearch[0].toUpperCase() + schoolNameSearch.substring(1);
  //   }
  //   //String temp = searchSchoolNameFormatting(schoolNameSearch);
  //   print(temp);
  //   return schoolCollection
  //       .where('schoolName', isGreaterThanOrEqualTo: temp)
  //       .snapshots()
  //       .map(_createSchoolModelList);
  // }

  Stream<List<schoolModel>> schoolSearch(String search) {
    return schoolCollection
        .where('schoolName', isGreaterThanOrEqualTo: search)
        .where('search', isLessThan: search + 'z')
        .snapshots()
        .map(_createSchoolModelList);
  }

  String searchSchoolNameFormatting(String schoolName) {
    if (schoolName == '') {
      return schoolName;
    }
    String temp = schoolName[0].toUpperCase() + schoolName.substring(1);
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

  List<schoolModel> _createSchoolModelList(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return schoolModel(
          schoolId: doc.get('schoolId'),
          schoolName: doc.get('schoolName'),
          schoolAddress: doc.get('schoolAddress'),
          schoolEmail: doc.get('schoolEmail'),
          schoolPhoneNumber: doc.get('schoolPhoneNumber'));
    }).toList();
  }

  Future<void> updateSchoolData(
    String schoolId,
    String schoolName,
    String schoolAddress,
    String schoolEmail,
    String schoolPhoneNumber,
  ) async {
    return await schoolCollection.doc(schoolId).set({
      'schoolId': schoolId,
      'schoolName': schoolName,
      'schoolAddress': schoolAddress,
      'schoolEmail': schoolEmail,
      'schoolPhoneNumber': schoolPhoneNumber
    });
  }

  Future<void> createSchoolData(
    String schoolName,
    String schoolAddress,
    String schoolEmail,
    String schoolPhoneNumber,
  ) async {
    final document = schoolCollection.doc();
    return await schoolCollection.doc(document.id).set({
      'schoolId': document.id,
      'schoolName': schoolName,
      'schoolAddress': schoolAddress,
      'schoolEmail': schoolEmail,
      'schoolPhoneNumber': schoolPhoneNumber
    });
  }

  //get specific staff
  Stream<classModel> classData(String classId) {
    return classCollection.doc(classId).snapshots().map(_createClassModel);
  }

  classModel _createClassModel(DocumentSnapshot snapshot) {
    return classModel(
      classId: snapshot.id,
      schoolId: snapshot['schoolId'],
      className: snapshot['className'],
      classYear: snapshot['classYear'],
      classStatus: snapshot['classStatus'],
    );
  }

  Stream<List<classModel>> get allclassData {
    return classCollection.snapshots().map(_createClassModelList);
  }

  Stream<List<classModel>> allclassDataWithSchoolId(String schoolId) {
    return classCollection
        .where('schoolId', isEqualTo: schoolId)
        .orderBy('classYear', descending: true)
        .snapshots()
        .map(_createClassModelList);
  }

  Stream<List<classModel>> allUnoccupiedClassDataWithSchoolId(String schoolId) {
    return classCollection
        .where('schoolId', isEqualTo: schoolId)
        .where('classStatus', isEqualTo: 'unoccupied')
        .snapshots()
        .map(_createClassModelList);
  }


  List<classModel> _createClassModelList(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return classModel(
        classId: doc.get('classId'),
        schoolId: doc.get('schoolId'),
        className: doc.get('className'),
        classYear: doc.get('classYear'),
        classStatus: doc.get('classStatus')
      );
    }).toList();
  }

  Future<void> updateClassData(
    String classId,
    String schoolId,
    String className,
    String classYear,
    String classStatus
  ) async {
    return await classCollection.doc(classId).set({
      'classId': classId,
      'schoolId': schoolId,
      'className': className,
      'classYear': classYear,
      'classStatus': classStatus
    });
  }

  Future<void> createClassData(
    String schoolId,
    String className,
    String classYear,
    String classStatus
  ) async {
    final document = classCollection.doc();
    return await classCollection.doc(document.id).set({
      'classId': document.id,
      'schoolId': schoolId,
      'className': className,
      'classYear': classYear,
      'classStatus': classStatus
    });
  }
}
