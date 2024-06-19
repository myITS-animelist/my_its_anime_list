import 'package:my_its_anime_list/features/anime/domain/entities/anime.dart';
import 'package:my_its_anime_list/features/anime/domain/entities/anime_node.dart';
import 'package:my_its_anime_list/features/anime/data/models/anime_node_model.dart';
import 'package:my_its_anime_list/features/anime/data/models/anime_info_model.dart';
import 'package:my_its_anime_list/features/anime/domain/entities/anime_info.dart';

class AnimeModel extends AnimeEntity {
  const AnimeModel({
    required AnimeNodeEntity node,
    RankingEntity? ranking,
  }) : super(
    node: node,
    ranking: ranking,
  );

  factory AnimeModel.fromJson(Map<String, dynamic> json) {
    return AnimeModel(
      node: AnimeNodeModel.fromJson(json['node']),
      ranking: json['ranking'] != null
          ? RankingModel.fromJson(json['ranking'])
          : null,
    );
  }
}