import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:my_its_anime_list/firebase_options.dart';
import 'package:my_its_anime_list/features/authentication/presentation/bloc/authentication/auth_bloc.dart';
import 'package:my_its_anime_list/features/authentication/presentation/pages/auth/sign_up_page.dart';
import 'package:my_its_anime_list/dependency_injection.dart' as di;
import 'package:my_its_anime_list/config/routes/routes.dart';
import 'package:my_its_anime_list/features/manga/presentation/bloc/manga_bloc.dart';
import 'package:my_its_anime_list/features/manga/presentation/pages/manga_home_page.dart';
import 'package:my_its_anime_list/features/anime_2/config/theme/app_theme.dart';
import 'package:my_its_anime_list/features/anime_2/cubits/anime_title_language_cubit.dart';
import 'package:my_its_anime_list/features/anime_2/cubits/theme_cubit.dart';
import 'package:my_its_anime_list/features/anime_2/core/widgets/bookmarks_provider.dart';
import 'package:my_its_anime_list/features/manga/presentation/bloc/manga_event.dart';
import 'package:my_its_anime_list/features/manga/presentation/pages/onboard.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await di.init(); // Initialize dependency injection

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => di.sl<AuthBloc>()..add(CheckLoggingInEvent())),
        BlocProvider(
          create: (context) => ThemeCubit(),
        ),
        BlocProvider(
          create: (context) => AnimeTitleLanguageCubit(),
        ),
        BlocProvider(create: (_) => di.sl<MangaBloc>()..add(GetMangaListEvent())),
      ],
      child: ChangeNotifierProvider(
        create: (_) => BookmarksProvider(),
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is SignedInPageState) {
          return BlocBuilder<ThemeCubit, ThemeMode>(
            builder: (context, themeMode) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                title: 'My Anime List',
                themeMode: themeMode,
                theme: AppTheme.lightTheme,
                darkTheme: AppTheme.darkTheme,
                onGenerateRoute: AppRoutes.onGenerateRoute,
                home: const OnboardingScreen(),
              );
            },
          );
        } else {
          return MaterialApp(
            title: 'My Anime List',
            theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.blue),
            debugShowCheckedModeBanner: false,
            onGenerateRoute: AppRoutes.onGenerateRoute,
            home: const SignUp(),
          );
        }
      },
    );
  }
}