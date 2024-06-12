import 'package:my_its_anime_list/features/anime/domain/entities/anime_info.dart';
import 'package:my_its_anime_list/features/anime/domain/entities/anime.dart';
import 'package:my_its_anime_list/features/anime/data/models/anime_model.dart';

class AnimeInfoModel extends AnimeInfoEntity {
  const AnimeInfoModel({
    required List<AnimeEntity> animes,
  }) : super(
    animes: animes,
  );

  factory AnimeInfoModel.fromJson(Map<String, dynamic> json) {
    List<dynamic> animeRankingList = json['data'];
    List<AnimeEntity> animeRankingItems = animeRankingList
        .map(
          (item) => AnimeModel.fromJson(item),
    )
        .toList();
    return AnimeInfoModel(
      animes: animeRankingItems,
    );
  }
}

class RankingModel extends RankingEntity {
  const RankingModel({
    required int rank,
  }) : super(
    rank: rank,
  );

  factory RankingModel.fromJson(Map<String, dynamic> json) {
    return RankingModel(
      rank: json['rank'],
    );
  }
}