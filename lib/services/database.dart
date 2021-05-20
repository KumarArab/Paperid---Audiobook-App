import 'package:audiobook/models/bookModel.dart';
import 'package:audiobook/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FDatabase {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> createUser(FUser user) async {
    try {
      await _firestore.collection("users").doc(user.uid).set(user.toMap());
      return "success";
    } catch (e) {
      return e.message;
    }
  }

  Future<FUser> getUserInfo(String uid) async {
    FUser user;

    try {
      DocumentSnapshot snapshot =
          await _firestore.collection("users").doc(uid).get();
      if (snapshot.exists) {
        Map<String, dynamic> userData = snapshot.data();

        user = FUser(
            name: userData["name"],
            uid: uid,
            email: userData["email"],
            photoUrl: userData["photo"],
            accountCreated: userData["accountCreated"]);
      }
    } catch (e) {
      print(e);
    }
    return user;
  }

  Future<FBookModel> getBookData() async {
    FBookModel book;

    try {
      DocumentSnapshot snapshot =
          await _firestore.collection("Books").doc('B1').get();
      Map<String, dynamic> bookData = snapshot.data();
      if (snapshot.exists) {
        book = FBookModel(
          name: bookData['Name'],
          author: bookData['Author'],
          cover: bookData['Cover'],
          genre: bookData['Genre'],
          preface: bookData['Preface'],
          rating: bookData['Rating'],
          audios: bookData['Chapters'],
        );
      }
    } catch (e) {
      print(e);
    }

    return book;
  }
}
