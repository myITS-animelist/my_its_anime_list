

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_its_anime_list/features/manga/domain/repositories/manga_repository.dart';
import 'package:my_its_anime_list/features/manga/domain/usecases/add_chapter.dart';
import 'package:my_its_anime_list/features/manga/presentation/bloc/chapter/chapter_add_event.dart';
import 'package:my_its_anime_list/features/manga/presentation/bloc/chapter/chapter_add_state.dart';

class ChapterAddBloc extends Bloc<ChapterAddEvent, ChapterAddState> {
  final AddChapter addChapter;

  ChapterAddBloc(this.addChapter) : super(const ChapterAdd()) {
    on<AddChapterEvent>(onAddChapter);
  }

  void onAddChapter(AddChapterEvent event, Emitter<ChapterAddState> emit) async {
    emit(const ChapterAdding());
    try {
      print("ChapterAddBloc.onAddChapter: ${event.chapter}");
      await addChapter.execute(event.id, event.chapter);
      emit(const ChapterAdded());
    } catch (e) {
      emit(ChapterAddError(e.toString()));
    }
  }
}
