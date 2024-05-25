
import 'package:my_its_anime_list/core/error/failure.dart';
import 'package:my_its_anime_list/features/manga/data/models/manga_model.dart';
import 'package:my_its_anime_list/features/manga/domain/entities/manga.dart';
import 'package:my_its_anime_list/features/manga/domain/repositories/manga_repository.dart';
import 'package:dartz/dartz.dart';

class GetMangaList {
  final MangaRepository _repository;

  GetMangaList(this._repository);

  Future<Either<Failure, List<MangaEntity>>> execute() async {
    return await _repository.getMangaList();
  }
}