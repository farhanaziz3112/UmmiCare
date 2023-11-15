import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ummicare/models/advisorModel.dart';
import 'package:ummicare/models/childModel.dart';
import 'package:ummicare/models/parentModel.dart';
import 'package:ummicare/models/staffUserModel.dart';
import 'package:ummicare/services/advisorDatabase.dart';
import 'package:ummicare/services/childDatabase.dart';
import 'dart:io';

import 'package:ummicare/services/parentDatabase.dart';
import 'package:ummicare/services/staffDatabase.dart';

class StorageService {
  //root reference
  Reference referenceRoot = FirebaseStorage.instance.ref();

  //profile pic parent folder reference
  late Reference parentFolderReference = referenceRoot.child('parent');

  //profile pic parent folder reference
  late Reference staffFolderReference = referenceRoot.child('staff');

  //profile pic advisor folder reference
  late Reference advisorFolderReference = referenceRoot.child('advisor');

  //profile pic admin folder reference
  late Reference adminFolderReference = referenceRoot.child('admin');

  //profile pic child folder reference
  late Reference childFolderReference = referenceRoot.child('child');

  //profile pic child folder reference
  late Reference teacherFolderReference = referenceRoot.child('teacher');

  //profile pic child folder reference
  late Reference medicalStaffFolderReference =
      referenceRoot.child('medicalStaff');

  //profile pic child folder reference
  late Reference chatFolderReference = referenceRoot.child('chat');

  //upload document for staff application
  Future<String> uploadDocumentForStaffApplication(
      String userType, PlatformFile? uploadedFile) async {
    String uniqueFileName = DateTime.now().millisecondsSinceEpoch.toString();

    Reference fileToUpload;

    final File filePath = File(uploadedFile!.path.toString());

    if (userType == 'advisor') {
      fileToUpload =
          advisorFolderReference.child('application').child(uniqueFileName);
    } else if (userType == 'teacher') {
      fileToUpload =
          teacherFolderReference.child('application').child(uniqueFileName);
    } else {
      fileToUpload = medicalStaffFolderReference
          .child('application')
          .child(uniqueFileName);
    }

    String documentUrl = '';

    try {
      await fileToUpload.putFile(filePath);
      documentUrl = await fileToUpload.getDownloadURL();
      print('Document URL: ${documentUrl}');
    } catch (e) {
      print(e);
    }

    return documentUrl;
  }

  //upload multiple document for staff application
  Future<List<String>> uploadMultipleDocumentForStaffApplication(
      String userType, List<File> files) async {
    String uniqueFileName = DateTime.now().millisecondsSinceEpoch.toString();

    Reference fileToUpload;

    //final File filePath = File(uploadedFile!.path.toString());

    if (userType == 'advisor') {
      fileToUpload =
          advisorFolderReference.child('application').child(uniqueFileName);
    } else if (userType == 'teacher') {
      fileToUpload =
          teacherFolderReference.child('application').child(uniqueFileName);
    } else {
      fileToUpload = medicalStaffFolderReference
          .child('application')
          .child(uniqueFileName);
    }

    List<String> documentUrl = [];

    for (var i = 0; i < files.length; i++) {
      //try {
      await fileToUpload.putFile(File(files[i].path));
      documentUrl.add(await fileToUpload.getDownloadURL());
      print('Document URL: ${documentUrl[i]}');
      // } catch (e) {
      //   print(e);
      // }
    }

    return documentUrl;
  }

  //upload image to user folder
  Future<String> uploadStaffProfilePic(staffUserModel staff, XFile file) async {
    String uniqueFileName = DateTime.now().millisecondsSinceEpoch.toString();

    Reference imageToUpload;
    String imageUrl = '';

    // if (userType == 'advisor') {
    //   imageToUpload = advisorFolderReference.child(uniqueFileName);
    //   try {
    //     await imageToUpload.putFile(File(file.path));
    //     imageUrl = await imageToUpload.getDownloadURL();
    //     print('Image URL: ${imageUrl}');
    //     updateStaffProfileImageUrl(staff, imageUrl);
    //   } catch (e) {
    //     print(e);
    //   }
    // } else if (userType == 'teacher') {
    //   imageToUpload = teacherFolderReference.child(uniqueFileName);
    // } else if (userType == 'medicalstaff') {
    //   imageToUpload = medicalStaffFolderReference.child(uniqueFileName);
    // } else {
    //   imageToUpload = adminFolderReference.child(uniqueFileName);
    // }

    return imageUrl;
  }

