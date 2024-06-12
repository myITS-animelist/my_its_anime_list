import 'package:my_its_anime_list/features/anime/domain/entities/anime.dart';
import 'package:my_its_anime_list/core/resources/data_state.dart';

abstract class AnimeRepository{
  // API Methods
  Future<DataState<List<AnimeEntity>>> getAnime();

  // Database Methods
  Future < List < AnimeEntity >> getSavedAnime();
  Future < void > saveAnime(AnimeEntity anime);
  Future < void > removeAnime(AnimeEntity anime);
}