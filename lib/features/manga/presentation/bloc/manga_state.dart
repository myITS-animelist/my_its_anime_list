import 'package:equatable/equatable.dart';
import 'package:my_its_anime_list/features/manga/domain/entities/manga.dart';

abstract class MangaState extends Equatable {
  final List<MangaEntity>? mangalist;

  const MangaState({this.mangalist});

  @override
  List<Object> get props => [mangalist!];
}

class MangaLoading extends MangaState {
  const MangaLoading();
}

class MangaCreate extends MangaState {
  const MangaCreate();
}

class MangaLoaded extends MangaState {
  const MangaLoaded({required List<MangaEntity> mangalist}) : super(mangalist: mangalist);
}

class MangaError extends MangaState {
  final String message;

  const MangaError({required this.message});
}