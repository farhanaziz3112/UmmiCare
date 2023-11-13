import 'package:firebase_auth/firebase_auth.dart';
import 'package:ummicare/services/parentDatabase.dart';
import 'package:ummicare/models/userModel.dart';
import 'package:ummicare/services/staffDatabase.dart';
import 'package:ummicare/services/userDatabase.dart';
import 'package:ummicare/shared/function.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //create user object based on the firebase user verified
  userModel? _userAuthObjectFromFirebase(User user) {
    // ignore: unnecessary_null_comparison
    return user != null
        ? userModel(
            userId: user.uid, userType: '', userEmail: user.email.toString())
        : null;
  }

  String getUserLastSignedIn() {
    return getLastSignedInFormat(_auth
        .currentUser!.metadata.lastSignInTime!.millisecondsSinceEpoch
        .toString());
  }

  //auth change user stream
  Stream<userModel?> get user {
    return _auth
        .authStateChanges()
        .map((User? user) => _userAuthObjectFromFirebase(user!));
  }

  //register new parent with email and password
  Future registerParentWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential authResult = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = authResult.user;
      await userDatabase(userId: user!.uid)
          .updateUserData(user.uid, 'parent', user.email.toString());
      await parentDatabase(parentId: user.uid).updateParentData(
          user.uid, 'New User', '-', '-', user.email.toString(), '-', '-', '');
      return _userAuthObjectFromFirebase(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //register new staff with email and password
  Future registerStaffWithEmailAndPassword(
    String email,
    String password,
    String staffUserType,
    String staffFullName,
    String staffFirstName,
    String staffLastName,
    String staffPhoneNumber,
    String staffProfileImg,
    String staffSupportingDocumentLink,
    String isVerified
  ) async {
    try {
      //var originalUser = _auth.currentUser!;
      UserCredential authResult = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      //_auth.sign(originalUser);
      User? user = authResult.user;
      await userDatabase(userId: user!.uid)
          .updateUserData(user.uid, staffUserType, user.email.toString());
      await staffDatabase(staffId: user.uid).updateStaffData(
          user.uid,
          staffUserType,
          staffFullName,
          staffFirstName,
          staffLastName,
          email,
          staffPhoneNumber,
          staffSupportingDocumentLink,
          '-',
          isVerified);
      //return _userAuthObjectFromFirebase(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //sign in with email and password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential authResult = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = authResult.user;
      return user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //reset password
  Future resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }
}
