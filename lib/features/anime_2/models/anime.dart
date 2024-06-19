import 'package:flutter/foundation.dart' show immutable;

import 'package:my_its_anime_list/features/anime_2/models/anime_info.dart';
import 'package:my_its_anime_list/features/anime_2/models/anime_node.dart';

@immutable
class Anime {
  final AnimeNode node;
  final Ranking? ranking;

  const Anime({
    required this.node,
    this.ranking,
  });

  factory Anime.fromJson(Map<String, dynamic> json) {
    return Anime(
      node: AnimeNode.fromJson(json['node']),
      ranking:
          json['ranking'] != null ? Ranking.fromJson(json['ranking']) : null,
    );
  }
}
