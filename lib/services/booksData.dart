import 'package:audiobook/models/bookModel.dart';
import 'package:audiobook/services/database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

enum Section {
  All,
  CurrRead,
  Trending,
  YouMayLike,
  Genre,
  Author,
}

class BookData with ChangeNotifier {
  // BOOK DATA
  List<FBookModel> _allBooks = [];
  List<FBookModel> _currRead = [];
  List<FBookModel> _trending = [];
  List<FBookModel> _youMayLike = [];
  List<FBookModel> _genreBooks = [];
  List<FBookModel> _authorBooks = [];

  List<FBookModel> get currReadbooks => _currRead;
  List<FBookModel> get trendingBooks => _trending;
  List<FBookModel> get youMayLikeBooks => _youMayLike;
  List<FBookModel> get genreBooks => _genreBooks;
  List<FBookModel> get authorBooks => _authorBooks;
  List<FBookModel> get allBooks => _allBooks;

  set updateCurrReadBooks(List<FBookModel> books) {
    _currRead = books;
    notifyListeners();
  }

  set updateTrendingBooks(List<FBookModel> books) {
    _trending = books;
    notifyListeners();
  }

  set updateYouMayLikeBooks(List<FBookModel> books) {
    _youMayLike = books;
    notifyListeners();
  }

  set updateGenreBooks(List<FBookModel> books) {
    _genreBooks = books;
    notifyListeners();
  }

  set updateAuthorBooks(List<FBookModel> books) {
    _authorBooks = books;
    notifyListeners();
  }

  set updateAllBooks(List<FBookModel> books) {
    _allBooks = books;
    notifyListeners();
  }

  Future<String> fetchBooks(Section section, String data) async {
    List<FBookModel> bookList;
    switch (section) {
      case Section.CurrRead:
        if (currReadbooks.isEmpty) {
          bookList = await FDatabase().getBooks();
          updateCurrReadBooks = bookList;
        }
        break;
      case Section.Trending:
        if (trendingBooks.isEmpty) {
          bookList = await FDatabase().getBooks();
          updateTrendingBooks = bookList;
        }

        break;
      case Section.YouMayLike:
        if (trendingBooks.isEmpty) {
          bookList = await FDatabase().getBooks();
          updateYouMayLikeBooks = bookList;
        }

        break;
      case Section.Genre:
        if (trendingBooks.isEmpty) {
          bookList = await FDatabase().getGenreBooks(data);
          updateGenreBooks = bookList;
        }

        break;
      case Section.Author:
        if (trendingBooks.isEmpty) {
          bookList = await FDatabase().getBooks();
          updateAuthorBooks = bookList;
        }

        break;
      case Section.All:
        if (trendingBooks.isEmpty) {
          bookList = await FDatabase().getBooks();
          updateAllBooks = bookList;
        }

        break;
    }
    // updateBooks = bookList;
    return "success";
  }
}
