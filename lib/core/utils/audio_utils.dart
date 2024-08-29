import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:medina_stores/config/resources/color_palettes/color_palette.dart';
import 'package:medina_stores/core/extensions/context.dart';
import 'package:medina_stores/core/extensions/int.dart';
import 'package:rxdart/rxdart.dart';

import '../navigation/navigator.dart';

mixin AudioUtils {
  final context = AppNavigator.rootContext!;
  Stream<(Duration, Duration?)> durationStream(AudioPlayer player) => Rx.combineLatest2<Duration, Duration?, (Duration, Duration?)>(
        player.positionStream,
        player.durationStream,
        (position, duration) => (position, duration),
      );

  void initializeSource(String media, AudioPlayer player) async {
    final audioSource = LockCachingAudioSource(Uri.parse(media));
    await player.setAudioSource(audioSource);
  }

  Color getInActiveTrackColor(bool isSender) {
    if (isSender) return ColorPalette.whiteColor.withOpacity(0.48);
    return context.colorPalette.primary.withOpacity(0.24);
  }

  Color getActiveTrackColor(bool isSender) {
    if (isSender) return ColorPalette.whiteColor;
    return context.colorPalette.primary;
  }

  String getAudioDuration(Duration duration) {
    final int minutes = duration.inMinutes;
    final int seconds = duration.inSeconds.remainder(60);

    return '${minutes.padNumber}:${seconds.padNumber}';
  }
}
