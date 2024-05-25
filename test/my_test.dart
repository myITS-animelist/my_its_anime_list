
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:my_its_anime_list/features/manga/data/datasources/remote_datasource.dart';
import 'package:my_its_anime_list/features/manga/data/repositories/manga_repository_impl.dart';
import 'package:my_its_anime_list/features/manga/domain/repositories/manga_repository.dart';
import 'package:my_its_anime_list/features/manga/domain/usecases/create_manga.dart';
import 'package:my_its_anime_list/firebase_options.dart';

void main() async {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  final RemoteDataSource remoteDataSource = RemoteDataSourceImpl(firestore);
  final MangaRepository mangaRepository = MangaRepositoryImpl(remoteDataSource);

  final manga = {
    'title': 'Naruto',
    'author': 'Masashi Kishimoto',
    'sinopsis': 'Naruto adalah seorang ninja dari desa Konoha yang memiliki impian menjadi Hokage',
    'cover': 'https://m.media-amazon.com/images/M/MV5BZmQ5NGFiNWEtMmMyMC00MDdiLTg4YjktOGY5Yzc2MDUxMTE1XkEyXkFqcGdeQXVyNTA4NzY1MzY@._V1_FMjpg_UX1000_.jpg',
    'status': 'Ongoing',
    'type': 'Manga',
    'chapter': ['Chapter 1', 'Chapter 2', 'Chapter 3'],
    'release': '2000',
    'genre': ['Action', 'Adventure', 'Comedy', 'Super Power', 'Martial Arts', 'Shounen']
  };

  final CreateManga createManga = CreateManga(mangaRepository);

  await createManga.execute(manga);

}