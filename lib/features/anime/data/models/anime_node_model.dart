import 'package:my_its_anime_list/features/anime/domain/entities/anime_node.dart';
import 'package:my_its_anime_list/features/anime/domain/entities/pictures.dart';
import 'package:my_its_anime_list/features/anime/data/models/pictures_model.dart';


class AnimeNodeModel extends AnimeNodeEntity {
  const AnimeNodeModel({
    required int id,
    required String title,
    required PictureEntity mainPicture,
  }) : super(
    id: id,
    title: title,
    mainPicture: mainPicture,
  );

  factory AnimeNodeModel.fromJson(Map<String, dynamic> json) {
    return AnimeNodeModel(
      id: json['id'],
      title: json['title'],
      mainPicture: PictureModel.fromJson(json['main_picture']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'main_picture': {
        'medium': mainPicture.medium,
        'large': mainPicture.large,
      },
    };
  }
}