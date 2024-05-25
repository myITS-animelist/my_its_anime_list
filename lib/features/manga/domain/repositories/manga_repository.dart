import 'package:dartz/dartz.dart';
import 'package:my_its_anime_list/features/manga/domain/entities/manga.dart';
import 'package:my_its_anime_list/core/error/failure.dart';

abstract class MangaRepository {
  Future<Either<Failure, List<MangaEntity>>> getMangaList();
  Future<Either<Failure, MangaEntity>> getMangaDetail(String id);
  Future<void> createManga(Map<String, dynamic> manga);
}