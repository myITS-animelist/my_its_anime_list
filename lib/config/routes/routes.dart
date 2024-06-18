
import 'package:flutter/material.dart';
import 'package:my_its_anime_list/features/authentication/presentation/pages/auth/sign_up_page.dart';
import 'package:my_its_anime_list/features/manga/domain/entities/manga.dart';
import 'package:my_its_anime_list/features/manga/presentation/pages/manga_detail_page.dart';
import 'package:my_its_anime_list/features/manga/presentation/pages/manga_home_page.dart';

class AppRoutes {
  static Route onGenerateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const MangaHomePage());
      case '/manga_detail':
        return MaterialPageRoute(builder: (_) => MangaDetailPage(manga: settings.arguments as MangaEntity));
      case '/sign_up':
        return MaterialPageRoute(builder: (_) => const SignUp());
      default:
        return MaterialPageRoute(builder: (_) => const Scaffold(body: Center(child: Text('No route defined for'))) );
    }
  }
}