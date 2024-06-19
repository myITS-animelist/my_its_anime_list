

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_its_anime_list/features/manga/domain/repositories/manga_repository.dart';
import 'package:my_its_anime_list/features/manga/domain/usecases/add_chapter.dart';
import 'package:my_its_anime_list/features/manga/domain/usecases/add_image_chapter.dart';
import 'package:my_its_anime_list/features/manga/domain/usecases/add_user_manga.dart';
import 'package:my_its_anime_list/features/manga/presentation/bloc/chapter/chapter_add_event.dart';
import 'package:my_its_anime_list/features/manga/presentation/bloc/chapter/chapter_add_state.dart';
import 'package:my_its_anime_list/features/manga/presentation/bloc/imageChapter/image_chapter_add_event.dart';
import 'package:my_its_anime_list/features/manga/presentation/bloc/imageChapter/image_chapter_add_state.dart';
import 'package:my_its_anime_list/features/manga/presentation/bloc/userManga/user_manga_add_event.dart';
import 'package:my_its_anime_list/features/manga/presentation/bloc/userManga/user_manga_add_state.dart';

class UserMangaAddBloc extends Bloc<UserMangaAddEventAbstract, UserMangaAddState> {
  final AddUserMangaUseCase imageChapterAddUseCase;

  UserMangaAddBloc(this.imageChapterAddUseCase) : super(const UserMangaAdd()) {
    on<UserMangaAddEvent>(onUserMangaAdd);
  }

  void onUserMangaAdd(UserMangaAddEvent event, Emitter<UserMangaAddState> emit) async {
    emit(const UserMangaAdding());
    try {
      print("UserMangaAddBloc.onimageChapterAddUseCase: ${event.manga_id}");
      await imageChapterAddUseCase.execute(event.manga_id, event.user_id);
      emit(const UserMangaAdded());
    } catch (e) {
      emit(UserMangaError(e.toString()));
    }
  }
}
