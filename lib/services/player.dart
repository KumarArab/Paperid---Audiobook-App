import 'package:audiobook/models/chapterModel.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';

class Player with ChangeNotifier {
  AudioPlayer audioPlayer = AudioPlayer();
  Duration totalDuration;
  Duration position;
  String audioState;
  List<FChapterModel> playlist;

  Player() {
    initAudio();
  }

  initAudio() {
    audioPlayer.onDurationChanged.listen((updatedDuration) {
      totalDuration = updatedDuration;
      notifyListeners();
    });

    audioPlayer.onAudioPositionChanged.listen((updatedPosition) {
      position = updatedPosition;
      notifyListeners();
    });

    audioPlayer.onPlayerStateChanged.listen((playerState) {
      if (playerState == PlayerState.STOPPED) audioState = "Stopped";
      if (playerState == PlayerState.PLAYING) audioState = "Playing";
      if (playerState == PlayerState.PAUSED) audioState = "Paused";
      if (playerState == PlayerState.COMPLETED) audioState = "Completed";
      notifyListeners();
    });
  }

  playAudio(List<FChapterModel> chapters, int index) {
    playlist = chapters;
    print(chapters[index].url);
    audioPlayer.play(chapters[index].url);
  }

  pauseAudio() {
    audioPlayer.pause();
  }

  resumeAudio() {
    audioPlayer.resume();
  }

  stopAudio() {
    audioPlayer.stop();
  }

  seekAudio(Duration durationToSeek) {
    audioPlayer.seek(durationToSeek);
  }
}
