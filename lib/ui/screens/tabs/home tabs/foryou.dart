import 'package:audiobook/models/bookModel.dart';
import 'package:audiobook/services/homedata.dart';
import 'package:audiobook/ui/screens/book%20Details/bookDetails.dart';
import 'package:audiobook/ui/screens/home.dart';
import 'package:audiobook/ui/screens/tabs/genre_single.dart';
import 'package:audiobook/ui/widgets/book.dart';
import 'package:audiobook/ui/widgets/book_section.dart';
import 'package:audiobook/utils/appTheme.dart';
import 'package:audiobook/utils/size_config.dart';
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
      ),
    );
  }
}
