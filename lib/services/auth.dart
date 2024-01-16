import 'package:firebase_auth/firebase_auth.dart';
import 'package:ummicare/services/activityDatabase.dart';
import 'package:ummicare/services/parentDatabase.dart';
import 'package:ummicare/models/userModel.dart';
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

  bool isFirstTimeSignIn() {
    DateTime? firstLogin = _auth.currentUser!.metadata.creationTime;
    print(firstLogin.toString());
    DateTime? lastSignIn = _auth.currentUser!.metadata.lastSignInTime;
    print(lastSignIn.toString());
    Duration duration = firstLogin!.difference(lastSignIn!);
    if (duration.inMinutes < 1) {
      return true;
    } else {
      return false;
    }
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
      //for createdDate store in db
      String createdDate = DateTime.now().millisecondsSinceEpoch.toString();
      await parentDatabase(parentId: user.uid).updateParentData(
          user.uid,
          createdDate,
          'New User',
          '-',
          '-',
          user.email.toString(),
          '-',
          'https://firebasestorage.googleapis.com/v0/b/ummicare-6db1a.appspot.com/o/other%2Fistockphoto-1223671392-612x612.jpg?alt=media&token=0c876dbc-4385-4270-95bc-7a2130f243b1',
          '',
          '0');
      await activityDatabase().createactivityData(
          user.uid,
          '',
          'Checkout Education Module Now!',
          'Feel free to explore our exclusive education module!',
          'education',
          createdDate);
      await activityDatabase().createactivityData(
          user.uid,
          '',
          'Health Module Is Available!',
          'Special module to monitor your child\'s health. Now available!',
          'health',
          createdDate);
      await activityDatabase().createactivityData(
          user.uid,
          '',
          'Register to Buddy Now!',
          'Connect with community full of lovely and passionate parents!',
          'buddy',
          createdDate);
      return _userAuthObjectFromFirebase(user);
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
