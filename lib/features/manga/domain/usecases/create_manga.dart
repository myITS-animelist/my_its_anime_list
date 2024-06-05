import 'package:my_its_anime_list/features/manga/domain/repositories/manga_repository.dart';

class CreateManga {
  final MangaRepository repository;

  CreateManga(this.repository);

  Future<void> execute(Map<String, dynamic> manga) async {
    print("CreateManga.execute: $manga");
    await repository.createManga(manga);
  }
}