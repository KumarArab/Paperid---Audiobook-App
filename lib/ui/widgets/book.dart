import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class Book extends StatelessWidget {
  final String coverUrl;
  Book({this.coverUrl});
  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: coverUrl,
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
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Colors.black.withOpacity(0.4),
                    blurRadius: 5,
                    offset: Offset(8, 8),
                    spreadRadius: 1,
                  )
                ],
              ),
              // child: CachedNetworkImageProvider(
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.27,
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
            ),
          ],
        ),
      ),
    );
  }
}
