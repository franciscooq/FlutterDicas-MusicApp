import 'dart:convert';

class GenreModel {
  //imagem do genero
  final String? img;
  //titulo
  final String title;
  //nome do genero para consumirmos a api
  final String searchString;

  GenreModel({
    this.img,
    required this.title,
    required this.searchString,
  });

  factory GenreModel.fromMap(Map<String, dynamic> map) {
    return GenreModel(
      img: map['img'],
      title: map['title'] ?? '',
      searchString: map['searchString'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (img != null) {
      result.addAll({'img': img});
    }
    result.addAll({'title': title});
    result.addAll({'searchString': searchString});

    return result;
  }

  String toJson() => json.encode(toMap());

  factory GenreModel.fromJson(String source) =>
      GenreModel.fromMap(json.decode(source));
}
