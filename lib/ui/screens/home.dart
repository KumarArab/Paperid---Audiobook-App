import 'dart:io';

import 'package:audiobook/models/bookModel.dart';
import 'package:audiobook/services/authentication_service.dart';
import 'package:audiobook/services/database.dart';
import 'package:audiobook/ui/screens/404.dart';
import 'package:audiobook/ui/screens/bookDetails.dart';
import 'package:audiobook/ui/widgets/appbar.dart';
import 'package:audiobook/ui/widgets/book.dart';
import 'package:audiobook/ui/widgets/miniplayer.dart';
import 'package:audiobook/utils/appTheme.dart';
import 'package:audiobook/utils/constants.dart';
import 'package:audiobook/utils/size_config.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:audiobook/services/homedata.dart';

class Home extends StatelessWidget {
  static const String routeName = "/home";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: MiniPlayer(),
      body: Container(
        decoration: BoxDecoration(color: AppTheme().primaryColor),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(
                left: 30,
                right: 30,
                top: 70,
                bottom: 20,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      icon: Icon(
                        Icons.menu,
                        color: Colors.white,
                        size: 35,
                      ),
                      onPressed: () {}),
                  IconButton(
                    icon: Icon(
                      Icons.settings,
                      color: Colors.white,
                      size: 35,
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, "/userProfile");
                    },
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.only(
                  top: 50,
                ),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50),
                  ),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.only(left: 30),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Hello,",
                              style: Theme.of(context).textTheme.headline4,
                            ),
                            Text(
                              context
                                  .read<AuthenticaitonService>()
                                  .currentUser
                                  .name,
                              style: TextStyle(
                                fontSize: 40,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                top: 15,
                                bottom: 30,
                              ),
                              width: 100,
                              height: 10,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  color: AppTheme().primaryColor),
                            ),
                          ],
                        ),
                      ),
                      BookSection(
                        heading: "Currently Reading",
                      ),
                      // BookSection(
                      //   heading: "Discover More",
                      // ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class BookSection extends StatelessWidget {
  final String heading;
  BookSection({this.heading});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 30.0),
            child: Text(
              heading,
              style: Theme.of(context).textTheme.headline5,
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(
              vertical: 10,
            ),
            height: MediaQuery.of(context).size.height * 0.4,
            child: FutureBuilder(
                future: context.read<HomeData>().fetchBooks(),
                builder: (ctx, snapshot) {
                  if (snapshot.connectionState != ConnectionState.waiting) {
                    return ListView.builder(
                      itemBuilder: (ctx, i) {
                        FBookModel book = context.watch<HomeData>().books[i];
                        return GestureDetector(
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (ctx) => BookDetails(
                                book: book,
                              ),
                            ),
                          ),
                          child: Row(
                            children: [
                              SizedBox(width: 30),
                              Column(
                                children: [
                                  Book(coverUrl: book.cover),
                                  SizedBox(height: 16),
                                  Text(
                                    book.name,
                                    style:
                                        Theme.of(context).textTheme.bodyText1,
                                  ),
                                  SizedBox(
                                    height: 2,
                                  ),
                                  Text(
                                    book.author ?? "Unknown",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                      itemCount: context.watch<HomeData>().books.length,
                      scrollDirection: Axis.horizontal,
                    );
                  } else {
                    return Center(
                      child: CircularProgressIndicator(
                        backgroundColor: ThemeData().primaryColor,
                        strokeWidth: 1,
                      ),
                    );
                  }
                }),
          )
        ],
      ),
    );
  }
}
