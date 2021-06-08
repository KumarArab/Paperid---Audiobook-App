import 'package:audiobook/models/bookModel.dart';
import 'package:audiobook/services/homedata.dart';
import 'package:audiobook/ui/widgets/book.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BookGrid extends StatelessWidget {
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
          children:
              List.generate(context.watch<HomeData>().books.length, (index) {
            FBookModel book = context.watch<HomeData>().books[index];
            return Book(book: book);
          }),
        ),
      ),
    );
  }
}
