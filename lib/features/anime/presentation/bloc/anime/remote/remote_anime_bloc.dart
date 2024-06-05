import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_its_anime_list/core/resources/data_state.dart';
import 'package:my_its_anime_list/features/anime/presentation/bloc/anime/remote/remote_anime_event.dart';
import 'package:my_its_anime_list/features/anime/presentation/bloc/anime/remote/remote_anime_state.dart';
import 'package:my_its_anime_list/features/anime/domain/usecases/get_anime.dart';

class RemoteAnimeBloc extends Bloc<RemoteAnimeEvent, RemoteAnimeState>{

  final GetAnimeUseCase _getAnimeUseCase;
  RemoteAnimeBloc(this._getAnimeUseCase) : super(const RemoteAnimeLoading()){
    on <GetAnime> (onGetAnime);
  }

  void onGetAnime(GetAnime event, Emitter<RemoteAnimeState> emit){
    final dataState = await _getAnimeUseCase();

    if(dataState is DataSuccess && dataState.data!.isNotEmpty){
      emit(RemoteAnimeDone(dataState.data!));
    }
    
    if(dataState is DataFailed){
      emit(RemoteAnimeError(dataState.error!));
    }
  }
}