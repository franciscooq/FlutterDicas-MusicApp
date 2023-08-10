import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_app/core/errors/exceptions.dart';
import 'package:music_app/core/mixins/snack_bar_mixin.dart';
import 'package:music_app/core/services/audio_service/audio_player_service.dart';
import 'package:music_app/shared/models/music_model.dart';

class MusicPlayerController with SnackBarMixin {
  final AudioPlayerService _audioPlayer;

  MusicPlayerController(AudioPlayerService audioPlayer)
      : _audioPlayer = audioPlayer {
    // ouve quando a musica acabar, para então pular para a proxima musica
    _audioCompleteStreamSubscription =
        _audioPlayer.onAudioComplete().listen((_) {
      skipTrack();
    });
  }

  StreamSubscription? _audioCompleteStreamSubscription;

  final RxBool isPlaying = false.obs;
  final RxInt currentMusicDuration = 0.obs;
  final RxnInt currentMusicIndexPlaying = RxnInt();
  int? get getCurrentMusicIndexPlaying => currentMusicIndexPlaying.value;

  final RxList<MusicModel> _playlistPlaying = <MusicModel>[].obs;
  final List<MusicModel> selectedPlaylist = [];

  List<MusicModel> get getPlaylistPlaying => _playlistPlaying;
  Stream<Duration> get getCurrentPositionStream =>
      _audioPlayer.getPositionStream();

  Future<void> seek(int seekToDurationInSeconds) =>
      _audioPlayer.seek(seekToDurationInSeconds);

  void loadPlaylist(
      List<MusicModel> newPlaylist, List<MusicModel> playlistToChange) {
    playlistToChange
      ..clear()
      ..addAll(newPlaylist);
  }

  Future<void> onCallMusicPlayerTryAndCatchFunction(
      Future<void> Function() tryFunction) async {
    try {
      await tryFunction();
    } on AudioPlayerException catch (error) {
      showErrorSnackBar(error.message);
    }
  }

  Future<void> playMusic(String url) async {
    return onCallMusicPlayerTryAndCatchFunction(() async {
      isPlaying.value = true;
      await _audioPlayer.playMusic(url);
    });
  }

  Future<void> stopMusic() async {
    return onCallMusicPlayerTryAndCatchFunction(() async {
      isPlaying.value = false;
      await _audioPlayer.stopMusic();
    });
  }

  Future<void> loadMusic() async {
    return onCallMusicPlayerTryAndCatchFunction(() async {
      //carrega a lista (carregar sempre para caso o usuario tenha mudado o genero musical)
      loadPlaylist(selectedPlaylist, _playlistPlaying);

      //parar a musica que estiver tocando
      await stopMusic();

      //da o play na musica
      await playMusic(_playlistPlaying[getCurrentMusicIndexPlaying ?? 0].url);
    });
  }

  Future<void> pauseMusic() async {
    return onCallMusicPlayerTryAndCatchFunction(() async {
      isPlaying.value = false;
      await _audioPlayer.pauseMusic();
    });
  }

  //proxima musica
  Future<void> skipTrack() async {
    if (getCurrentMusicIndexPlaying != null) {
      if (getCurrentMusicIndexPlaying! < _playlistPlaying.length - 1) {
        currentMusicIndexPlaying.value = currentMusicIndexPlaying.value! + 1;
      } else {
        //voltar para a primeira musica se estiver na ultima
        currentMusicIndexPlaying.value = 0;
      }

      await loadMusic();
    }
  }

  MusicModel? get getCurrentPlayingMusic {
    if (getCurrentMusicIndexPlaying != null) {
      return _playlistPlaying[getCurrentMusicIndexPlaying!];
    }

    return null;
  }

  //voltar musica
  Future<void> backMusic() async {
    if (getCurrentMusicIndexPlaying != null &&
        getCurrentMusicIndexPlaying! > 0) {
      currentMusicIndexPlaying.value = currentMusicIndexPlaying.value! - 1;
    } else {
      //voltar para a ultima musica se estiver na primeira
      currentMusicIndexPlaying.value = _playlistPlaying.length - 1;
    }

    await loadMusic();
  }

  void dispose() {
    _audioCompleteStreamSubscription?.cancel();
  }

  //quando abrir o player se estiver com a musica pausada, devemos mostrar onde ela pausou
  Future<void> loadCurrentMusicDuration() async {
    if (!isPlaying.value) {
      currentMusicDuration.value = await _audioPlayer.getCurrentPosition;
    }
  }

  void playSelectedMusic(BuildContext context, int musicIndex) {
    //atualiza qual o index da musica que será ouvida na playlist
    currentMusicIndexPlaying.value = musicIndex;

    //carregar e toca a musica
    loadMusic();

    showMusicPlayer(context);
  }

  Future<void> showMusicPlayer(BuildContext context) async {}
}
