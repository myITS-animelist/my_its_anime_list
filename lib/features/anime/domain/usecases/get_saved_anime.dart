import 'package:my_its_anime_list/core/resources/data_state.dart';
import 'package:my_its_anime_list/core/usecase/usecase.dart';
import 'package:my_its_anime_list/features/anime/domain/entities/anime.dart';
import 'package:my_its_anime_list/features/anime/domain/repositories/anime_repository.dart';

class GetSavedAnimeUseCase implements UseCase<List<AnimeEntity>, void>{

  final AnimeRepository _animeRepository;

  GetSavedAnimeUseCase(this._animeRepository);
  @override
  Future<List<AnimeEntity>> call({void params}) {
    return _animeRepository.getSavedAnime();
  }

}