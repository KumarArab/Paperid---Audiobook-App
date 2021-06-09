import 'package:audiobook/models/bookModel.dart';
import 'package:audiobook/services/homedata.dart';
import 'package:audiobook/ui/screens/tabs/filter.dart';
import 'package:audiobook/ui/screens/tabs/home%20tabs/genres.dart';
import 'package:audiobook/ui/widgets/back_button.dart';
import 'package:audiobook/ui/widgets/book.dart';
import 'package:audiobook/ui/widgets/book_grid.dart';
import 'package:audiobook/ui/widgets/textbox.dart';
import 'package:audiobook/utils/appTheme.dart';
import 'package:audiobook/utils/dummy_data.dart';
import 'package:audiobook/utils/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class Shelf extends StatefulWidget {
  static const routeName = '/shelf';
  final String shelf;
  Shelf({this.shelf});

  @override
  _ShelfState createState() => _ShelfState();
}

class _ShelfState extends State<Shelf> {
  TextEditingController _shelfSearchController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
                    widget.shelf,
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
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 25.0),
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            "Are you sure to delete this Shelf?",
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
                                      SizedBox(
                                        height: 40,
                                      ),
                                      Container(
                                        height: 70,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            width: 3,
                                            color: Colors.red,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        alignment: Alignment.center,
                                        child: Text(
                                          "Yes, delete it",
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline6
                                              .copyWith(color: Colors.red),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 30,
                                      ),
                                      Container(
                                        height: 70,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            width: 3,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        alignment: Alignment.center,
                                        child: Text(
                                          "No, keep it",
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline6,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 50,
                                      ),
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
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 2,
                          color: Colors.black,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(
                        Icons.delete_rounded,
                      ),
                    ),
                  ),
                ],
              ),
              TextBox(
                controller: _shelfSearchController,
                isObsecure: false,
                label: "Search your book here",
              ),
              BookGrid()
            ],
          ),
        ),
      ),
    );
  }
}
