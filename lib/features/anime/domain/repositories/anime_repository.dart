import 'package:my_its_anime_list/features/anime/domain/entities/anime.dart';
import 'package:my_its_anime_list/core/resources/data_state.dart';

abstract class AnimeRepository{
  Future<DataState<List<AnimeEntity>>> getAnime();
}