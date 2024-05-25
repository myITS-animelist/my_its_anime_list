import 'dart:math';

import 'package:my_its_anime_list/core/error/exception.dart';
import 'package:my_its_anime_list/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:my_its_anime_list/features/manga/data/datasources/remote_datasource.dart';
import 'package:my_its_anime_list/features/manga/domain/entities/manga.dart';
import 'package:my_its_anime_list/features/manga/domain/repositories/manga_repository.dart';

class MangaRepositoryImpl implements MangaRepository {
  final RemoteDataSource remoteDataSource;

  MangaRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, List<MangaEntity>>> getMangaList() async {
    try {
      final result = await remoteDataSource.getMangaList();
      return Right(result);
    } on ServerException {
      return Left(Failure());
    }
  }

  @override
  Future<Either<Failure, MangaEntity>> getMangaDetail(String id) async {
    try {
      final result = await remoteDataSource.getMangaDetail(id);
      return Right(result);
    } on ServerException {
      return Left(Failure());
    }
  }

  @override
  Future<void> createManga(Map<String, dynamic> manga) async {
    try {
      await remoteDataSource.createManga(manga);
    } on ServerException {
      throw Failure();
    }
  }
}