import 'package:audiobook/models/bookModel.dart';
import 'package:audiobook/services/database.dart';
import 'package:flutter/cupertino.dart';

enum category {
  All,
  Trending,
  Fiction,
  Fantasy,
}

class HomeData with ChangeNotifier {
  List<FBookModel> _books = [];
  List<FBookModel> _genreBooks = [];

  List<FBookModel> get books => _books;
  List<FBookModel> get genreBooks => _genreBooks;

  set updateBooks(List<FBookModel> books) {
    _books = books;
    notifyListeners();
  }

  set updateGenreBooks(List<FBookModel> books) {
    _genreBooks += books;
    notifyListeners();
  }

  Future<String> getGenreBooks(String genre) async {
    try {
      List<FBookModel> bookList = await FDatabase().getGenreBook(genre);
      updateGenreBooks = bookList;
      return "success";
    } on Exception catch (e) {
      return e.toString();
    }
  }

  Future<String> fetchBooks() async {
    List<FBookModel> bookList = await FDatabase().getBooks();
    updateBooks = bookList;
    return "success";
  }
}
