import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthenticaitonService extends ChangeNotifier {
  final FirebaseAuth _firebaseAuth;
  final googleSignIn = GoogleSignIn();
  bool _isSigningIn = false;
  bool _isGoogleLogin = false;
  AuthenticaitonService(this._firebaseAuth);
  UserCredential _userCredential;

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

  UserCredential get userCred => _userCredential;

  Stream<User> get authStateChanges => _firebaseAuth.authStateChanges();

  Future<String> signIn(String email, String password) async {
    isSigningIn = true;
    try {
      _userCredential = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      print(_userCredential.user);
      isSigningIn = false;
      return "Signed In";
    } on FirebaseAuthException catch (e) {
      isSigningIn = false;
      return e.message;
    }
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  Future<String> signUp(String email, String password) async {
    try {
      _userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      return "Signed Up";
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future login() async {
    isGoogleLogin = true;
    final user = await googleSignIn.signIn();
    if (user == null) {
      isSigningIn = false;
    } else {
      final googleAuth = await user.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      _userCredential = await _firebaseAuth.signInWithCredential(credential);
      isGoogleLogin = false;
    }
  }
}
