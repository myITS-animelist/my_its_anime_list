import 'package:equatable/equatable.dart';
import 'package:my_its_anime_list/features/anime/domain/entities/pictures.dart';

class AnimeNodeEntity extends Equatable {
  final int id;
  final String title;
  final PictureEntity mainPicture;

  const AnimeNodeEntity({
    required this.id,
    required this.title,
    required this.mainPicture,
  });

  @override
  List<Object?> get props => [id, title, mainPicture];
}