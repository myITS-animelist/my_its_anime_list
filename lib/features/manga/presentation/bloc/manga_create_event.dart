import 'package:equatable/equatable.dart';

abstract class MangaCreateEvent extends Equatable {
  const MangaCreateEvent();

  @override
  List<Object> get props => [];
}

class CreateMangaEvent extends MangaCreateEvent {
  final Map<String, dynamic> mangaData;

  const CreateMangaEvent(this.mangaData);

  @override
  List<Object> get props => [mangaData];
}