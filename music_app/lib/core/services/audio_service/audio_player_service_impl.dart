import 'dart:developer';

import 'package:audioplayers/audioplayers.dart';
import 'package:get/get.dart';

import 'audio_player_service.dart';

import '../../errors/exceptions.dart';

class AudioPlayerServiceImpl extends GetxService implements AudioPlayerService {
  final AudioPlayer audioPlayer;

  AudioPlayerServiceImpl(
    this.audioPlayer,
  );

  @override
  Future<int> get getCurrentPosition async {
    try {
      final position = await audioPlayer.getCurrentPosition();

      return position?.inSeconds ?? 0;
    } catch (error, stacktrace) {
      var message = "Erro ao pegar posição da musica";
      log(message, error: error, stackTrace: stacktrace);
      throw AudioPlayerException(message: message);
    }
  }

  @override
  Stream<Duration> getPositionStream() {
    return audioPlayer.onPositionChanged;
  }

  @override
  Stream<void> onAudioComplete() {
    return audioPlayer.onPlayerComplete;
  }

  @override
  Future<void> pauseMusic() {
    return callAudioPlayertServiceTryAndCatchFunction(
      () => audioPlayer.pause(),
      "Erro ao pausar musica",
    );
  }

  @override
  Future<void> playMusic(String audioUrl) {
    return callAudioPlayertServiceTryAndCatchFunction(
      () => audioPlayer.play(AssetSource(audioUrl)),
      "Erro ao carregar musica",
    );
  }

  @override
  Future<void> resumeMusic() {
    return callAudioPlayertServiceTryAndCatchFunction(
      () => audioPlayer.resume(),
      "Erro ao continuar musica",
    );
  }

  @override
  Future<void> seek(int seconds) {
    return callAudioPlayertServiceTryAndCatchFunction(
      () {
        final seekTo = Duration(seconds: seconds);
        return audioPlayer.seek(seekTo);
      },
      "Erro ao reposicionar musica",
    );
  }

  @override
  Future<void> stopMusic() {
    return callAudioPlayertServiceTryAndCatchFunction(
      () => audioPlayer.stop(),
      "Erro ao parar musica",
    );
  }

  Future<void> callAudioPlayertServiceTryAndCatchFunction(
      Future<void> Function() tryFunction,
      String audioPlayerExceptionMessage) async {
    try {
      await tryFunction;
    } catch (error, stacktrace) {
      final message = audioPlayerExceptionMessage;
      log(message, error: error, stackTrace: stacktrace);
      throw AudioPlayerException(message: message);
    }
  }

  @override
  void onClose() {
    //sintaxe cascata
    audioPlayer
      ..stop()
      ..dispose();

    super.onClose();
  }
}
