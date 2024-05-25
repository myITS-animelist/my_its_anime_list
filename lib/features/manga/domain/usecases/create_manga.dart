import 'package:my_its_anime_list/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:my_its_anime_list/features/manga/domain/entities/manga.dart';
import 'package:my_its_anime_list/features/manga/domain/repositories/manga_repository.dart';

class CreateManga {
  final MangaRepository repository;

  CreateManga(this.repository);

  Future<void> execute(Map<String, dynamic> manga) async {
    await repository.createManga(manga);
  }
}