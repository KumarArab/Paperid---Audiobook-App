import 'package:audiobook/models/bookModel.dart';
import 'package:audiobook/models/chapterModel.dart';
import 'package:audiobook/models/user.dart';
import 'package:audiobook/services/homedata.dart';
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

  Future<List<FBookModel>> getBookData() async {
    List<FBookModel> bookList = [];

    try {
      QuerySnapshot snapshot = await _firestore.collection("Books").get();
      if (snapshot.size != 0) {
        snapshot.docs.forEach((element) async {
          Map<String, dynamic> bookData = element.data();
          List<FChapterModel> chapters = await getChaptersData(bookData["id"]);
          if (element.exists) {
            FBookModel book = FBookModel(
              id: bookData['id'],
              name: bookData['Name'],
              author: bookData['Author'],
              cover: bookData['Cover'],
              genre: bookData['Genre'],
              preface: bookData["Preface"],
              rating: bookData["Rating"],
              audios: chapters,
            );
            bookList.add(book);
          }
        });
      }
    } catch (e) {
      print(e);
    }

    return bookList;
  }

  Future<List<FChapterModel>> getChaptersData(String id) async {
    List<FChapterModel> chapters = [];

    try {
      QuerySnapshot snapshot = await _firestore
          .collection("Books")
          .doc(id)
          .collection("Chapters")
          .get();
      if (snapshot.size != 0) {
        snapshot.docs.forEach((element) {
          Map<String, dynamic> chapterData = element.data();
          if (element.exists) {
            FChapterModel chapter = FChapterModel(
              name: chapterData["Name"],
              url: chapterData["Url"],
            );
            chapters.add(chapter);
          }
        });
      }
    } catch (e) {
      print(e);
    }
    return chapters;
  }
}
