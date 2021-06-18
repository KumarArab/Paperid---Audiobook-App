import 'package:audiobook/models/bookModel.dart';
import 'package:audiobook/ui/widgets/book_grid.dart';
import 'package:audiobook/ui/widgets/textbox.dart';
import 'package:audiobook/utils/size_config.dart';
import 'package:flutter/material.dart';

class ViewAll extends StatelessWidget {
  final String title;
  final List<FBookModel> books;

  ViewAll({@required this.books, @required this.title});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.headline4.copyWith(
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                      ),
                ),
                Spacer(),
              ],
            ),
            Divider(),
            books.length == 0
                ? Expanded(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
                : BookGrid(books: books)
          ],
        ),
      ),
    );
  }
}
