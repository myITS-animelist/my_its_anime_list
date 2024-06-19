

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_its_anime_list/features/manga/domain/repositories/manga_repository.dart';
import 'package:my_its_anime_list/features/manga/domain/usecases/add_chapter.dart';
import 'package:my_its_anime_list/features/manga/domain/usecases/add_image_chapter.dart';
import 'package:my_its_anime_list/features/manga/presentation/bloc/chapter/chapter_add_event.dart';
import 'package:my_its_anime_list/features/manga/presentation/bloc/chapter/chapter_add_state.dart';
import 'package:my_its_anime_list/features/manga/presentation/bloc/imageChapter/image_chapter_add_event.dart';
import 'package:my_its_anime_list/features/manga/presentation/bloc/imageChapter/image_chapter_add_state.dart';

class ImageChapterAddBloc extends Bloc<ImageChapterAddEventAbstract, ImageChapterAddState> {
  final ImageChapterAddUseCase imageChapterAddUseCase;

  ImageChapterAddBloc(this.imageChapterAddUseCase) : super(const ImageChapterAdd()) {
    on<ImageChapterAddEvent>(onImageChapterAdd);
  }

  void onImageChapterAdd(ImageChapterAddEvent event, Emitter<ImageChapterAddState> emit) async {
    emit(const ImageChapterAdding());
    try {
      print("ImageChapterAddBloc.onimageChapterAddUseCase: ${event.chapter}");
      await imageChapterAddUseCase.execute(event.id, event.chapter, event.file);
      emit(const ImageChapterAdded());
    } catch (e) {
      emit(ImageChapterError(e.toString()));
    }
  }
}
