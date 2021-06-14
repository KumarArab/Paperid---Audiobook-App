import 'package:audiobook/models/bookModel.dart';
import 'package:audiobook/models/chapterModel.dart';
import 'package:audiobook/models/user.dart';
import 'package:audiobook/ui/screens/tabs/home%20tabs/genres.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  Future<bool> isFirstTime() async {
    final SharedPreferences _preferences =
        await SharedPreferences.getInstance();
    bool ift = _preferences.getBool('isFirstTime');
    print("is First Time: $ift");
    if (ift == null) {
      _preferences.setBool('isFirstTime', false);
      return true;
    }
    return false;
  }

  Future<List<FBookModel>> getGenreBook(Genres genre) async {
    List<FBookModel> genreBookList = [];
    DocumentReference document =
        _firestore.collection("Genre").doc("Action & Adventrue");
    document.get();
  }

  Future<List<FBookModel>> getBooks() async {
    List<FBookModel> bookList;

    bookList = [];
    QuerySnapshot snapshot = await _firestore.collection("Books").get();

    for (int i = 0; i < snapshot.size; i++) {
      Map<String, dynamic> bookData = snapshot.docs[i].data();
      List<FChapterModel> chapters = await getChaptersData(bookData["id"]);
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
    return bookList;
  }

  Future<List<FChapterModel>> getChaptersData(String id) async {
    List<FChapterModel> chapters = [];
    try {
      QuerySnapshot snapshot = await _firestore
          .collection("Books")
          .doc(id)
          .collection("Chapters")
          .orderBy('id')
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
