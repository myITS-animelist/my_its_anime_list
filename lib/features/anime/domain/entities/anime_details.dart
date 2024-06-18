import 'package:equatable/equatable.dart';
import 'package:my_its_anime_list/features/anime/domain/entities/pictures.dart';
import 'package:my_its_anime_list/features/anime/domain/entities/anime_node.dart';

class AnimeDetailsEntity extends Equatable {
  final int id;
  final String title;
  final PictureEntity mainPicture;
  final AlternativeTitlesEntity alternativeTitles;
  final String startDate;
  final String endDate;
  final String synopsis;
  final dynamic mean;
  final int rank;
  final int popularity;
  final int numListUsers;
  final int numScoringUsers;
  final String nsfw;
  final String createdAt;
  final String updatedAt;
  final String mediaType;
  final String status;
  final List<GenreEntity> genres;
  final int numEpisodes;
  final StartSeasonEntity startSeason;
  final BroadcastEntity? broadcast;
  final String source;
  final int averageEpisodeDuration;
  final String rating;
  final List<PictureEntity> pictures;
  final String background;
  final List<RelatedAnimeEntity> relatedAnime;
  final List<dynamic> relatedManga;
  final List<RecommendationEntity> recommendations;
  final List<StudioEntity> studios;
  final StatisticsEntity statistics;

  const AnimeDetailsEntity({
    required this.id,
    required this.title,
    required this.mainPicture,
    required this.alternativeTitles,
    required this.startDate,
    required this.endDate,
    required this.synopsis,
    required this.mean,
    required this.rank,
    required this.popularity,
    required this.numListUsers,
    required this.numScoringUsers,
    required this.nsfw,
    required this.createdAt,
    required this.updatedAt,
    required this.mediaType,
    required this.status,
    required this.genres,
    required this.numEpisodes,
    required this.startSeason,
    this.broadcast,
    required this.source,
    required this.averageEpisodeDuration,
    required this.rating,
    required this.pictures,
    required this.background,
    required this.relatedAnime,
    required this.recommendations,
    required this.studios,
    required this.statistics,
    required this.relatedManga,
  });

  @override
  List<Object?> get props => [
    id,
    title,
    mainPicture,
    alternativeTitles,
    startDate,
    endDate,
    synopsis,
    mean,
    rank,
    popularity,
    numListUsers,
    numScoringUsers,
    nsfw,
    createdAt,
    updatedAt,
    mediaType,
    status,
    genres,
    numEpisodes,
    startSeason,
    broadcast,
    source,
    averageEpisodeDuration,
    rating,
    pictures,
    background,
    relatedAnime,
    relatedManga,
    recommendations,
    studios,
    statistics,
  ];
}

class AlternativeTitlesEntity extends Equatable {
  final List<String> synonyms;
  final String en;
  final String ja;

  const AlternativeTitlesEntity({
    required this.synonyms,
    required this.en,
    required this.ja,
  });

  @override
  List<Object?> get props => [synonyms, en, ja];
}

class GenreEntity extends Equatable {
  final int id;
  final String name;

  const GenreEntity({
    required this.id,
    required this.name,
  });

  @override
  List<Object?> get props => [id, name];
}

class StartSeasonEntity extends Equatable {
  final int year;
  final String season;

  const StartSeasonEntity({
    required this.year,
    required this.season,
  });

  @override
  List<Object?> get props => [year, season];
}

class BroadcastEntity extends Equatable {
  final String dayOfWeek;
  final String startTime;

  const BroadcastEntity({
    required this.dayOfWeek,
    required this.startTime,
  });

  @override
  List<Object?> get props => [dayOfWeek, startTime];
}

class RelatedAnimeEntity extends Equatable {
  final AnimeNodeEntity node;
  final String relationType;
  final String relationTypeFormatted;

  const RelatedAnimeEntity({
    required this.node,
    required this.relationType,
    required this.relationTypeFormatted,
  });

  @override
  List<Object?> get props => [node, relationType, relationTypeFormatted];
}

class RecommendationEntity extends Equatable {
  final AnimeNodeEntity node;
  final int numRecommendations;

  const RecommendationEntity({
    required this.node,
    required this.numRecommendations,
  });

  @override
  List<Object?> get props => [node, numRecommendations];
}

class StudioEntity extends Equatable {
  final int id;
  final String name;

  const StudioEntity({
    required this.id,
    required this.name,
  });

  @override
  List<Object?> get props => [id, name];
}

class StatisticsEntity extends Equatable {
  final StatusEntity status;
  final int numListUsers;

  const StatisticsEntity({
    required this.status,
    required this.numListUsers,
  });

  @override
  List<Object?> get props => [status, numListUsers];
}

class StatusEntity extends Equatable {
  final dynamic watching;
  final dynamic completed;
  final dynamic onHold;
  final dynamic dropped;
  final dynamic planToWatch;

  const StatusEntity({
    required this.watching,
    required this.completed,
    required this.onHold,
    required this.dropped,
    required this.planToWatch,
  });

  @override
  List<Object?> get props => [watching, completed, onHold, dropped, planToWatch];
}