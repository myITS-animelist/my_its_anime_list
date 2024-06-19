import 'package:my_its_anime_list/core/resources/data_state.dart';
import 'package:my_its_anime_list/core/usecase/usecase.dart';
import 'package:my_its_anime_list/features/anime/domain/entities/anime.dart';
import 'package:my_its_anime_list/features/anime/domain/repositories/anime_repository.dart';

class RemoveAnimeUseCase implements UseCase<void, AnimeEntity>{

  final AnimeRepository _animeRepository;

  RemoveAnimeUseCase(this._animeRepository);
  @override
  Future<void> call({AnimeEntity ? params}) {
    return _animeRepository.removeAnime(params!);
  }

}