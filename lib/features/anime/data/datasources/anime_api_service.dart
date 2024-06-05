import 'package:flutter/material.dart';
import 'package:my_its_anime_list/core/constants/constants.dart';
import 'package:my_its_anime_list/features/anime/data/models/anime_model.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart' hide Headers;
part 'anime_api_service.g.dart';

@RestApi(baseUrl: animeAPIBaseURL)
abstract class AnimeApiService{
  factory AnimeApiService(Dio dio) = _AnimeApiService;

  @Header('X-MAL-CLIENT-ID: 18ee5c0c60c2aac63fa979b1ad106495')
  @GET('/anime')
  Future<HttpResponse<List<AnimeModel>>> getAnime({
    @Query("id") int ? id,
    @Query("title") String ? title,
    @Query("main_picture") String ? main_picture,
    @Query("alternative_titles") String ? alternative_titles,
    @Query("start_date") String ? start_date,
    @Query("end_date") String ? end_date,
    @Query("synopsis") String ? synopsis,
    @Query("mean") dynamic mean,
    @Query("rank") int ? rank,
    @Query("popularity") int ? popularity,
    @Query("num_list_users") int ? num_list_users,
  })
}
