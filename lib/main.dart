import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_its_anime_list/config/routes/routes.dart';
import 'package:my_its_anime_list/dependency_injection.dart' as di;
import 'package:my_its_anime_list/features/manga/presentation/bloc/manga_bloc.dart';
import 'package:my_its_anime_list/features/manga/presentation/bloc/manga_event.dart';
import 'package:my_its_anime_list/features/manga/presentation/pages/manga_home_page.dart';
import 'package:my_its_anime_list/firebase_options.dart';
import 'package:my_its_anime_list/features/authentication/presentation/bloc/authentication/auth_bloc.dart';
import 'package:my_its_anime_list/features/authentication/presentation/pages/auth/sign_up_page.dart';
import 'package:my_its_anime_list/features/authentication/presentation/pages/home.dart';
import 'package:my_its_anime_list/features/authentication/presentation/pages/user_page.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => di.sl<AuthBloc>()..add(CheckLoggingInEvent()),
        child: BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
          if (state is SignedInPageState) {
            return MaterialApp(
              title: 'Flutter Demo',
              debugShowCheckedModeBanner: false,
              onGenerateRoute: AppRoutes.onGenerateRoutes,
              home: BlocProvider(
                  create: (_) => di.sl<MangaBloc>()..add(GetMangaListEvent()),
                  child: const UserPage()),
            );
          } else {
            return MaterialApp(
              title: 'Flutter Demo',
              theme:
                  ThemeData(useMaterial3: true, colorSchemeSeed: Colors.blue),
              debugShowCheckedModeBanner: false,
              onGenerateRoute: AppRoutes.onGenerateRoutes,
              home: const SignUp(),
            );
          }
        }));
  }
}
