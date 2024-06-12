
import 'package:my_its_anime_list/features/manga/domain/repositories/manga_repository.dart';

class AddUserMangaUseCase {
  final MangaRepository repository;

  AddUserMangaUseCase(this.repository);

  Future<void> execute(String manga_id, String user_id) async {
    return await repository.addUserManga(manga_id, user_id);
  }
}