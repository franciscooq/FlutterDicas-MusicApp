import 'package:flutter/material.dart';
import 'package:music_app/core/app/music_app_colors.dart';

class MusicAppTextStyle {
  MusicAppTextStyle._();

  static TextStyle get getNormalStyle =>
      TextStyle(fontSize: 16, color: MusicAppColors.secondaryColor);

  static TextStyle get getNormalBoldStyle =>
      getNormalStyle.copyWith(fontWeight: FontWeight.bold);

  static TextStyle get getTitleStyle =>
      getNormalBoldStyle.copyWith(fontSize: 24);

  static TextStyle get getSmallStyle => getSmallStyle.copyWith(fontSize: 12);
}
