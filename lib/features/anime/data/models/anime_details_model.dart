import 'package:my_its_anime_list/features/anime/domain/entities/anime_details.dart';
import 'package:my_its_anime_list/features/anime/domain/entities/pictures.dart';
import 'package:my_its_anime_list/features/anime/domain/entities/anime_node.dart';
import 'package:my_its_anime_list/features/anime/data/models/anime_node_model.dart';
import 'package:my_its_anime_list/features/anime/data/models/pictures_model.dart';

class AnimeDetailsModel extends AnimeDetailsEntity {
  const AnimeDetailsModel({
    required int id,
    required String title,
    required PictureEntity mainPicture,
    required AlternativeTitlesModel alternativeTitles,
    required String startDate,
    required String endDate,
    required String synopsis,
    required dynamic mean,
    required int rank,
    required int popularity,
    required int numListUsers,
    required int numScoringUsers,
    required String nsfw,
    required String createdAt,
    required String updatedAt,
    required String mediaType,
    required String status,
    required List<GenreModel> genres,
    required int numEpisodes,
    required StartSeasonModel startSeason,
    BroadcastModel? broadcast,
    required String source,
    required int averageEpisodeDuration,
    required String rating,
    required List<PictureEntity> pictures,
    required String background,
    required List<RelatedAnimeModel> relatedAnime,
    required List<dynamic> relatedManga,
    required List<RecommendationModel> recommendations,
    required List<StudioModel> studios,
    required StatisticsModel statistics,
  }) : super(
    id: id,
    title: title,
    mainPicture: mainPicture,
    alternativeTitles: alternativeTitles,
    startDate: startDate,
    endDate: endDate,
    synopsis: synopsis,
    mean: mean,
    rank: rank,
    popularity: popularity,
    numListUsers: numListUsers,
    numScoringUsers: numScoringUsers,
    nsfw: nsfw,
    createdAt: createdAt,
    updatedAt: updatedAt,
    mediaType: mediaType,
    status: status,
    genres: genres,
    numEpisodes: numEpisodes,
    startSeason: startSeason,
    broadcast: broadcast,
    source: source,
    averageEpisodeDuration: averageEpisodeDuration,
    rating: rating,
    pictures: pictures,
    background: background,
    relatedAnime: relatedAnime,
    relatedManga: relatedManga,
    recommendations: recommendations,
    studios: studios,
    statistics: statistics,
  );

  factory AnimeDetailsModel.fromJson(Map<String, dynamic> json) {
    return AnimeDetailsModel(
      id: json['id'],
      title: json['title'],
      mainPicture: PictureModel.fromJson(json['main_picture']),
      alternativeTitles: AlternativeTitlesModel.fromJson(json['alternative_titles']),
      startDate: json['start_date'] ?? 'Unknown',
      endDate: json['end_date'] ?? 'Unknown',
      synopsis: json['synopsis'],
      mean: json['mean'] ?? 0.0,
      rank: json['rank'] ?? 0,
      popularity: json['popularity'],
      numListUsers: json['num_list_users'],
      numScoringUsers: json['num_scoring_users'],
      nsfw: json['nsfw'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      mediaType: json['media_type'],
      status: json['status'],
      genres: List<GenreModel>.from(
        json['genres'].map(
              (genre) => GenreModel.fromJson(genre),
        ),
      ),
      numEpisodes: json['num_episodes'],
      startSeason: json['start_season'] != null
          ? StartSeasonModel.fromJson(json['start_season'])
          : const StartSeasonModel(
        year: 2000,
        season: 'Unknown',
      ),
      broadcast: json['broadcast'] != null
          ? BroadcastModel.fromJson(json['broadcast'])
          : null,
      source: json['source'],
      averageEpisodeDuration: json['average_episode_duration'],
      rating: json['rating'],
      pictures: List<PictureEntity>.from(
        json['pictures'].map(
              (picture) => PictureModel.fromJson(picture),
        ),
      ),
      background: json['background'],
      relatedAnime: List<RelatedAnimeModel>.from(
        json['related_anime'].map(
              (anime) => RelatedAnimeModel.fromJson(anime),
        ),
      ),
      relatedManga: json['related_manga'],
      recommendations: List<RecommendationModel>.from(
        json['recommendations'].map(
              (rec) => RecommendationModel.fromJson(rec),
        ),
      ),
      studios: List<StudioModel>.from(
        json['studios'].map(
              (studio) => StudioModel.fromJson(studio),
        ),
      ),
      statistics: StatisticsModel.fromJson(
        json['statistics'],
      ),
    );
  }
}

class AlternativeTitlesModel extends AlternativeTitlesEntity {
  const AlternativeTitlesModel({
    required List<String> synonyms,
    required String en,
    required String ja,
  }) : super(
    synonyms: synonyms,
    en: en,
    ja: ja,
  );

