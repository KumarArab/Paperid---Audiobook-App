import 'package:audiobook/models/bookModel.dart';
import 'package:audiobook/services/appData.dart';
import 'package:audiobook/ui/screens/tabs/filter.dart';
import 'package:audiobook/ui/screens/tabs/home%20tabs/genres.dart';
import 'package:audiobook/ui/widgets/back_button.dart';
import 'package:audiobook/ui/widgets/book.dart';
import 'package:audiobook/ui/widgets/book_grid.dart';
import 'package:audiobook/ui/widgets/miniplayer.dart';
import 'package:audiobook/ui/widgets/textbox.dart';
import 'package:audiobook/utils/appTheme.dart';
import 'package:audiobook/utils/dummy_data.dart';
import 'package:audiobook/utils/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class AuthorSingle extends StatefulWidget {
  static const routeName = '/author-single';
  final String author;
  AuthorSingle({this.author});

  @override
  _AuthorSingleState createState() => _AuthorSingleState();
}

class _AuthorSingleState extends State<AuthorSingle> {
  List<bool> genreChipSelection = [
    true,
    false,
    false,
    false,
    false,
    false,
  ];
  List<String> genreChipTitles = [
    "All Genres",
    "Fantasy",
    "Mystery",
    "Action & Adventure",
    "Romance",
    "Sci-Fi"
  ];

  @override
  void initState() {
    context.read<AppData>().fetchBooks(Section.Author, widget.author);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var books = context.watch<AppData>().authorBooks;
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: MiniPlayer(),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.only(left: 13),
          icon: Icon(
            Icons.arrow_back_rounded,
            size: 40,
            color: Colors.black,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Text(
                    widget.author,
                    style: Theme.of(context).textTheme.headline4.copyWith(
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (ctx) => Filters(),
                      ),
                    ),
                    child: Container(
                      height: 60,
                      width: 60,
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 2,
                          color: Colors.black,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: SvgPicture.asset("assets/svgs/filter.svg",
                          color: Colors.black),
                    ),
                  ),
                ],
              ),
              Container(
                height: kToolbarHeight,
                margin: EdgeInsets.symmetric(vertical: 20),
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: genreChipTitles.length,
                    itemBuilder: (ctx, i) {
                      return genreChip(i);
                    }),
              ),
              BookGrid(
                books: books,
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget genreChip(
    int index,
  ) {
    return GestureDetector(
      onTap: () {
        setState(() {
          for (int i = 0; i < genreChipSelection.length; i++) {
            genreChipSelection[i] = false;
          }
          genreChipSelection[index] = true;
        });
      },
      child: Container(
        margin: EdgeInsets.only(right: 20),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: genreChipSelection[index]
              ? AppTheme().primaryColor
              : AppTheme().primaryColor.withOpacity(0.15),
          borderRadius: BorderRadius.circular(15),
        ),
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        child: Text(genreChipTitles[index],
            style: Theme.of(context).textTheme.headline6.copyWith(
                  color: genreChipSelection[index]
                      ? Colors.white
                      : AppTheme().primaryColor,
                )),
      ),
    );
  }
}
