import 'package:audiobook/models/bookModel.dart';
import 'package:audiobook/services/booksData.dart';
import 'package:audiobook/ui/widgets/book.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BookGrid extends StatelessWidget {
  List<FBookModel> books;
  BookGrid({this.books});
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        child: GridView.count(
          // Create a grid with 2 columns. If you change the scrollDirection to
          // horizontal, this produces 2 rows.
          childAspectRatio: 1 / 1.35,
          crossAxisCount: 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
          // Generate 100 widgets that display their index in the List.
          children: List.generate(books.length, (index) {
            FBookModel book = books[index];
            return Book(book: book);
          }),
        ),
      ),
    );
  }
}
