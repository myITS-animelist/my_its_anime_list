import 'package:my_its_anime_list/features/manga/domain/entities/manga.dart';
import 'package:equatable/equatable.dart';

class MangaModel extends MangaEntity {
  final String id;
  final String title;
  final String author;
  final String sinopsis;
  final String cover;
  final String status;
  final String type;
  final List<Map<String, dynamic>> chapter;
  final String release;
  final List<String> genre;
  final int readCount;

  const MangaModel({
    required this.id,
    required this.title,
    required this.author,
    required this.sinopsis,
    required this.cover,
    required this.status,
    required this.type,
    required this.chapter,
    required this.release,
    required this.genre,
    required this.readCount,
  }) : super(
          id: id,
          title: title,
          author: author,
          sinopsis: sinopsis,
          cover: cover,
          status: status,
          type: type,
          chapter: chapter,
          release: release,
          genre: genre,
          readCount: readCount,
        );

  factory MangaModel.fromJson(Map<String, dynamic> json) {
    return MangaModel(
      id: json['id'] as String? ?? '',
      title: json['title'] as String? ?? '',
      author: json['author'] as String? ?? '',
      sinopsis: json['sinopsis'] as String? ?? '',
      cover: json['cover'] as String? ?? '',
      status: json['status'] as String? ?? '',
      type: json['type'] as String? ?? '',
      chapter: (json['chapter'] as List<dynamic>?)
              ?.map((e) => {
                    'chapter': e['chapter'],
                    'content': (e['content'] as List<dynamic>?)
                  })
              .toList() ??
          [],
      release: json['release'] as String? ?? '',
      genre:
          (json['genre'] as List<dynamic>?)?.map((e) => e as String).toList() ??
              [],
      readCount: json['readCount'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'author': author,
      'sinopsis': sinopsis,
      'cover': cover,
      'status': status,
      'type': type,
      'chapter': chapter,
      'release': release,
      'genre': genre,
      'readCount': readCount,
    };
  }
}
