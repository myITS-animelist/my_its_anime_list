import 'package:my_its_anime_list/features/anime/domain/entities/anime.dart';

class AnimeModel extends AnimeEntity{
  const AnimeModel({
    final int ? id;
    final String ? title;
    final int ? rating;
    final String ? synopsis;
    final String ? poster;
    final String ? type;
    final int ? episode;
    final String ? status;
    final String ? premiered;
  });

  factory AnimeModel.fromJson(Map < String, dynamic > map) {
    return AnimeModel(

    );
  }
}