  //upload image to user folder
  Future<String> uploadAdvisorProfilePic(
      advisorModel advisor, XFile file) async {
    String uniqueFileName = DateTime.now().millisecondsSinceEpoch.toString();

    Reference imageToUpload;
    String imageUrl = '';
    imageToUpload = advisorFolderReference.child(uniqueFileName);
    try {
      await imageToUpload.putFile(File(file.path));
      imageUrl = await imageToUpload.getDownloadURL();
      print('Image URL: ${imageUrl}');
      updateAdvisorProfileImageUrl(advisor, imageUrl);
    } catch (e) {
      print(e);
    }
    return imageUrl;
  }

  //upload image to user folder
  Future<String> uploadParentProfilePic(parentModel parent, XFile file) async {
    String uniqueFileName =
        DateTime.now().millisecondsSinceEpoch.toString() + parent.parentId;

    Reference imageToUpload;

    // if (user.userType == 'parent') {
    imageToUpload = parentFolderReference.child(uniqueFileName);
    // } else if (user.userType == 'advisor') {
    //   imageToUpload = advisorFolderReference.child(uniqueFileName);
    // } else {
    //   imageToUpload = adminFolderReference.child(uniqueFileName);
    // }

    String imageUrl = '';

    try {
      await imageToUpload.putFile(File(file.path));
      imageUrl = await imageToUpload.getDownloadURL();
      print('Image URL: ${imageUrl}');
      updateParentProfileImageUrl(parent, imageUrl);
    } catch (e) {
      print(e);
    }

    return imageUrl;
  }

  //upload image to child folder
  Future<String> uploadChildProfilePic(childModel child, XFile file) async {
    String uniqueFileName = DateTime.now().millisecondsSinceEpoch.toString();

    Reference imageToUpload = childFolderReference.child(uniqueFileName);

    String imageUrl = '';

    try {
      await imageToUpload.putFile(File(file.path));
      imageUrl = await imageToUpload.getDownloadURL();
      print('Image URL: ${imageUrl}');
      updateChildProfileImageUrl(child, imageUrl);
    } catch (e) {
      print(e);
    }

    return imageUrl;
  }

  //update user image url
  void updateParentProfileImageUrl(parentModel parent, String imageUrl) {
    print('Updating parent: ${parent.parentId}');
    parentDatabase(parentId: parent.parentId).updateParentData(
        parent.parentId,
        parent.parentCreatedDate,
        parent.parentFullName,
        parent.parentFirstName,
        parent.parentLastName,
        parent.parentEmail,
        parent.parentPhoneNumber,
        imageUrl,
        parent.advisorId,
        parent.noOfChild);
  }

  //update user image url
  void updateStaffProfileImageUrl(staffUserModel staff, String imageUrl) {
    print('Updating staff: ${staff.staffId}');
    staffDatabase(staffId: staff.staffId).updateStaffData(
        staff.staffId,
        staff.staffCreatedDate,
        staff.staffUserType,
        staff.staffFullName,
        staff.staffFirstName,
        staff.staffLastName,
        staff.staffEmail,
        staff.staffPhoneNumber,
        staff.staffSupportingDocumentLink,
        imageUrl,
        staff.isVerified);
  }

  //update user image url
  void updateAdvisorProfileImageUrl(advisorModel advisor, String imageUrl) {
    print('Updating advisor: ${advisor.advisorId}');
    advisorDatabase(advisorId: advisor.advisorId).updateAdvisorData(
        advisor.advisorId,
        advisor.advisorCreatedDate,
        advisor.advisorFullName,
        advisor.advisorFirstName,
        advisor.advisorLastName,
        advisor.advisorEmail,
        advisor.advisorPhoneNumber,
        imageUrl,
        advisor.noOfParents);
  }

  //update child image url
  void updateChildProfileImageUrl(childModel child, String imageUrl) {
    print('Updating user: ${child.childId}');
    childDatabase(childId: child.childId)
        .updateChildData(
            child.childId,
            child.parentId,
            child.childCreatedDate,
            child.childName,
            child.childFirstname,
            child.childLastname,
            child.childBirthday,
            child.childCurrentAge,
            child.childAgeCategory,
            imageUrl,
            child.educationId,
            child.healthId);
  }

  Future<String> uploadChatImage(XFile file) async {
    String uniqueFileName = DateTime.now().millisecondsSinceEpoch.toString();

    Reference imageToUpload = chatFolderReference.child(uniqueFileName);

    String imageUrl = '';

    try {
      await imageToUpload.putFile(File(file.path));
      imageUrl = await imageToUpload.getDownloadURL();
      print('Image URL: ${imageUrl}');
    } catch (e) {
      print(e);
    }

    return imageUrl;
  }
}
