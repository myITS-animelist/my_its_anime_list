import 'package:equatable/equatable.dart';

class MangaEntity extends Equatable {
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

  const MangaEntity({
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
  });

  @override
  List<Object?> get props => [
        id,
        title,
        author,
        sinopsis,
        cover,
        status,
        type,
        chapter,
        release,
        genre,
        readCount,
      ];
}
