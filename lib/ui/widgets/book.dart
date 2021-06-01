import 'dart:math';

import 'package:audiobook/utils/size_config.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class Book extends StatelessWidget {
  final String coverUrl;
  Book({this.coverUrl});

  @override
  Widget build(BuildContext context) {
    int rand = 0 + Random().nextInt(100 - 0);

    return Hero(
      tag: coverUrl + rand.toString(),
      child: Container(
        margin: EdgeInsets.only(
          top: 10,
          left: 5,
        ),
        height: MediaQuery.of(context).size.height * 0.27,
        width: MediaQuery.of(context).size.width * 0.4,
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: CachedNetworkImageProvider(coverUrl),
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
              child: Row(
                children: [
                  Icon(
                    Icons.star_half_rounded,
                    color: Colors.white,
                    size: 30,
                  ),
                  Text(
                    "4.5",
                    style: Theme.of(context).textTheme.headline5.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          height: 1.3,
                        ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
