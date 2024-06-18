import 'package:my_its_anime_list/features/anime/domain/entities/pictures.dart';

class PictureModel extends PictureEntity {
  const PictureModel({
    required String medium,
    required String large,
  }) : super(
    medium: medium,
    large: large,
  );

  factory PictureModel.fromJson(Map<String, dynamic> json) {
    return PictureModel(
      medium: json['medium'],
      large: json['large'],
    );
  }

  factory PictureModel.fromEntity(PictureEntity entity) {
    return PictureModel(
      medium: entity.medium,
      large: entity.large,
    );
  }
}