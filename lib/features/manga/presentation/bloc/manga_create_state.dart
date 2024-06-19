import 'package:equatable/equatable.dart';

abstract class MangaCreateState extends Equatable {
  const MangaCreateState();

  @override
  List<Object> get props => [];
}

class MangaCreate extends MangaCreateState {
  const MangaCreate();

  @override
  List<Object> get props => [];
}

class MangaCreating extends MangaCreateState {
  const MangaCreating();

  @override
  List<Object> get props => [];
}

class MangaCreated extends MangaCreateState {
  const MangaCreated();

  @override
  List<Object> get props => [];
}

class MangaCreateError extends MangaCreateState {
  final String message;

  const MangaCreateError(this.message);

  @override
  List<Object> get props => [message];
}