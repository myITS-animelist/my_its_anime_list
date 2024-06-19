
import 'package:equatable/equatable.dart';

abstract class UserMangaAddState extends Equatable {
  const UserMangaAddState();
  
  @override
  List<Object> get props => [];
}

class UserMangaAdd extends UserMangaAddState {
  const UserMangaAdd();

  @override
  List<Object> get props => [];
}

class UserMangaAdding extends UserMangaAddState {
  const UserMangaAdding();

  @override
  List<Object> get props => [];
}

class UserMangaAdded extends UserMangaAddState {
  const UserMangaAdded();

  @override
  List<Object> get props => [];
}

class UserMangaError extends UserMangaAddState {
  final String message;

  const UserMangaError(this.message);

  @override
  List<Object> get props => [message];
}

class ImageChapterEmpty extends UserMangaAddState {
  const ImageChapterEmpty();

  @override
  List<Object> get props => [];
}



