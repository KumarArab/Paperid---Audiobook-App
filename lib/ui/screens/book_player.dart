import 'dart:math';
import 'dart:ui';

import 'package:audiobook/models/bookModel.dart';
import 'package:audiobook/services/player.dart';
import 'package:audiobook/ui/widgets/book.dart';
import 'package:audiobook/utils/appTheme.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BookPlayer extends StatelessWidget {
  // List<int> Heights = [];
  final FBookModel book;
  final index;

  BookPlayer({this.index, this.book});

  @override
  Widget build(BuildContext context) {
    // for (int i = 0; i < MediaQuery.of(context).size.width / 9.3; i++) {
    //   Heights.add(Random().nextInt(50));
    // }
    Player player = context.watch<Player>();
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: CachedNetworkImageProvider(book.cover),
            fit: BoxFit.cover,
          ),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 20,
            sigmaY: 20,
          ),
          child: Container(
            alignment: Alignment.center,
            color: Colors.black.withOpacity(0.1),
            child: SafeArea(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 20,
                      horizontal: 20,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                            size: 35,
                          ),
                          onPressed: () => Navigator.pop(context),
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.favorite_border,
                            color: Colors.white,
                            size: 35,
                          ),
                          onPressed: () {},
                        )
                      ],
                    ),
                  ),
                  Book(
                    coverUrl: book.cover,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20.0, horizontal: 30),
                    child: Text(
                      // "Conjure Women",
                      book.name,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 30,
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    //"By Afia Atakora",
                    book.author ?? "Unknown",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(50),
                          topRight: Radius.circular(50),
                        ),
                      ),
                      padding: EdgeInsets.only(
                        left: 30,
                        right: 30,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            "Chapter ${book.audios[index].name}",
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Column(
                            children: [
                              Slider(value: 0, onChanged: null),
                              // Container(
                              //   height: 50,
                              //   width: MediaQuery.of(context).size.width,
                              //   child: ListView.builder(
                              //     itemBuilder: (ctx, i) => Bars(
                              //       height: Heights[i].toDouble(),
                              //       color: i < Heights.length / 2
                              //           ? Color(0xffc44536)
                              //           : Colors.redAccent.withOpacity(0.5),
                              //     ),
                              //     itemCount: Heights.length,
                              //     scrollDirection: Axis.horizontal,
                              //   ),
                              // ),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("01:33"),
                                  Text("08:47"),
                                ],
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              IconButton(
                                icon: Icon(
                                  Icons.menu,
                                  color: Colors.grey,
                                  size: 32,
                                ),
                                onPressed: () {},
                              ),
                              IconButton(
                                icon: Icon(
                                  Icons.skip_previous,
                                  color: Colors.grey,
                                  size: 38,
                                ),
                                onPressed: () {},
                              ),
                              Container(
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppTheme().primaryColor,
                                ),
                                alignment: Alignment.center,
                                child: IconButton(
                                  onPressed: () =>
                                      player.audioState == "Playing"
                                          ? player.pauseAudio()
                                          : player.resumeAudio(),
                                  icon: Icon(
                                    player.audioState == "Playing"
                                        ? Icons.pause
                                        : Icons.play_arrow_outlined,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              IconButton(
                                icon: Icon(
                                  Icons.skip_next,
                                  color: Colors.grey,
                                  size: 38,
                                ),
                                onPressed: () {},
                              ),
                              IconButton(
                                icon: Icon(
                                  Icons.more_horiz,
                                  color: Colors.grey,
                                  size: 32,
                                ),
                                onPressed: () {},
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class Bars extends StatelessWidget {
  final double height;
  final Color color;

  Bars({this.height, this.color});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 4,
      color: Color(0xfffff8ee),
      margin: EdgeInsets.symmetric(horizontal: 2),
      child: Center(
        child: Container(
          height: height,
          color: color,
          width: 4,
        ),
      ),
    );
  }
}
