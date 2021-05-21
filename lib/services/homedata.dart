import 'package:audiobook/models/bookModel.dart';
import 'package:audiobook/services/database.dart';
import 'package:flutter/cupertino.dart';

enum category {
  All,
  Trending,
  Fiction,
  Fantasy,
}

class HomeData extends ChangeNotifier {
  List<FBookModel> _books = [];

  List<FBookModel> get getbooks => _books;

  set updateBooks(List<FBookModel> books) {
    _books = books;
    notifyListeners();
  }

  Future<String> fetchBooks(category cat) async {
    //if (cat == category.All) {
    updateBooks = await FDatabase().getBookData();
    //}
    return "success";
  }
}
