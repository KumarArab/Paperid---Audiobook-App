import 'package:audiobook/models/bookModel.dart';
import 'package:audiobook/ui/screens/book.dart';
import 'package:audiobook/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:audiobook/services/homedata.dart';

class Home extends StatelessWidget {
  static const String routeName = "/home";
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: context.read<HomeData>().fetchBooks(category.All),
        builder: (ctx, snapshpot) {
          if (snapshpot.connectionState == ConnectionState.waiting) {
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else {
            return Scaffold(
                body: ListView.builder(
              itemBuilder: (ctx, i) {
                FBookModel book = context.watch<HomeData>().getbooks[i];
                return Column(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (ctx) => Book(
                                    book: book,
                                  ))),
                      child: Container(
                        height: SizeConfig.height * 0.4,
                        child: Image.network(
                          book.cover,
                        ),
                      ),
                    ),
                    Text(book.name),
                    Text(book.author),
                  ],
                );
              },
              itemCount: context.watch<HomeData>().getbooks.length,
            ));
          }
        });
  }
}
