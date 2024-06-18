import 'package:my_its_anime_list/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'package:my_its_anime_list/features/anime_2/config/routes/routes.dart';
import 'package:my_its_anime_list/features/anime_2/config/theme/app_theme.dart';
import 'package:my_its_anime_list/features/anime_2/cubits/anime_title_language_cubit.dart';
import 'package:my_its_anime_list/features/anime_2/cubits/theme_cubit.dart';
import 'package:my_its_anime_list/features/anime_2/core/widgets/bookmarks_provider.dart';
import 'package:my_its_anime_list/features/anime_2/screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ThemeCubit(),
        ),
        BlocProvider(
          create: (context) => AnimeTitleLanguageCubit(),
        ),
      ],
      child: ChangeNotifierProvider(
        create: (context) => BookmarksProvider(),
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeMode>(
      builder: (context, state) {
        final themeMode = state;
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          themeMode: themeMode,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          home: const HomeScreen(),
          onGenerateRoute: onGenerateRoute,
        );
      },
    );
  }
}
