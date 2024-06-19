
import 'package:my_its_anime_list/features/manga/domain/repositories/manga_repository.dart';

class AddChapter {
  final MangaRepository repository;

  AddChapter(this.repository);

  Future<void> execute(String id, Map<String, dynamic> chapter) async {
    return await repository.addChapter(id, chapter);
  }
}