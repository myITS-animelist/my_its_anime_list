import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_its_anime_list/features/anime_2/common/widgets/network_image_view.dart';
import 'package:my_its_anime_list/features/anime_2/core/screens/error_screen.dart';
import 'package:my_its_anime_list/features/anime_2/models/anime_category.dart';
import 'package:my_its_anime_list/features/anime_2/screens/anime_bookmarks.dart';
import 'package:my_its_anime_list/features/anime_2/screens/anime_details_screen.dart';
import 'package:my_its_anime_list/features/anime_2/screens/category_animes_screen.dart';
import 'package:my_its_anime_list/features/anime_2/screens/home_screen.dart';
import 'package:my_its_anime_list/features/anime_2/screens/view_all_animes_screen.dart';
import 'package:my_its_anime_list/features/anime_2/screens/view_all_seasonal_animes_screen.dart';
import 'package:my_its_anime_list/features/authentication/presentation/pages/auth/sign_up_page.dart';
import 'package:my_its_anime_list/features/manga/domain/entities/manga.dart';
import 'package:my_its_anime_list/features/manga/presentation/pages/manga_detail_page.dart';
import 'package:my_its_anime_list/features/manga/presentation/pages/manga_home_page.dart';

class AppRoutes {
  static Route onGenerateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case AnimeDetailsScreen.routeName:
        final id = settings.arguments as int;
        return _cupertinoRoute(
          view: AnimeDetailsScreen(id: id),
        );

      case ViewAllAnimesScreen.routeName:
        final arguments = settings.arguments as Map<String, dynamic>;
        final rankingType = arguments['rankingType'] as String;
        final label = arguments['label'] as String;
        return _cupertinoRoute(
          view: ViewAllAnimesScreen(
            rankingType: rankingType,
            label: label,
          ),
        );

      case ViewAllSeasonalAnimesScreen.routeName:
        final arguments = settings.arguments as Map<String, dynamic>;
        final label = arguments['label'] as String;
        return _cupertinoRoute(
          view: ViewAllSeasonalAnimesScreen(
            label: label,
          ),
        );

      case CategoryanimesScreen.routeName:
        final category = settings.arguments as AnimeCategory;
        return _cupertinoRoute(
          view: CategoryanimesScreen(
            category: category,
          ),
        );

      case HomeScreen.routeName:
        final index = settings.arguments as int?;
        return _cupertinoRoute(
          view: HomeScreen(
            index: index,
          ),
        );

      case NetworkImageView.routeName:
        final imageUrl = settings.arguments as String;
        return _cupertinoRoute(
          view: NetworkImageView(
            url: imageUrl,
          ),
        );

      case BookmarksScreen.routeName:
        return _cupertinoRoute(
          view: const BookmarksScreen(),
        );

      case '/':
        return MaterialPageRoute(builder: (_) => const MangaHomePage());

      case '/manga_detail':
        return MaterialPageRoute(builder: (_) => MangaDetailPage(manga: settings.arguments as MangaEntity));

      case '/sign_up':
        return MaterialPageRoute(builder: (_) => const SignUp());

      default:
        return _cupertinoRoute(
          view: const ErrorScreen(
            error: 'The route you entered doesn\'t exist',
          ),
        );
    }
  }

  static CupertinoPageRoute _cupertinoRoute({
    required Widget view,
  }) {
    return CupertinoPageRoute(
      builder: (_) => view,
    );
  }
}