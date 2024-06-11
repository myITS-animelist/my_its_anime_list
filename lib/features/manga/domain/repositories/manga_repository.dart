import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_its_anime_list/features/manga/domain/entities/manga.dart';
import 'package:my_its_anime_list/core/error/failure.dart';

abstract class MangaRepository {
  Stream<Either<Failure, List<MangaEntity>>> getMangaList();
  Stream<Either<Failure, MangaEntity>> getMangaDetail(String id);
  Future<void> createManga(Map<String, dynamic> manga);
  Future<void> addImageChapter(String id, String chapNumber, XFile file);
  Future<void> addChapter(String id, Map<String, dynamic> chapter);
  Future<void> addContentToChapter(String mangaId, Map<String, dynamic> newContent, int chapterNum);
}