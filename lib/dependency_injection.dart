import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';
import 'package:my_its_anime_list/features/anime/data/datasources/anime_api_service.dart';
import 'package:my_its_anime_list/features/anime/data/repositories/anime_repository_impl.dart';
import 'package:my_its_anime_list/features/anime/domain/repositories/anime_repository.dart';
import 'package:my_its_anime_list/features/anime/domain/usecases/get_anime.dart';
import 'package:my_its_anime_list/features/anime/domain/usecases/get_saved_anime.dart';
import 'package:my_its_anime_list/features/anime/domain/usecases/remove_anime.dart';
import 'package:my_its_anime_list/features/anime/domain/usecases/save_anime.dart';
import 'package:my_its_anime_list/features/anime/presentation/bloc/anime/remote/remote_anime_bloc.dart';
import 'package:my_its_anime_list/features/manga/data/datasources/remote_datasource.dart';
import 'package:my_its_anime_list/features/manga/data/repositories/manga_repository_impl.dart';
import 'package:my_its_anime_list/features/manga/domain/repositories/manga_repository.dart';
import 'package:my_its_anime_list/features/manga/domain/usecases/add_chapter.dart';
import 'package:my_its_anime_list/features/manga/domain/usecases/add_content_to_chapter.dart';
import 'package:my_its_anime_list/features/manga/domain/usecases/create_manga.dart';
import 'package:my_its_anime_list/features/manga/domain/usecases/get_all_mangas.dart';
import 'package:my_its_anime_list/features/manga/domain/usecases/get_manga.dart';
import 'package:my_its_anime_list/features/manga/presentation/bloc/manga_bloc.dart';
import 'package:dio/dio.dart';
import 'package:my_its_anime_list/features/authentication/data/datasources/auth_remote_data_source.dart';
import 'package:my_its_anime_list/features/authentication/data/repositories/auth_repository_impl.dart';
import 'package:my_its_anime_list/features/authentication/domain/repositories/authentication_repository.dart';
import 'package:my_its_anime_list/features/authentication/domain/usecases/check_verification_usecase.dart';
import 'package:my_its_anime_list/features/authentication/domain/usecases/first_page_usecase.dart';
import 'package:my_its_anime_list/features/authentication/domain/usecases/google_auth_usecase.dart';
import 'package:my_its_anime_list/features/authentication/domain/usecases/logout_usecase.dart';
import 'package:my_its_anime_list/features/authentication/domain/usecases/sign_in_usecase.dart';
import 'package:my_its_anime_list/features/authentication/domain/usecases/sign_up_usecase.dart';
import 'package:my_its_anime_list/features/authentication/domain/usecases/verifiy_email_usecase.dart';
import 'package:my_its_anime_list/features/authentication/presentation/bloc/authentication/auth_bloc.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

import 'core/network/network_info.dart';

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

Future<void> init() async {
  await initializeDependencies();
}

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

  sl.registerSingleton<Dio>(Dio());

  sl.registerSingleton<AddChapter>(
    AddChapter(sl()),
  );

  sl.registerSingleton<AddContentToChapter>(
    AddContentToChapter(sl()),
  );

  sl.registerFactory<MangaBloc>(() => MangaBloc(sl()));

  sl.registerSingleton<AnimeApiService>(AnimeApiService(sl()));
  
  sl.registerSingleton<AnimeRepository>(AnimeRepositoryImpl(sl()));

  sl.registerFactory<RemoteAnimeBloc>(()=> RemoteAnimeBloc(sl()));

  sl.registerSingleton<GetAnimeUseCase>(GetAnimeUseCase(sl()));

  sl.registerSingleton<GetSavedAnimeUseCase>(GetSavedAnimeUseCase(sl()));

  sl.registerSingleton<SaveAnimeUseCase>(SaveAnimeUseCase(sl()));

  sl.registerSingleton<RemoveAnimeUseCase>(RemoveAnimeUseCase(sl()));

// Bloc

  sl.registerFactory(() => AuthBloc(
      signInUseCase: sl(),
      signUpUseCase: sl(),
      firstPage: sl(),
      verifyEmailUseCase: sl(),
      checkVerificationUseCase: sl(),
      logOutUseCase: sl(),
      googleAuthUseCase: sl()));

// Usecases

  sl.registerLazySingleton(() => SignInUseCase(sl()));
  sl.registerLazySingleton(() => SignUpUseCase(sl()));
  sl.registerLazySingleton(() => FirstPageUseCase(sl()));
  sl.registerLazySingleton(() => VerifyEmailUseCase(sl()));
  sl.registerLazySingleton(() => CheckVerificationUseCase(sl()));
  sl.registerLazySingleton(() => LogOutUseCase(sl()));
  sl.registerLazySingleton(() => GoogleAuthUseCase(sl()));

// Repository

  sl.registerLazySingleton<AuthenticationRepository>(() =>
      AuthenticationRepositoryImp(
          networkInfo: sl(), authRemoteDataSource: sl()));

// Datasources

  sl.registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl());

//! Core

  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

//! External

  sl.registerLazySingleton(() => InternetConnection());
}
