
import 'package:my_its_anime_list/features/manga/domain/repositories/manga_repository.dart';

class AddContentToChapter {
  final MangaRepository repository;

  AddContentToChapter(this.repository);

  Future<void> execute(String mangaId, Map<String, dynamic> newContent, int chapterNum) async {
    return await repository.addContentToChapter(mangaId, newContent, chapterNum);
  }
}