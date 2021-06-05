import 'package:audiobook/models/bookModel.dart';
import 'package:audiobook/services/homedata.dart';
import 'package:audiobook/ui/screens/tabs/filter.dart';
import 'package:audiobook/ui/screens/tabs/home%20tabs/genres.dart';
import 'package:audiobook/ui/widgets/book.dart';
import 'package:audiobook/ui/widgets/textbox.dart';
import 'package:audiobook/utils/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

enum GenreSort { rateasc, ratedesc, dateasc, datedesc, durasc, durdesc }

class GenreSingle extends StatefulWidget {
  static const routeName = '/genre-single';
  final String genre;
  GenreSingle({this.genre});

  @override
  _GenreSingleState createState() => _GenreSingleState();
}

class _GenreSingleState extends State<GenreSingle> {
  TextEditingController _searchGenreSingleController;
  GenreSort _sortVal = GenreSort.ratedesc;

  @override
  void initState() {
    _searchGenreSingleController = TextEditingController();
    super.initState();
  }

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
                  widget.genre,
                  style: Theme.of(context).textTheme.headline4.copyWith(
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                      ),
                ),
                Spacer(),
                GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                        context: context,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20))),
                        builder: (ctx) {
                          return Wrap(
                            children: [
                              Container(
                                width: SizeConfig.width,
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 25.0),
                                      child: Row(
                                        children: [
                                          Text(
                                            "Sort Audiobooks by:",
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline5
                                                .copyWith(
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.w600),
                                          ),
                                          Spacer(),
                                          IconButton(
                                            icon: Icon(Icons.clear_rounded,
                                                color: Colors.black),
                                            onPressed: () =>
                                                Navigator.pop(context),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    radioTile(GenreSort.ratedesc,
                                        "Rate (Descending)"),
                                    radioTile(
                                        GenreSort.rateasc, "Rate (ascending)"),
                                    radioTile(GenreSort.datedesc,
                                        "Date (Descending)"),
                                    radioTile(
                                        GenreSort.dateasc, "Date (ascending)"),
                                    radioTile(GenreSort.durasc,
                                        "Duration (Descending)"),
                                    radioTile(GenreSort.durdesc,
                                        "Duration (ascending)"),
                                    SizedBox(height: 20),
                                  ],
                                ),
                              ),
                            ],
                          );
                        });
                  },
                  child: Container(
                    height: 60,
                    width: 60,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 2,
                        color: Colors.black,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: SvgPicture.asset("assets/svgs/sort.svg",
                        height: 20, color: Colors.black),
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
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
            TextBox(
              controller: _searchGenreSingleController,
              isObsecure: false,
              label: "Search books here",
            ),
            Expanded(
              child: Container(
                child: GridView.count(
                  // Create a grid with 2 columns. If you change the scrollDirection to
                  // horizontal, this produces 2 rows.
                  childAspectRatio: 1 / 1.35,
                  crossAxisCount: 2,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                  // Generate 100 widgets that display their index in the List.
                  children: List.generate(
                      context.watch<HomeData>().books.length, (index) {
                    FBookModel book = context.watch<HomeData>().books[index];
                    return Book(coverUrl: book.cover);
                  }),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget radioTile(GenreSort genreSort, String title) {
    return RadioListTile<GenreSort>(
        title: Text(
          title,
          style: Theme.of(context)
              .textTheme
              .headline6
              .copyWith(color: Colors.black),
        ),
        value: genreSort,
        groupValue: _sortVal,
        onChanged: (GenreSort value) {
          _sortVal = value;
          print(_sortVal);
          Navigator.pop(context);
        });
  }
}
