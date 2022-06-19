import 'dart:js';

import 'package:audio_service/audio_service.dart';
import 'package:audiobook/services/player.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:provider/provider.dart';

_backgroundTaskEntryPoint() {
  AudioServiceBackground.run(() => BackgroundPlayer());
}

class BackgroundPlayer extends BackgroundAudioTask {
  @override
  Future<void> onStart(Map<String, dynamic> params) {
    AudioServiceBackground.setState(
      controls: [MediaControl.pause, MediaControl.stop],
      playing: true,
      processingState: AudioProcessingState.loading,
    );
    return super.onStart(params);
  }
}
