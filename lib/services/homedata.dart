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
  List<FBookModel> _books;

  List<FBookModel> get books => _books ?? [];

  set updateBooks(List<FBookModel> books) {
    _books = books;
    print("Books updated ${books.length}");
    // notifyListeners();
  }

  Future<String> fetchBooks() async {
    List<FBookModel> bookList = await FDatabase().getBooks();
    updateBooks = bookList;
    return "success";
  }
}
