import 'package:audiobook/models/bookModel.dart';
import 'package:audiobook/services/booksData.dart';
import 'package:audiobook/ui/widgets/book.dart';
import 'package:audiobook/utils/appTheme.dart';
import 'package:audiobook/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Booksection extends StatelessWidget {
  final String heading;
  Booksection({this.heading});
  @override
  Widget build(BuildContext context) {
    List<FBookModel> bookList = [];
    if (context.watch<BookData>().allBooks.length != 0) {
      if (heading == "Currently Listening") {
        bookList = context.watch<BookData>().allBooks.sublist(3, 5);
      } else if (heading == "Trending") {
        bookList = context.watch<BookData>().allBooks;
      } else if (heading == "You May Like" || heading == "AudioBooks") {
        bookList = context.watch<BookData>().allBooks.reversed.toList();
      }
    }

    print(context.watch<BookData>().allBooks.length);
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            height: kToolbarHeight,
            child: Row(
              children: [
                Text(
                  heading,
                  style: Theme.of(context).textTheme.headline5.copyWith(
                      fontWeight: FontWeight.w700, color: Colors.black),
                ),
                Spacer(),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    "View All",
                    style: Theme.of(context)
                        .textTheme
                        .subtitle1
                        .copyWith(color: AppTheme().primaryColor),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: SizeConfig.width * 0.8,
            child: context.watch<BookData>().allBooks.length == 0
                ? Center(child: CircularProgressIndicator())
                : ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: bookList.length,
                    itemBuilder: (ctx, i) {
                      FBookModel book = bookList[i];
                      return Container(
                        margin: EdgeInsets.only(right: 30),
                        child: Column(
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
                                style: Theme.of(context)
                                    .textTheme
                                    .headline6
                                    .copyWith(
                                      color: Colors.black87,
                                      fontWeight: FontWeight.w600,
                                    ),
                              ),
                            ),
                            Text(
                              book.author ?? "By Unknown",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  .copyWith(
                                    color: AppTheme()
                                        .mulledWineColor
                                        .withOpacity(0.5),
                                    fontWeight: FontWeight.w500,
                                  ),
                            )
                          ],
                        ),
                      );
                    },
                  ),
          )
        ],
      ),
    );
  }
}
