

import 'package:my_its_anime_list/features/manga/domain/usecases/create_manga.dart';
import 'package:my_its_anime_list/features/manga/domain/usecases/get_all_mangas.dart';
import 'package:my_its_anime_list/features/manga/presentation/bloc/manga_event.dart';
import 'package:my_its_anime_list/features/manga/presentation/bloc/manga_state.dart';
import 'package:bloc/bloc.dart';


class MangaBloc extends Bloc<MangaEvent, MangaState> {
  final GetMangaList getMangaList;

  MangaBloc(this.getMangaList) : super(const MangaLoading()) {
    on <GetMangaListEvent> (onGetMangaList);
  }

  // void onGetMangaList(GetMangaListEvent event, Emitter<MangaState> emit) async {
  //   emit(const MangaLoading());
  //   final result = await getMangaList.execute();
  //   result.fold(
  //     (failure) => emit(MangaError(message: failure.message!)),
  //     (mangalist) => emit(MangaLoaded(mangalist: mangalist)),
  //   );
  // }

void onGetMangaList(GetMangaListEvent event, Emitter<MangaState> emit) async {
  emit(const MangaLoading());
  try {
    final result = await getMangaList.execute().first;
    result.fold(
      (failure) => emit(MangaError(message: failure.message!)),
      (mangalist) => emit(MangaLoaded(mangalist: mangalist)),
    );
  } catch (e) {
    emit(MangaError(message: 'An error occurred: $e'));
  }
}

}
