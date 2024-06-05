import 'package:my_its_anime_list/core/resources/data_state.dart';
import 'package:my_its_anime_list/core/usecase/usecase.dart';
import 'package:my_its_anime_list/features/anime/domain/entities/anime.dart';
import 'package:my_its_anime_list/features/anime/domain/repositories/anime_repository.dart';

class GetAnimeUseCase implements UseCase<DataState<List<AnimeEntity>>, void>{

  final AnimeRepository _animeRepository;

  GetAnimeUseCase(this._animeRepository);
  @override
  Future<DataState<List<AnimeEntity>>> call({void params}) {
    return _animeRepository.getAnime();
  }
  
}