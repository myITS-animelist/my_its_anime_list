import 'package:equatable/equatable.dart';
import 'package:my_its_anime_list/features/anime/domain/entities/anime_node.dart';
import 'package:my_its_anime_list/features/anime/domain/entities/anime_info.dart';

class AnimeEntity extends Equatable {
  final AnimeNodeEntity node;
  final RankingEntity? ranking;

  const AnimeEntity({
    required this.node,
    this.ranking,
  });

  @override
  List<Object?> get props => [node, ranking];
}