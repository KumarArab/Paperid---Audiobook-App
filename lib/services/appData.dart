import 'package:audiobook/models/authorModel.dart';
import 'package:audiobook/models/bookModel.dart';
import 'package:audiobook/models/shelfModel.dart';
import 'package:audiobook/services/database.dart';
import 'package:audiobook/ui/screens/tabs/shelf.dart';
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

enum AuthorSearch { All, Start, Keyword }

class AppData with ChangeNotifier {
  FDatabase database = FDatabase();
  // BOOK DATA
  List<FBookModel> _allBooks = [];
  List<FBookModel> _currRead = [];
  List<FBookModel> _trending = [];
  List<FBookModel> _youMayLike = [];
  List<FBookModel> _genreBooks = [];
  List<FBookModel> _authorBooks = [];

  // AUTHOR DATA
  List<FAuthorModel> _authorList = [];
  List<FAuthorModel> _searchAuthorList = [];

  List<FShelfModel> _shelves = [];

  List<FBookModel> get currReadbooks => _currRead;
  List<FBookModel> get trendingBooks => _trending;
  List<FBookModel> get youMayLikeBooks => _youMayLike;
  List<FBookModel> get genreBooks => _genreBooks;
  List<FBookModel> get authorBooks => _authorBooks;
  List<FBookModel> get allBooks => _allBooks;

  List<FAuthorModel> get allAuthors => _authorList;
  List<FAuthorModel> get searchAuthorResult => _searchAuthorList;

  List<FShelfModel> get getShelves => _shelves;

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

  set updateAuthorList(List<FAuthorModel> authors) {
    _authorList = authors;
    notifyListeners();
  }

  set updateAuthorSearchList(List<FAuthorModel> authors) {
    _searchAuthorList = authors;
    notifyListeners();
  }

  set updateShelves(List<FShelfModel> shelves) {
    _shelves = shelves;
    notifyListeners();
  }

  set addShelfToShelves(FShelfModel shelf) {
    _shelves.add(shelf);
    notifyListeners();
  }

  Future<String> fetchBooks(Section section, String data) async {
    List<FBookModel> bookList;
    switch (section) {
      case Section.CurrRead:
        var localbookList = await database.getLocalCurrentlyListeningBooks();
        if (localbookList != null && localbookList.isNotEmpty) {
          bookList = await database.getCurrentlyListeningBooks(localbookList);
          updateCurrReadBooks = bookList;
        }

        break;
      case Section.Trending:
        bookList = await FDatabase().getGenreBooks(data);
        updateTrendingBooks = bookList;

        break;
      case Section.YouMayLike:
        bookList = await FDatabase().getBooks();
        updateYouMayLikeBooks = bookList;

        break;
      case Section.Genre:
        _genreBooks.clear();
        bookList = await FDatabase().getGenreBooks(data);
        updateGenreBooks = bookList;

        break;
      case Section.Author:
        _authorBooks.clear();
        bookList = await FDatabase().getAuthorBooks(data);
        updateAuthorBooks = bookList;

        break;
      case Section.All:
        bookList = await FDatabase().getBooks();
        updateAllBooks = bookList;
        break;
    }
    // updateBooks = bookList;
    return "success";
  }

  Future<String> fetchAuthors(AuthorSearch searchType, String data) async {
    switch (searchType) {
      case AuthorSearch.All:
        updateAuthorList = await FDatabase().getAuthorDetails();
        break;
      case AuthorSearch.Start:
        _searchAuthorList.clear();
        updateAuthorSearchList =
            await FDatabase().getAuthorAlphaSearchDetails(data);
        break;
      case AuthorSearch.Keyword:
        break;
    }
    return "success";
  }

  Future<String> fetchShelves() async {
    updateShelves = await FDatabase().getShelves();
    return "success";
  }

  void addShelf(String shelfName) {
    addShelfToShelves = FShelfModel(name: shelfName, books: []);
  }
}
