import 'package:flutter/material.dart';
import 'package:music_app/core/app/music_app.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  await dotenv.load(fileName: '.env');
  runApp(const MusicApp());
}
