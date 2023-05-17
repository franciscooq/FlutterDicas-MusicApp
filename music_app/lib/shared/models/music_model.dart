import 'dart:convert';

class MusicModel {
  final String? img;
  final String title;
  final String url;
  final int duration;

  MusicModel({
    this.img,
    required this.title,
    required this.url,
    required this.duration,
  });

  factory MusicModel.fromMap(Map<String, dynamic> map) {
    return MusicModel(
      img: map['img'],
      title: map['title'] ?? '',
      url: map['url'] ?? '',
      duration: map['duration']?.toInt() ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (img != null) {
      result.addAll({'img': img});
    }
    result.addAll({'title': title});
    result.addAll({'url': url});
    result.addAll({'duration': duration});

    return result;
  }

  String toJson() => json.encode(toMap());

  factory MusicModel.fromJson(String source) =>
      MusicModel.fromMap(json.decode(source));
}
