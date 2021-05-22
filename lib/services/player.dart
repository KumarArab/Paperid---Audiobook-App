import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';

class Player with ChangeNotifier {
  AudioPlayer _player = AudioPlayer();

  //   _player.onPlayerStateChanged.listen((AudioPlayerState s) => {
  //   print('Current player state: $s');
  //   setState(() => playerState = s);
  // });

  Future<String> play(String url) async {
    int result = await _player.play(url);
    if (result == 1) {
      notifyListeners();
      return "success";
    }
    return "error";
  }
}
