import 'package:cloud_firestore/cloud_firestore.dart';

class FUser {
  String uid;
  String name;
  String email;
  String photoUrl;
  Timestamp accountCreated;
  String username;

  FUser(
      {this.uid,
      this.name,
      this.email,
      this.photoUrl,
      this.accountCreated,
      this.username});

  Map<String, dynamic> toMap() {
    return {
      "uid": uid,
      "name": name,
      "email": email,
      "photo": photoUrl,
      "accountCreated": accountCreated,
      "username": username
    };
  }

  FUser.fromDocumentSnapshot({DocumentSnapshot doc}) {
    uid = doc.id;
    email = doc.get("email");
    accountCreated = doc.get("accountCreated");
    name = doc.get("name");
    photoUrl = doc.get("photo");
    username = doc.get("username");
  }
}
