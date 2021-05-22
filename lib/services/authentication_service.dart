import 'package:audiobook/models/user.dart';
import 'package:audiobook/services/database.dart';
import 'package:audiobook/ui/screens/home.dart';
import 'package:audiobook/ui/screens/login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthenticaitonService with ChangeNotifier {
  final FirebaseAuth _firebaseAuth;
  AuthenticaitonService(this._firebaseAuth);
  final googleSignIn = GoogleSignIn();
  UserCredential _userCredential;
  FUser _currentUser = FUser();
  bool _isSigningIn = false;
  bool _isSigningUp = false;
  bool _isGoogleLogin = false;

// GETTERS AND SETTERS

  bool get isSigningIn => _isSigningIn;

  set isSigningIn(bool isSigningIn) {
    _isSigningIn = isSigningIn;
    notifyListeners();
  }

  bool get isGoogleLogin => _isGoogleLogin;

  set isGoogleLogin(bool isGoogleLogin) {
    _isGoogleLogin = isGoogleLogin;
    notifyListeners();
  }

  bool get isSigningUp => _isSigningUp;

  set isSigningUp(bool isSigningUp) {
    _isSigningUp = isSigningUp;
    notifyListeners();
  }

  UserCredential get userData => _userCredential;

  set userData(UserCredential userCredential) {
    _userCredential = userCredential;
    notifyListeners();
  }

  FUser get currentUser => _currentUser;

  Stream<User> get authStateChanges => _firebaseAuth.authStateChanges();

  Future<bool> startUp(User firebaseuser) async {
    _currentUser = await FDatabase().getUserInfo(firebaseuser.uid);
    if (_currentUser != null) {
      return true;
    }
    return false;
  }

// GETTERS AND SETTERS ---------   END

// EMAIL SIGNIN

  Future<String> signIn(String email, String password) async {
    isSigningIn = true;
    try {
      _userCredential = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      _currentUser = await FDatabase().getUserInfo(userData.user.uid);

      if (_currentUser != null) {
        isSigningIn = false;
        return "success";
      }
      isSigningIn = false;
      return "Something went wrong, please try again";
    } on FirebaseAuthException catch (e) {
      isSigningIn = false;
      return e.message;
    } catch (e) {
      print(e);
      return e;
    }
  }

// EMAIL SIGNUP

  Future<String> signUp(String name, String email, String password) async {
    FUser user;
    isSigningUp = true;
    try {
      userData = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);

      user = FUser(
          name: name,
          email: userData.user.email,
          uid: userData.user.uid,
          accountCreated:
              Timestamp.fromDate(userData.user.metadata.creationTime),
          photoUrl: "");
      String result = await FDatabase().createUser(user);
      if (result == "success") {
        isSigningUp = false;
        return "success";
      }
      isSigningUp = false;
      return "crap!";
    } on FirebaseAuthException catch (e) {
      isSigningUp = false;
      return e.message;
    }
  }

// GOOGLE LOGIN

  Future<String> login() async {
    isGoogleLogin = true;
    FUser user;
    final gUser = await googleSignIn.signIn();
    if (gUser == null) {
      isGoogleLogin = false;
      return "No user found!";
    } else {
      try {
        final googleAuth = await gUser.authentication;

        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
        userData = await _firebaseAuth.signInWithCredential(credential);
        if (userData.additionalUserInfo.isNewUser) {
          user = FUser(
              uid: userData.user.uid,
              name: userData.user.displayName,
              email: userData.user.email,
              photoUrl: userData.user.photoURL,
              accountCreated:
                  Timestamp.fromDate(userData.user.metadata.creationTime));
          FDatabase().createUser(user);
        }
        _currentUser = await FDatabase().getUserInfo(userData.user.uid);

        if (_currentUser != null) {
          isGoogleLogin = false;
          return "success";
        }
        isGoogleLogin = false;
        return "Something went wrong, please try again";
      } on FirebaseAuthException catch (e) {
        isGoogleLogin = false;
        return e.message;
      }
    }
  }

// LOGOUT

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
    _currentUser = FUser();
  }
}
