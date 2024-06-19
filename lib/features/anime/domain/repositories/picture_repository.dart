import 'package:my_its_anime_list/features/anime/domain/entities/pictures.dart';
import 'package:my_its_anime_list/core/resources/data_state.dart';

abstract class PictureRepository{
  // API Methods
  Future<DataState<List<PictureEntity>>> getPictures();

  // Database Methods

}