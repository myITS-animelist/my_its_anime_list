import 'package:equatable/equatable.dart';
import 'package:my_its_anime_list/features/anime/domain/entities/anime.dart';

class AnimeInfoEntity extends Equatable {
  final List<AnimeEntity> animes;

  const AnimeInfoEntity({
    required this.animes,
  });

  @override
  List<Object?> get props => [animes];
}

class RankingEntity extends Equatable {
  final int rank;

  const RankingEntity({
    required this.rank,
  });

  @override
  List<Object?> get props => [rank];
}