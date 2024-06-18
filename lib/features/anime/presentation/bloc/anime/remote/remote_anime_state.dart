import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:my_its_anime_list/features/anime/domain/entities/anime.dart';

abstract class RemoteAnimeState extends Equatable{
  final List<AnimeEntity> ? anime;
  final DioError ? error;

  const RemoteAnimeState({this.anime, this.error});

  @override
  List<Object> get props => [anime!, error!];
}

class RemoteAnimeLoading extends RemoteAnimeState{
  const RemoteAnimeLoading();
}

class RemoteAnimeDone extends RemoteAnimeState{
  const RemoteAnimeDone(List<AnimeEntity> anime) : super(anime: anime);
}

class RemoteAnimeError extends RemoteAnimeState{
  const RemoteAnimeError(DioError error) : super(error: error);
}