  factory AlternativeTitlesModel.fromJson(Map<String, dynamic> json) {
    return AlternativeTitlesModel(
      synonyms: List<String>.from(json['synonyms']),
      en: json['en'],
      ja: json['ja'],
    );
  }
}

class GenreModel extends GenreEntity {
  const GenreModel({
    required int id,
    required String name,
  }) : super(
    id: id,
    name: name,
  );

  factory GenreModel.fromJson(Map<String, dynamic> json) {
    return GenreModel(
      id: json['id'],
      name: json['name'],
    );
  }
}

class StartSeasonModel extends StartSeasonEntity {
  const StartSeasonModel({
    required int year,
    required String season,
  }) : super(
    year: year,
    season: season,
  );

  factory StartSeasonModel.fromJson(Map<String, dynamic> json) {
    return StartSeasonModel(
      year: json['year'],
      season: json['season'],
    );
  }
}

class BroadcastModel extends BroadcastEntity {
  const BroadcastModel({
    required String dayOfWeek,
    required String startTime,
  }) : super(
    dayOfWeek: dayOfWeek,
    startTime: startTime,
  );

  factory BroadcastModel.fromJson(Map<String, dynamic> json) {
    return BroadcastModel(
      dayOfWeek: json['day_of_the_week'],
      startTime: json['start_time'],
    );
  }
}

class RelatedAnimeModel extends RelatedAnimeEntity {
  const RelatedAnimeModel({
    required AnimeNodeEntity node,
    required String relationType,
    required String relationTypeFormatted,
  }) : super(
    node: node,
    relationType: relationType,
    relationTypeFormatted: relationTypeFormatted,
  );

  factory RelatedAnimeModel.fromJson(Map<String, dynamic> json) {
    return RelatedAnimeModel(
      node: AnimeNodeModel.fromJson(json['node']),
      relationType: json['relation_type'],
      relationTypeFormatted: json['relation_type_formatted'],
    );
  }
}

class RecommendationModel extends RecommendationEntity {
  const RecommendationModel({
    required AnimeNodeEntity node,
    required int numRecommendations,
  }) : super(
    node: node,
    numRecommendations: numRecommendations,
  );

  factory RecommendationModel.fromJson(Map<String, dynamic> json) {
    return RecommendationModel(
      node: AnimeNodeModel.fromJson(json['node']),
      numRecommendations: json['num_recommendations'],
    );
  }
}

class StudioModel extends StudioEntity {
  const StudioModel({
    required int id,
    required String name,
  }) : super(
    id: id,
    name: name,
  );

  factory StudioModel.fromJson(Map<String, dynamic> json) {
    return StudioModel(
      id: json['id'],
      name: json['name'],
    );
  }
}

class StatisticsModel extends StatisticsEntity {
  const StatisticsModel({
    required StatusModel status,
    required int numListUsers,
  }) : super(
    status: status,
    numListUsers: numListUsers,
  );

  factory StatisticsModel.fromJson(Map<String, dynamic> json) {
    return StatisticsModel(
      status: StatusModel.fromJson(json['status']),
      numListUsers: json['num_list_users'],
    );
  }
}

class StatusModel extends StatusEntity {
  const StatusModel({
    required dynamic watching,
    required dynamic completed,
    required dynamic onHold,
    required dynamic dropped,
    required dynamic planToWatch,
  }) : super(
    watching: watching,
    completed: completed,
    onHold: onHold,
    dropped: dropped,
    planToWatch: planToWatch,
  );

  factory StatusModel.fromJson(Map<String, dynamic> json) {
    return StatusModel(
      watching: json['watching'],
      completed: json['completed'],
      onHold: json['on_hold'],
      dropped: json['dropped'],
      planToWatch: json['plan_to_watch'],
    );
  }
}