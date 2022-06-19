import 'package:audio_service/audio_service.dart';
import 'package:audiobook/models/bookModel.dart';
import 'package:audiobook/models/chapterModel.dart';
import 'package:audiobook/services/database.dart';
import 'package:audiobook/utils/snackbar.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Player with ChangeNotifier {
  AudioPlayer audioPlayer = AudioPlayer();
  Duration totalDuration;
  Duration position;
  String audioState;
  List<FChapterModel> playlist;
  FBookModel currentBook;
  FChapterModel currentAudio;
  int currentAudioIndex;
  bool _repeat = false;

  Player() {
    initAudio();
  }

  initAudio() {
    audioPlayer.onDurationChanged.listen((updatedDuration) {
      totalDuration = updatedDuration;
      notifyListeners();
    });

    audioPlayer.onPositionChanged.listen((updatedPosition) {
      position = updatedPosition;
      notifyListeners();
    });

    audioPlayer.onPlayerStateChanged.listen((playerState) {
      if (playerState == PlayerState.stopped) audioState = "Stopped";
      if (playerState == PlayerState.playing) audioState = "Playing";
      if (playerState == PlayerState.paused) audioState = "Paused";
      if (playerState == PlayerState.completed) audioState = "Completed";
      notifyListeners();
    });

    audioPlayer.onPlayerComplete.listen((event) {
      if (_repeat) playNext();
    });
  }

  playAudio(FBookModel book, int index) {
    currentBook = book ?? currentBook;
    playlist = currentBook.audios;
    FDatabase().addToLocalCurrentlyListening(book.id);
    if (playlist[index].url != null) {
      currentAudioIndex = index;
    } else {
      SnackToast().showErrorToast("Error Playing the Audio, trying next one");
      currentAudioIndex = index + 1;
      while (playlist[currentAudioIndex].url == null &&
          currentAudioIndex < playlist.length) {
        currentAudioIndex++;
      }
    }
    currentAudio = playlist[currentAudioIndex];
    audioPlayer.play(UrlSource(playlist[currentAudioIndex].url));
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

  playNext() {
    if (currentAudioIndex == playlist.length - 1) {
      playAudio(null, 0);
    } else {
      playAudio(null, currentAudioIndex + 1);
    }
  }

  playPrevious() {
    if (currentAudioIndex != 0) {
      playAudio(null, currentAudioIndex - 1);
    }
  }

  get repeat => _repeat;
  set repeatOn(bool value) {
    _repeat = value;
    notifyListeners();
  }
}
