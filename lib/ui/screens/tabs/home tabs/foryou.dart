import 'package:audiobook/services/booksData.dart';
import 'package:audiobook/ui/widgets/book_section.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ForYou extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            context.watch<BookData>().currReadbooks.length > 0
                ? Booksection(
                    heading: "Currently Listening",
                    books: context.watch<BookData>().currReadbooks,
                  )
                : SizedBox(),
            Booksection(
              heading: "Trending",
              books: context.watch<BookData>().trendingBooks,
            ),
            Booksection(
              heading: "You May Like",
              books: context.watch<BookData>().allBooks,
            ),
          ],
        ),
      ),
    );
  }
}
