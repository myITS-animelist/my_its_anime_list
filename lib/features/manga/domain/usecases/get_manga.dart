
import 'package:dartz/dartz.dart';
import 'package:my_its_anime_list/core/error/failure.dart';
import 'package:my_its_anime_list/features/manga/domain/entities/manga.dart';
import 'package:my_its_anime_list/features/manga/domain/repositories/manga_repository.dart';

class GetMangaDetail {
  final MangaRepository _repository;

  GetMangaDetail(this._repository);

  // Future<Either<Failure, MangaEntity>> execute(String id) async {
  //   return await _repository.getMangaDetail(id);
  // }

  Stream<Either<Failure, MangaEntity>> execute(String id) {
    return _repository.getMangaDetail(id);
  }
}