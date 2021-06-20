import 'package:audiobook/models/bookModel.dart';
import 'package:audiobook/services/appData.dart';
import 'package:audiobook/ui/widgets/book.dart';
import 'package:audiobook/utils/appTheme.dart';
import 'package:audiobook/utils/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BookGrid extends StatelessWidget {
  final List<FBookModel> books;
  BookGrid({@required this.books});
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        child: books.length == 0
            ? Center(
                child: SnackToast().showLoadingAsset(),
              )
            : GridView.count(
                childAspectRatio: 1 / 1.8,
                crossAxisCount: 2,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
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
                              color:
                                  AppTheme().mulledWineColor.withOpacity(0.5),
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
