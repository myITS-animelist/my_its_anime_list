import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';

abstract class UserMangaAddEventAbstract extends Equatable {
  const UserMangaAddEventAbstract();

  @override
  List<Object> get props => [];
}

class UserMangaAddEvent extends UserMangaAddEventAbstract {
  final String manga_id;
  final String user_id;

  const UserMangaAddEvent(this.manga_id, this.user_id);

  @override
  List<Object> get props => [user_id, manga_id];
}
