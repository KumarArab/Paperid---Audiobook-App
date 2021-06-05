import 'package:audiobook/services/player.dart';
import 'package:audiobook/ui/screens/book_player.dart';
import 'package:audiobook/utils/appTheme.dart';
import 'package:audiobook/utils/size_config.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MiniPlayer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Player playerWatch = context.watch<Player>();
    Player playerRead = context.read<Player>();
    return playerWatch.currentBook != null
        ? Container(
            height: 80,
            width: SizeConfig.width,
            child: Column(
              children: [
                Container(
                  height: 3,
                  width: SizeConfig.width,
                  color: Colors.grey,
                  child: FractionallySizedBox(
                    alignment: Alignment.centerLeft,
                    widthFactor: playerWatch.position == null
                        ? 0
                        : (playerWatch.position.inMilliseconds /
                            playerWatch.totalDuration.inMilliseconds),
                    child: Container(
                      color: AppTheme().primaryColor,
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                      child: ListTile(
                    onTap: () => Navigator.push(context,
                        MaterialPageRoute(builder: (ctx) => BookPlayer())),
                    leading: Container(
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: CachedNetworkImageProvider(
                                  playerWatch.currentBook.cover),
                              fit: BoxFit.cover)),
                    ),
                    title: Text(
                      playerWatch.currentBook.name,
                      overflow: TextOverflow.clip,
                    ),
                    subtitle: Text(
                      "Chapter ${playerWatch.currentAudio.name}",
                      overflow: TextOverflow.clip,
                    ),
                    trailing: IconButton(
                      onPressed: () => playerWatch.audioState == "Playing"
                          ? playerRead.pauseAudio()
                          : playerRead.resumeAudio(),
                      icon: Icon(
                        playerWatch.audioState == "Playing"
                            ? Icons.pause
                            : Icons.play_arrow_outlined,
                        color: AppTheme().primaryColor,
                      ),
                    ),
                  )),
                ),
              ],
            ),
          )
        : SizedBox();
  }
}
