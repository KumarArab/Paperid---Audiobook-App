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
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              Spacer(),
              Stack(
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
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 40.0, left: 10, right: 10),
                child: Text(
                  // "Conjure Women",
                  playerRead.currentBook.name,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headline4.copyWith(
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                      ),
                ),
              ),
              Text(
                //"By Afia Atakora",
                playerWatch.currentBook.author ?? "Unknown",
                style: Theme.of(context).textTheme.headline6.copyWith(
                      color: Colors.grey,
                      fontWeight: FontWeight.w500,
                    ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                child: Text(
                  //"By Afia Atakora",
                  playerRead.currentAudio.name ?? "Unknown",
                  style: Theme.of(context).textTheme.headline5.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                ),
              ),
              Spacer(
                flex: 2,
              ),
              Row(
                children: [
                  IconButton(
                      icon: Icon(
                        Icons.volume_up_outlined,
                        size: 30,
                      ),
                      onPressed: () {}),
                  Spacer(),
                  IconButton(
                    icon: Icon(
                      Icons.repeat,
                      color: playerWatch.repeat
                          ? AppTheme().primaryColor
                          : Colors.black,
                      size: 30,
                    ),
                    onPressed: () => playerWatch.repeat
                        ? playerRead.repeatOn = false
                        : playerRead.repeatOn = true,
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Row(
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
              SizedBox(
                height: 30,
              ),
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
              Spacer(
                flex: 5,
              )
            ],
          ),
        )
        // Container(
        //   height: MediaQuery.of(context).size.height,
        //   width: MediaQuery.of(context).size.width,
        //   decoration: BoxDecoration(
        //     image: DecorationImage(
        //       image: CachedNetworkImageProvider(playerRead.currentBook.cover),
        //       fit: BoxFit.cover,
        //     ),
        //   ),
        //   child: BackdropFilter(
        //     filter: ImageFilter.blur(
        //       sigmaX: 20,
        //       sigmaY: 20,
        //     ),
        //     child: Container(
        //       alignment: Alignment.center,
        //       color: Colors.black.withOpacity(0.1),
        //       child: SafeArea(
        //         child: Column(
        //           children: [
        //             Padding(
        //               padding: EdgeInsets.symmetric(
        //                 vertical: 20,
        //                 horizontal: 20,
        //               ),
        //               child: Row(
        //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //                 children: [
        //                   IconButton(
        //                     icon: Icon(
        //                       Icons.arrow_back,
        //                       color: Colors.white,
        //                       size: 35,
        //                     ),
        //                     onPressed: () => Navigator.pop(context),
        //                   ),
        //                   IconButton(
        //                     icon: Icon(
        //                       Icons.favorite_border,
        //                       color: Colors.white,
        //                       size: 35,
        //                     ),
        //                     onPressed: () {},
        //                   )
        //                 ],
        //               ),
        //             ),
        // Book(
        //   coverUrl: playerRead.currentBook.cover,
        // ),
        // Padding(
        //   padding: const EdgeInsets.symmetric(
        //       vertical: 20.0, horizontal: 30),
        //   child: Text(
        //     // "Conjure Women",
        //     playerRead.currentBook.name,
        //     textAlign: TextAlign.center,
        //     style: TextStyle(
        //       fontSize: 30,
        //       color: Colors.white,
        //       fontWeight: FontWeight.w700,
        //     ),
        //   ),
        // ),
        // SizedBox(
        //   height: 5,
        // ),
        // Text(
        //   //"By Afia Atakora",
        //   playerRead.currentBook.author ?? "Unknown",
        //   style: TextStyle(
        //     fontSize: 20,
        //     color: Colors.white,
        //     fontWeight: FontWeight.w500,
        //   ),
        // ),
        // SizedBox(
        //   height: 8,
        // ),
        //             Expanded(
        //               child: Container(
        //                 width: double.infinity,
        //                 decoration: BoxDecoration(
        //                   color: Colors.white,
        //                   borderRadius: BorderRadius.only(
        //                     topLeft: Radius.circular(50),
        //                     topRight: Radius.circular(50),
        //                   ),
        //                 ),
        //                 padding: EdgeInsets.only(
        //                   left: 30,
        //                   right: 30,
        //                 ),
        //                 child: Column(
        //                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //                   children: [
        //                     Text(
        //                       playerWatch.currentAudio.name,
        //                       textAlign: TextAlign.center,
        //                       style: TextStyle(
        //                         fontSize: 32,
        //                         fontWeight: FontWeight.w700,
        //                       ),
        //                     ),
        //                     Column(
        //                       children: [
        //                         SizedBox(
        //                           height: 20,
        //                         ),
        //                         Row(
        //                           mainAxisAlignment: MainAxisAlignment.center,
        //                           children: [
        // Text(playerWatch.position == null
        //     ? "00:00"
        //     : playerWatch.position
        //         .toString()
        //         .split('.')
        //         .first),
        //                             SizedBox(
        //                               width: 20,
        //                             ),
        // Slider(
        //   activeColor: AppTheme().primaryColor,
        //   inactiveColor: AppTheme().secondaryColor,
        //   value: playerWatch.position == null
        //       ? 0
        //       : playerWatch.position.inMilliseconds
        //           .toDouble(),
        //   max: playerWatch.totalDuration == null
        //       ? 0
        //       : playerWatch
        //           .totalDuration.inMilliseconds
        //           .toDouble(),
        //   onChanged: (value) {
        //     playerWatch.seekAudio(Duration(
        //         milliseconds: value.toInt()));
        //   },
        // ),
        //                             SizedBox(
        //                               width: 20,
        //                             ),
        // Text(playerWatch.totalDuration == null
        //     ? "00:00"
        //     : playerWatch.totalDuration
        //         .toString()
        //         .split('.')
        //         .first),
        //                           ],
        //                         ),
        //                       ],
        //                     ),
        //     Row(
        //       mainAxisAlignment: MainAxisAlignment.spaceAround,
        //       children: [
        //         IconButton(
        //           icon: Icon(
        //             Icons.menu,
        //             color: Colors.grey,
        //             size: 32,
        //           ),
        //           onPressed: () {},
        //         ),
        //         IconButton(
        //           icon: Icon(
        //             Icons.skip_previous,
        //             color: Colors.grey,
        //             size: 38,
        //           ),
        //           onPressed: () => playerRead.playPrevious(),
        //         ),
        //         Container(
        //           height: 50,
        //           width: 50,
        //           decoration: BoxDecoration(
        //             shape: BoxShape.circle,
        //             color: AppTheme().primaryColor,
        //           ),
        //           alignment: Alignment.center,
        //           child: IconButton(
        //             onPressed: () =>
        //                 playerWatch.audioState == "Playing"
        //                     ? playerRead.pauseAudio()
        //                     : playerRead.resumeAudio(),
        //             icon: Icon(
        //               playerWatch.audioState == "Playing"
        //                   ? Icons.pause
        //                   : Icons.play_arrow_outlined,
        //               color: Colors.white,
        //             ),
        //           ),
        //         ),
        //         IconButton(
        //           icon: Icon(
        //             Icons.skip_next,
        //             color: Colors.grey,
        //             size: 38,
        //           ),
        //           onPressed: () => playerRead.playNext(),
        //         ),
        //         IconButton(
        //           icon: Icon(
        //             Icons.repeat,
        //             color: playerWatch.repeat
        //                 ? AppTheme().primaryColor
        //                 : Colors.grey,
        //             size: 32,
        //           ),
        //           highlightColor: Colors.red,
        //           splashColor: Colors.red,
        //           focusColor: Colors.red,
        //           onPressed: () => playerWatch.repeat
        //               ? playerRead.repeatOn = false
        //               : playerRead.repeatOn = true,
        //         ),
        //       ],
        //     ),
        //   ],
        // ),
        //               ),
        //             )
        //           ],
        //         ),
        //       ),
        //     ),
        //   ),
        // ),
        );
  }
}
