import 'dart:math';

import 'package:audiobook/models/bookModel.dart';
import 'package:audiobook/ui/screens/book%20Details/bookDetails.dart';
import 'package:audiobook/utils/size_config.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class Book extends StatelessWidget {
  final bool showRating;
  final FBookModel book;
  Book({@required this.book, this.showRating = true});

  @override
  Widget build(BuildContext context) {
    int rand = 0 + Random().nextInt(100 - 0);

    return Hero(
      tag: book.cover + rand.toString(),
      child: GestureDetector(
        onTap: () => Navigator.of(
          context,
        ).push(
          MaterialPageRoute(
            builder: (ctx) => BookDetails(
              book: book,
            ),
          ),
        ),
        child: Container(
          margin: EdgeInsets.only(
            top: 10,
            left: 5,
          ),
          height: SizeConfig.height * 0.27,
          width: SizeConfig.width * 0.4,
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: CachedNetworkImageProvider(book.cover),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(20),
                  // boxShadow: <BoxShadow>[
                  //   BoxShadow(
                  //     color: Colors.black.withOpacity(0.2),
                  //     blurRadius: 10,
                  //     offset: Offset(8, 8),
                  //     spreadRadius: 5,
                  //   )
                  // ],
                ),
                // child: CachedNetworkImageProvider(
              ),
              Container(
                height: SizeConfig.height * 0.27,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
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
                padding: EdgeInsets.all(10),
                alignment: Alignment.bottomLeft,
                child: showRating
                    ? Row(
                        children: [
                          Icon(
                            Icons.star_half_rounded,
                            color: Colors.white,
                            size: 30,
                          ),
                          Text(
                            "4.5",
                            style:
                                Theme.of(context).textTheme.headline5.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      height: 1.3,
                                    ),
                          )
                        ],
                      )
                    : SizedBox(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
