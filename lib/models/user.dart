import 'package:cloud_firestore/cloud_firestore.dart';

class FUser {
  String uid;
  String name;
  String email;
  String photoUrl;
  Timestamp accountCreated;

  FUser({
    this.uid,
    this.name,
    this.email,
    this.photoUrl,
    this.accountCreated,
  });

  Map<String, dynamic> toMap() {
    return {
      "uid": uid,
      "name": name,
      "email": email,
      "photo": photoUrl,
      "accountCreated": accountCreated
    };
  }

  FUser.fromDocumentSnapshot({DocumentSnapshot doc}) {
    uid = doc.id;
    email = doc.get("email");
    accountCreated = doc.get("accountCreated");
    name = doc.get("name");
    photoUrl = doc.get("photo");
  }
}
