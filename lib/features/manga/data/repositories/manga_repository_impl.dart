import 'dart:math';

import 'package:my_its_anime_list/core/error/exception.dart';
import 'package:my_its_anime_list/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:my_its_anime_list/features/manga/data/datasources/remote_datasource.dart';
import 'package:my_its_anime_list/features/manga/data/models/manga_model.dart';
import 'package:my_its_anime_list/features/manga/domain/entities/manga.dart';
import 'package:my_its_anime_list/features/manga/domain/repositories/manga_repository.dart';

class MangaRepositoryImpl implements MangaRepository {
  final RemoteDataSource remoteDataSource;

  MangaRepositoryImpl(this.remoteDataSource);

  // @override
  // Future<Either<Failure, List<MangaEntity>>> getMangaList() async {
  //   try {
  //     final result = await remoteDataSource.getMangaList();
  //     return Right(result);
  //   } on ServerException {
  //     return Left(Failure());
  //   }
  // }

  // @override
  // Future<Either<Failure, MangaEntity>> getMangaDetail(String id) async {
  //   try {
  //     final result = await remoteDataSource.getMangaDetail(id);
  //     return Right(result);
  //   } on ServerException {
  //     return Left(Failure());
  //   }
  // }

    @override
  Stream<Either<Failure, List<MangaEntity>>> getMangaList() async* {
    try {
      final result = remoteDataSource.getMangaList();

      await for (final mangaModel in result) {
        final mangaEntity = mangaModel.map((e) => MangaEntity(
          title: e.title,
          author: e.author,
          sinopsis: e.sinopsis,
          cover: e.cover,
          status: e.status,
          type: e.type,
          chapter: e.chapter,
          release: e.release,
          genre: e.genre,
          id: e.id,
        )).toList();
        yield Right<Failure, List<MangaEntity>>(mangaEntity);
      }
    } on ServerException {
      yield Left<Failure, List<MangaEntity>>(Failure());
    }
  }

  @override
  Stream<Either<Failure, MangaEntity>> getMangaDetail(String id) async* {
    try {
      final mangaStream = remoteDataSource.getMangaDetail(id);

      await for (final mangaModel in mangaStream) {
        final mangaEntity = MangaEntity(
          title: mangaModel.title,
          author: mangaModel.author,
          sinopsis: mangaModel.sinopsis,
          cover: mangaModel.cover,
          status: mangaModel.status,
          type: mangaModel.type,
          chapter: mangaModel.chapter,
          release: mangaModel.release,
          genre: mangaModel.genre,
          id: mangaModel.id,
        );
        yield Right<Failure, MangaEntity>(mangaEntity);
      }
    } on ServerException {
      yield Left<Failure, MangaEntity>(Failure());
    }
  }

  @override
  Stream<void> createManga(Map<String, dynamic> manga) async* {
    try {
      print("MangaRepositoryImpl.createManga: $manga");
      await remoteDataSource.createManga(manga);
    } on ServerException {
      throw Failure();
    }
  }
  

  @override
  Future<void> addChapter(String id, Map<String, dynamic> chapter) async {
    try {
      await remoteDataSource.addChapter(id, chapter);
    } on ServerException {
      throw Failure();
    }
  }

  @override
  Future<void> addContentToChapter(String mangaId, Map<String, dynamic> newContent, int chapterNum) async {
    try {
      await remoteDataSource.addContentToChapter(mangaId, newContent, chapterNum);
    } on ServerException {
      throw Failure();
    }
  }
}
