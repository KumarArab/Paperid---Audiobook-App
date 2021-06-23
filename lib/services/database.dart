import 'package:audiobook/models/authorModel.dart';
import 'package:audiobook/models/bookModel.dart';
import 'package:audiobook/models/chapterModel.dart';
import 'package:audiobook/models/shelfModel.dart';
import 'package:audiobook/models/user.dart';
import 'package:audiobook/services/appData.dart';
import 'package:audiobook/services/authentication_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FDatabase {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseDatabase _database = FirebaseDatabase.instance;
  AuthenticaitonService user;

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

  Future<List<FBookModel>> getGenreBooks(String genre) async {
    List<FBookModel> genreBookList = [];
    DocumentSnapshot genreData =
        await _firestore.collection("Genres").doc(genre).get();
    List bookList = genreData["books"];
    for (int i = 0; i < bookList.length; i++) {
      genreBookList.add(await getBookData(bookList[i]));
    }
    return genreBookList;
  }

  Future<List<FBookModel>> getAuthorBooks(String author) async {
    List<FBookModel> authorBookList = [];
    DocumentSnapshot authorData =
        await _firestore.collection("Authors").doc(author).get();
    List bookList = authorData["books"];
    for (int i = 0; i < bookList.length; i++) {
      authorBookList.add(await getBookData(bookList[i]));
    }
    return authorBookList;
  }

  Future<List<FBookModel>> getCurrentlyListeningBooks(
      List<String> bookList) async {
    List<FBookModel> authorBookList = [];
    for (int i = 0; i < bookList.length; i++) {
      authorBookList.add(await getBookData(bookList[i]));
    }
    return authorBookList;
  }

  Future<FBookModel> getBookData(String bookId) async {
    DocumentSnapshot bookData =
        await _firestore.collection("Books").doc(bookId).get();
    List<FChapterModel> chapters = await getChaptersData(bookData["id"]);
    FBookModel book = FBookModel(
      id: bookData['id'],
      name: bookData['Name'] ?? "Unknown",
      author: bookData['Author'] ?? "Unknown",
      cover: bookData['Cover'] ?? "Unknown",
      genre: bookData['Genre'],
      preface: bookData["Preface"],
      rating: bookData["Rating"],
      color: bookData['color'],
      audios: chapters,
    );
    return book;
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
        color: bookData['color'],
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

  Future<List<FAuthorModel>> getAuthorDetails() async {
    List<FAuthorModel> authorList = [];
    try {
      QuerySnapshot snapshot = await _firestore.collection("Authors").get();
      for (int i = 0; i < snapshot.size; i++) {
        Map<String, dynamic> authorData = snapshot.docs[i].data();
        authorList.add(FAuthorModel(
            imagepath: authorData['imageUrl'],
            name: authorData['name'],
            books: authorData['books']));
      }
    } catch (e) {
      print(e);
    }
    return authorList;
  }

  Future<List<FAuthorModel>> getAuthorAlphaSearchDetails(String start) async {
    List<FAuthorModel> authorList = [];
    try {
      QuerySnapshot snapshot = await _firestore
          .collection("Authors")
          .where('start', isEqualTo: start)
          .get();
      for (int i = 0; i < snapshot.size; i++) {
        Map<String, dynamic> authorData = snapshot.docs[i].data();
        authorList.add(FAuthorModel(
            imagepath: authorData['imageUrl'],
            name: authorData['name'],
            books: authorData['books']));
      }
    } catch (e) {
      print(e);
    }
    return authorList;
  }

  Future<void> addToShelves(String bookId, FShelfModel shelf) async {
    try {
      shelf.books.add(bookId);
      await _firestore
          .collection("users")
          .doc(user.currentUser.uid)
          .collection("shelves")
          .doc(shelf.name)
          .set({
        "books": shelf.books,
        "name": shelf.name,
      }, SetOptions(merge: true, mergeFields: ["books"]));
    } catch (e) {
      print(e.toString());
    }
  }

  Future<List<FShelfModel>> getShelves() async {
    List<FShelfModel> shelves;
    try {
      QuerySnapshot shelfSnapshot = await _firestore
          .collection("users")
          .doc(user.currentUser.uid)
          .collection("shelves")
          .get();
      assert(shelfSnapshot != null);
      shelfSnapshot.docs.forEach((element) {
        shelves.add(FShelfModel(
          books: element["books"],
          name: element["name"],
        ));
      });
    } catch (e) {
      print(e.toString());
    }
    return shelves;
  }

  // ------------------------ REALTIME DATABASE FUNCTIONS ------------------------------//

  Future<bool> isUsernameAvailable(String username) async {
    DataSnapshot snapshot =
        await _database.reference().child("usernames").child(username).once();
    return snapshot.value == null;
  }

  // ------------------------- LOCAL DATABASE FUNCTIONS --------------------------------//

  Future<bool> isFirstTime() async {
    final SharedPreferences _preferences =
        await SharedPreferences.getInstance();
    bool ift = _preferences.getBool('isFirstTime');
    if (ift == null) {
      _preferences.setBool('isFirstTime', false);
      return true;
    }
    return false;
  }

  Future<void> addToLocalCurrentlyListening(String bookId) async {
    final SharedPreferences _preferences =
        await SharedPreferences.getInstance();
    List<String> bookList = _preferences.getStringList("CurList");
    if (bookList == null) {
      _preferences.setStringList("CurList", [bookId]);
      print("cache library created");
    } else if (!bookList.contains(bookId)) {
      bookList.add(bookId);
      _preferences.setStringList("CurList", bookList);
      print("book added locally");
    }
  }

  Future<List<String>> getLocalCurrentlyListeningBooks() async {
    final SharedPreferences _preferences =
        await SharedPreferences.getInstance();
    List<String> bookList = _preferences.getStringList("CurList");

    return bookList ?? [];
  }
}
