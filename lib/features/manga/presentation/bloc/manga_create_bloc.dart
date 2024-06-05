import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_its_anime_list/features/manga/domain/usecases/create_manga.dart';
import 'package:my_its_anime_list/features/manga/presentation/bloc/manga_create_event.dart';
import 'package:my_its_anime_list/features/manga/presentation/bloc/manga_create_state.dart';

class MangaBlocCreate extends Bloc<MangaCreateEvent, MangaCreateState> {
  final CreateManga createManga;

  MangaBlocCreate(this.createManga) : super(const MangaCreate()) {
    on<CreateMangaEvent>(onCreateManga);
  }

  void onCreateManga(CreateMangaEvent event, Emitter<MangaCreateState> emit) async {
    emit(const MangaCreating());
    try {
      print("MangaBlocCreate.onCreateManga: ${event.mangaData}");
      await createManga.execute(event.mangaData);
      // await createManga.execute(event.mangaData);
      emit(const MangaCreated());
    } catch (e) {
      emit(MangaCreateError(e.toString()));
    }
  }
}
