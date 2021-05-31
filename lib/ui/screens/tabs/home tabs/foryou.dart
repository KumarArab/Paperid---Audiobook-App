import 'package:audiobook/models/bookModel.dart';
import 'package:audiobook/services/homedata.dart';
import 'package:audiobook/ui/screens/bookDetails.dart';
import 'package:audiobook/ui/screens/home.dart';
import 'package:audiobook/ui/widgets/book.dart';
import 'package:audiobook/utils/appTheme.dart';
import 'package:audiobook/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ForYou extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          BookSection(
            heading: "Currently Reading",
          ),
          BookSection(
            heading: "Trending",
          ),
          BookSection(
            heading: "You May Like",
          ),
        ],
      ),
    );
  }
}

class BookSection extends StatelessWidget {
  final String heading;
  BookSection({this.heading});
  @override
  Widget build(BuildContext context) {
    List<FBookModel> bookList = [];
    if (context.watch<HomeData>().books.length != 0) {
      if (heading == "Currently Reading") {
        bookList = context.watch<HomeData>().books.sublist(3, 5);
      } else if (heading == "Trending") {
        bookList = context.watch<HomeData>().books;
      } else if (heading == "You May Like") {
        bookList = context.watch<HomeData>().books.reversed.toList();
      }
    }

    print(context.watch<HomeData>().books.length);
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
            height: 420,
            child: context.watch<HomeData>().books.length == 0
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: bookList.length,
                    itemBuilder: (ctx, i) {
                      FBookModel book = bookList[i];
                      return GestureDetector(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (ctx) => BookDetails(
                              book: book,
                            ),
                          ),
                        ),
                        child: Container(
                          margin: EdgeInsets.only(left: 20, right: 10),
                          child: Column(
                            children: [
                              Book(coverUrl: book.cover),
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
                              SizedBox(
                                height: 2,
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
