
import 'package:image_picker/image_picker.dart';
import 'package:my_its_anime_list/features/manga/domain/repositories/manga_repository.dart';

class ImageChapterAddUseCase {
  final MangaRepository repository;

  ImageChapterAddUseCase(this.repository);

  Future<void> execute(String id, String chapNumber, XFile file) async {
    return await repository.addImageChapter(id, chapNumber, file);
  }
}