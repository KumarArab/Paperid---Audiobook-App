import 'dart:math';
import 'dart:ui';

import 'package:audiobook/models/bookModel.dart';
import 'package:audiobook/services/player.dart';
import 'package:audiobook/ui/widgets/book.dart';
import 'package:audiobook/utils/appTheme.dart';
import 'package:audiobook/utils/size_config.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class BookPlayer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Player playerWatch = context.watch<Player>();
    Player playerRead = context.read<Player>();
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black),
          actions: [
            IconButton(icon: Icon(Icons.more_vert_rounded), onPressed: () {})
          ],
        ),
        body: Container(
          width: SizeConfig.width,
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: Color(
                        int.parse("0xff" + playerRead.currentBook.color),
                      ).withOpacity(0.4),
                      blurRadius: 34,
                      offset: Offset(24, 24),
                      spreadRadius: 10,
                    ),
                  ],
                ),
                child: Book(
                  book: playerRead.currentBook,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: SizeConfig.width * 0.08, left: 10, right: 10),
                child: Text(
                  // "Conjure Women",
                  playerRead.currentBook.name,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headline6.copyWith(
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                      ),
                ),
              ),
              Text(
                //"By Afia Atakora",
                playerWatch.currentBook.author ?? "Unknown",
                style: Theme.of(context).textTheme.bodyText1.copyWith(
                      color: Colors.grey,
                      fontWeight: FontWeight.w500,
                    ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: 10, vertical: SizeConfig.width * 0.02),
                child: Text(
                  //"By Afia Atakora",
                  playerRead.currentAudio.name ?? "Unknown",
                  style: Theme.of(context).textTheme.headline5.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                ),
              ),
              Spacer(),
              // Row(
              //   children: [
              //     IconButton(
              //         icon: Icon(
              //           Icons.volume_up_outlined,
              //           size: 30,
              //         ),
              //         onPressed: () {}),
              //     IconButton(
              //       icon: Icon(
              //         Icons.repeat,
              //         color: playerWatch.repeat
              //             ? AppTheme().primaryColor
              //             : Colors.black,
              //         size: 30,
              //       ),
              //       onPressed: () => playerWatch.repeat
              //           ? playerRead.repeatOn = false
              //           : playerRead.repeatOn = true,
              //     ),
              //   ],
              // ),
              SizedBox(
                height: SizeConfig.width * 0.05,
              ),
              Container(
                margin:
                    EdgeInsets.symmetric(horizontal: SizeConfig.width * 0.03),
                child: Row(
                  children: [
                    SizedBox(width: 10),
                    Text(
                        playerWatch.position == null
                            ? "00:00"
                            : playerWatch.position.toString().split('.').first,
                        style: Theme.of(context).textTheme.headline6),
                    Spacer(),
                    Text(
                        playerWatch.totalDuration == null
                            ? "00:00"
                            : playerWatch.totalDuration
                                .toString()
                                .split('.')
                                .first,
                        style: Theme.of(context).textTheme.headline6),
                    SizedBox(width: 10),
                  ],
                ),
              ),
              Slider(
                activeColor: AppTheme().primaryColor,
                inactiveColor: AppTheme().silverColor,
                value: playerWatch.position == null
                    ? 0
                    : playerWatch.position.inMilliseconds.toDouble(),
                max: playerWatch.totalDuration == null
                    ? 0
                    : playerWatch.totalDuration.inMilliseconds.toDouble(),
                onChanged: (value) {
                  playerWatch.seekAudio(Duration(milliseconds: value.toInt()));
                },
              ),
              Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(),
                  Container(
                    height: 48,
                    width: 48,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppTheme().primaryColor,
                    ),
                    alignment: Alignment.center,
                    child: IconButton(
                      onPressed: () => playerRead.playPrevious(),
                      icon: Icon(
                        Icons.skip_previous_rounded,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Container(
                    height: 65,
                    width: 65,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppTheme().primaryColor,
                    ),
                    alignment: Alignment.center,
                    child: GestureDetector(
                      onTap: () => playerWatch.position.inSeconds >= 10
                          ? playerWatch.seekAudio(Duration(
                              milliseconds:
                                  playerWatch.position.inMilliseconds - 10000))
                          : {},
                      child: Image.asset(
                        "assets/images/rewind-10.png",
                        height: 30,
                        width: 30,
                      ),
                    ),
                  ),
                  Container(
                    height: 88,
                    width: 88,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppTheme().primaryColor,
                    ),
                    alignment: Alignment.center,
                    child: IconButton(
                      onPressed: () => playerWatch.audioState == "Playing"
                          ? playerRead.pauseAudio()
                          : playerRead.resumeAudio(),
                      icon: Icon(
                        playerWatch.audioState == "Playing"
                            ? Icons.pause
                            : Icons.play_arrow_rounded,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Container(
                    height: 65,
                    width: 65,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppTheme().primaryColor,
                    ),
                    alignment: Alignment.center,
                    child: GestureDetector(
                      onTap: () => playerWatch.position.inSeconds <=
                              playerWatch.totalDuration.inSeconds - 10
                          ? playerWatch.seekAudio(Duration(
                              milliseconds:
                                  playerWatch.position.inMilliseconds + 10000))
                          : {},
                      child: Image.asset(
                        "assets/images/forward-10.png",
                        height: 30,
                        width: 30,
                      ),
                    ),
                  ),
                  Container(
                    height: 48,
                    width: 48,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppTheme().primaryColor,
                    ),
                    alignment: Alignment.center,
                    child: IconButton(
                      onPressed: () => playerRead.playNext(),
                      icon: Icon(
                        Icons.skip_next_rounded,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(),
                ],
              ),
              SizedBox(
                height: 40,
              )
            ],
          ),
        ));
  }
}
