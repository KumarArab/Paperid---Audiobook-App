import 'package:audiobook/models/bookModel.dart';
import 'package:audiobook/services/booksData.dart';
import 'package:audiobook/ui/widgets/book.dart';
import 'package:audiobook/utils/appTheme.dart';
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
          childAspectRatio: 1 / 1.7,
          crossAxisCount: 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
          // Generate 100 widgets that display their index in the List.
          children: List.generate(books.length, (index) {
            FBookModel book = books[index];
            return Column(
              children: [
                Book(book: book),
                SizedBox(height: 20),
                Container(
                  width: 200,
                  child: Text(
                    book.name ?? "Unknown",
                    softWrap: true,
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headline6.copyWith(
                          color: Colors.black87,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ),
                Text(
                  book.author ?? "By Unknown",
                  style: Theme.of(context).textTheme.bodyText1.copyWith(
                        color: AppTheme().mulledWineColor.withOpacity(0.5),
                        fontWeight: FontWeight.w500,
                      ),
                )
              ],
            );
          }),
        ),
      ),
    );
  }
}
