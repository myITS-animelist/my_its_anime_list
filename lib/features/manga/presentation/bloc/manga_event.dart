
import 'package:equatable/equatable.dart';

abstract class MangaEvent extends Equatable {
  const MangaEvent();

  @override
  List<Object> get props => [];
}

class GetMangaListEvent extends MangaEvent {
  const GetMangaListEvent();
}

class GetMangaDetailEvent extends MangaEvent {
  final String id;

  const GetMangaDetailEvent(this.id);

  @override
  List<Object> get props => [id];
}