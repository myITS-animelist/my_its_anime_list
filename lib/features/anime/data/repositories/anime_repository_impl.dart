import 'package:dio/dio.dart';
import 'package:my_its_anime_list/core/resources/data_state.dart';
import 'package:my_its_anime_list/features/anime/data/datasources/anime_api_service.dart';
import 'package:my_its_anime_list/features/anime/data/models/anime_model.dart';
import 'package:my_its_anime_list/features/anime/domain/entities/anime.dart';
import 'package:my_its_anime_list/features/anime/domain/repositories/anime_repository.dart';

class AnimeRepositoryImpl implements AnimeRepository{
  final AnimeApiService _animeApiService;
  AnimeRepositoryImpl(this._animeApiService);

  @override
  Future<DataState<List<AnimeModel>>> getAnime() {
  try {
    final httpResponse = await _animeApiService.getAnime(
        id: //,
      //etc.
    );

    if (httpResponse.response.statusCode == HttpStatus.ok) {
      return DataSuccess(httpResponse.data);
    } else {
      return DataFailed(
          DioError(
              error: httpResponse.response.statusMessage,
              response: httpResponse.response,
              type: DioErrorType.response,
              requestOptions: httpResponse.response.requestOptions
          )
      );
    }
  } on DioError catch(e){
    return DataFailed(e);
  }
  }

  @override
  Future<List<AnimeEntity>> getSavedAnime() {
    // TODO: implement getSavedAnime
    throw UnimplementedError();
  }

  @override
  Future<void> removeAnime(AnimeEntity anime) {
    // TODO: implement removeAnime
    throw UnimplementedError();
  }

  @override
  Future<void> saveAnime(AnimeEntity anime) {
    // TODO: implement saveAnime
    throw UnimplementedError();
  }

}