

import 'package:dartz/dartz.dart';
import 'package:my_its_anime_list/core/error/failure.dart';
import 'package:my_its_anime_list/features/manga/domain/entities/manga.dart';
import 'package:my_its_anime_list/features/manga/domain/usecases/create_manga.dart';
import 'package:my_its_anime_list/features/manga/domain/usecases/get_all_mangas.dart';
import 'package:my_its_anime_list/features/manga/presentation/bloc/manga_event.dart';
import 'package:my_its_anime_list/features/manga/presentation/bloc/manga_state.dart';
import 'package:bloc/bloc.dart';


class MangaBloc extends Bloc<MangaEvent, MangaState> {
  final GetMangaList getMangaList;

  MangaBloc(this.getMangaList) : super(const MangaLoading()) {
    on <GetMangaListEvent> (_onGetMangaList);
  }

  // void onGetMangaList(GetMangaListEvent event, Emitter<MangaState> emit) async {
  //   emit(const MangaLoading());
  //   final result = await getMangaList.execute();
  //   result.fold(
  //     (failure) => emit(MangaError(message: failure.message!)),
  //     (mangalist) => emit(MangaLoaded(mangalist: mangalist)),
  //   );
  // }

// void onGetMangaList(GetMangaListEvent event, Emitter<MangaState> emit) async {
//   emit(const MangaLoading());
//   try {
//     final result = await getMangaList.execute().first;
//     result.fold(
//       (failure) => emit(MangaError(message: failure.message!)),
//       (mangalist) => emit(MangaLoaded(mangalist: mangalist)),
//     );
//   } catch (e) {
//     emit(MangaError(message: 'An error occurred: $e'));
//   }
// }

Future<void> _onGetMangaList(
      GetMangaListEvent event, Emitter<MangaState> emit) async {
    emit(const MangaLoading());
    await emit.forEach<Either<Failure, List<MangaEntity>>>(
      getMangaList.execute(),
      onData: (result) {
        if (result != null) {
          return result.fold(
            (failure) => MangaError(message: failure.message ?? 'Unknown Error'),
            (mangalist) => MangaLoaded(mangalist: mangalist),
          );
        } else {
          return const MangaError(message: 'Received null data');
        }
      },
      onError: (_, __) => const MangaError(message: 'An error occurred'),
    );
  }

}
