import 'dart:io';

import 'package:audiobook/models/bookModel.dart';
import 'package:audiobook/services/authentication_service.dart';
import 'package:audiobook/services/database.dart';
import 'package:audiobook/ui/screens/book.dart';
import 'package:audiobook/utils/appTheme.dart';
import 'package:audiobook/utils/size_config.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:audiobook/services/homedata.dart';

// class Home extends StatelessWidget {
//   static const String routeName = "/home";

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: StreamBuilder<QuerySnapshot>(
//       stream: FirebaseFirestore.instance.collection("Books").snapshots(),
//       builder: (ctx, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           // List<FBookModel> bookList = snapshot.data.docs;
//           return Center(
//             child: CircularProgressIndicator(),
//           );
//         }

//         return ListView.builder(
//           itemBuilder: (ctx, i) {
//             return Text(snapshot.data.docs[i].get("Name"));
//           },
//           itemCount: snapshot.data.docs.length,
//         );
//       },
//     ));
//   }
// }

class Home extends StatelessWidget {
  static const String routeName = "/home";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            // image: DecorationImage(
            //   image: AssetImage("assets/images/home.jpg"),
            //   fit: BoxFit.cover,
            // ),
            color: AppTheme().primaryColor),
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
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Book(),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.search,
                      color: Colors.white,
                      size: 35,
                    ),
                    onPressed: () {
                      print(context.read<HomeData>().books.length);
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
                      BookSection(
                        heading: "Discover More",
                      ),
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
    HomeData homeData = context.watch<HomeData>();
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
                              builder: (ctx) => Book(
                                book: book,
                              ),
                            ),
                          ),
                          child: Row(
                            children: [
                              SizedBox(width: 30),
                              Column(
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(
                                      top: 10,
                                      left: 5,
                                    ),
                                    height: MediaQuery.of(context).size.height *
                                        0.27,
                                    width:
                                        MediaQuery.of(context).size.width * 0.4,
                                    child: Stack(
                                      children: [
                                        Container(
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: NetworkImage(book.cover),
                                              fit: BoxFit.cover,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            boxShadow: <BoxShadow>[
                                              BoxShadow(
                                                color: Colors.black
                                                    .withOpacity(0.4),
                                                blurRadius: 5,
                                                offset: Offset(8, 8),
                                                spreadRadius: 1,
                                              )
                                            ],
                                          ),
                                          // child: ClipRRect(
                                          //   borderRadius:
                                          //       BorderRadius.circular(20),
                                          //   child: Image.network(
                                          //     bookList[i].cover,
                                          //     fit: BoxFit.cover,
                                          //   ),
                                          // ),
                                        ),
                                        Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.27,
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            gradient: new LinearGradient(
                                              colors: [
                                                Colors.black.withOpacity(0.4),
                                                Colors.transparent,
                                                Colors.black.withOpacity(0.4),
                                              ],
                                              begin: Alignment.centerLeft,
                                              end: Alignment.centerRight,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
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
