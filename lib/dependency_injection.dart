import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';
import 'package:my_its_anime_list/features/manga/data/datasources/remote_datasource.dart';
import 'package:my_its_anime_list/features/manga/data/repositories/manga_repository_impl.dart';
import 'package:my_its_anime_list/features/manga/domain/repositories/manga_repository.dart';
import 'package:my_its_anime_list/features/manga/domain/usecases/create_manga.dart';
import 'package:my_its_anime_list/features/manga/domain/usecases/get_all_mangas.dart';
import 'package:my_its_anime_list/features/manga/domain/usecases/get_manga.dart';
import 'package:my_its_anime_list/features/manga/presentation/bloc/manga_bloc.dart';

// final FirebaseFirestore firestore = FirebaseFirestore.instance;

// final RemoteDataSource remoteDataSource = RemoteDataSourceImpl(firestore);
// final MangaRepository mangaRepository = MangaRepositoryImpl(remoteDataSource);

// final manga = {
//   'title': 'One Piece',
//   'author': 'Oda',
//   'sinopsis': 'Naruto adalah seorang ninja dari desa Konoha yang memiliki impian menjadi Hokage',
//   'cover': 'https://m.media-amazon.com/images/M/MV5BZmQ5NGFiNWEtMmMyMC00MDdiLTg4YjktOGY5Yzc2MDUxMTE1XkEyXkFqcGdeQXVyNTA4NzY1MzY@._V1_FMjpg_UX1000_.jpg',
//   'status': 'Ongoing',
//   'type': 'Manga',
//   'chapter': ['Chapter 1', 'Chapter 2', 'Chapter 3'],
//   'release': '2000',
//   'genre': ['Action', 'Adventure', 'Comedy', 'Super Power', 'Martial Arts', 'Shounen']
// };

// final CreateManga createManga = CreateManga(mangaRepository);

// await createManga.execute(manga);

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  sl.registerSingleton<FirebaseFirestore>(
    FirebaseFirestore.instance,
  );

  sl.registerSingleton<RemoteDataSource>(
    RemoteDataSourceImpl(sl()),
  );

  sl.registerSingleton<MangaRepository>(
    MangaRepositoryImpl(sl()),
  );

  sl.registerSingleton<GetMangaList>(
    GetMangaList(sl()),
  );

  sl.registerSingleton<GetMangaDetail>(
    GetMangaDetail(sl()),
  );

  sl.registerSingleton<CreateManga>(
    CreateManga(sl()),
  );

  sl.registerFactory<MangaBloc>(() => MangaBloc(sl()));
}
