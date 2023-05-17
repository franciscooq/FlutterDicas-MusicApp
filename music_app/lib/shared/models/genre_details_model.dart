import 'dart:convert';

import 'package:music_app/shared/models/genre_model.dart';
import 'package:music_app/shared/models/music_model.dart';

class GenreDetailsModel extends GenreModel {
  final List<MusicModel> musics;

  GenreDetailsModel({
    required super.title,
    super.img,
    required this.musics,
    required super.searchString,
  });

  factory GenreDetailsModel.fromMap(Map<String, dynamic> map) {
    return GenreDetailsModel(
      title: map['title'] ?? '',
      img: map['img'] ?? '',
      musics: List<MusicModel>.from(
          map['musics']?.map((x) => MusicModel.fromMap(x))).toList(),
      searchString: map['searchString'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'musics': musics.map((x) => x.toMap()).toList()});

    return result;
  }

  String toJson() => json.encode(toMap());

  factory GenreDetailsModel.fromJson(String source) =>
      GenreDetailsModel.fromMap(json.decode(source));
}
