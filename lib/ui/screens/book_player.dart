import 'dart:math';
import 'dart:ui';

import 'package:audiobook/models/bookModel.dart';
import 'package:audiobook/services/player.dart';
import 'package:audiobook/ui/widgets/book.dart';
import 'package:audiobook/utils/appTheme.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BookPlayer extends StatelessWidget {
  // List<int> Heights = [];
  // final FBookModel book;
  // final index;

  // BookPlayer({this.index, this.book});

  @override
  Widget build(BuildContext context) {
    // for (int i = 0; i < MediaQuery.of(context).size.width / 9.3; i++) {
    //   Heights.add(Random().nextInt(50));
    // }
    Player playerWatch = context.watch<Player>();
    Player playerRead = context.read<Player>();
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: CachedNetworkImageProvider(playerRead.currentBook.cover),
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
                    coverUrl: playerRead.currentBook.cover,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20.0, horizontal: 30),
                    child: Text(
                      // "Conjure Women",
                      playerRead.currentBook.name,
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
                    playerRead.currentBook.author ?? "Unknown",
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
                            "Chapter ${playerWatch.currentAudio.name}",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Column(
                            children: [
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(playerWatch.position == null
                                      ? "00:00"
                                      : playerWatch.position
                                          .toString()
                                          .split('.')
                                          .first),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  CupertinoSlider(
                                    activeColor: AppTheme().primaryColor,
                                    //inactiveColor: AppTheme().secondaryColor,
                                    thumbColor: AppTheme().primaryColor,

                                    value: playerWatch.position == null
                                        ? 0
                                        : playerWatch.position.inMilliseconds
                                            .toDouble(),
                                    max: playerWatch.totalDuration == null
                                        ? 0
                                        : playerWatch
                                            .totalDuration.inMilliseconds
                                            .toDouble(),
                                    onChanged: (value) {
                                      playerWatch.seekAudio(Duration(
                                          milliseconds: value.toInt()));
                                    },
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Text(playerWatch.totalDuration == null
                                      ? "00:00"
                                      : playerWatch.totalDuration
                                          .toString()
                                          .split('.')
                                          .first),
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
                                onPressed: () => playerRead.playPrevious(),
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
                                      playerWatch.audioState == "Playing"
                                          ? playerRead.pauseAudio()
                                          : playerRead.resumeAudio(),
                                  icon: Icon(
                                    playerWatch.audioState == "Playing"
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
                                onPressed: () => playerRead.playNext(),
                              ),
                              IconButton(
                                icon: Icon(
                                  Icons.repeat,
                                  color: playerWatch.repeat
                                      ? AppTheme().primaryColor
                                      : Colors.grey,
                                  size: 32,
                                ),
                                highlightColor: Colors.red,
                                splashColor: Colors.red,
                                focusColor: Colors.red,
                                onPressed: () => playerWatch.repeat
                                    ? playerRead.repeatOn = false
                                    : playerRead.repeatOn = true,
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
