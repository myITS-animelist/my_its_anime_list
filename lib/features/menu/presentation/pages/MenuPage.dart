import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_its_anime_list/dependency_injection.dart';
import 'package:my_its_anime_list/features/authentication/presentation/bloc/authentication/auth_bloc.dart';
import 'package:my_its_anime_list/features/authentication/presentation/pages/auth/sign_in_page.dart';
import 'package:my_its_anime_list/features/authentication/presentation/pages/user_page.dart';
import 'package:my_its_anime_list/features/manga/domain/usecases/get_all_mangas.dart';
import 'package:my_its_anime_list/features/manga/presentation/bloc/manga_bloc.dart';
import 'package:my_its_anime_list/features/manga/presentation/bloc/manga_event.dart';
import 'package:my_its_anime_list/features/manga/presentation/pages/manga_home_page.dart';
import 'package:my_its_anime_list/dependency_injection.dart' as di;


class MenuPage extends StatelessWidget {
  const MenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MyITS Animelist Menu'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 3, // Number of items per row
          children: [
            _buildMangaHomePage(context, Icons.book, 'Manga', MangaHomePage()),
            _buidUserPage(context, Icons.person, 'User', UserPage()),
            // _buildMenuItem(context, Icons.local_grocery_store, 'GoShop', SignIn()),
          ],
        ),
      ),
    );
  }

   Widget _buildMangaHomePage(BuildContext context, IconData icon, String label, Widget page) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => MangaBloc(sl<GetMangaList>())
              ..add(const GetMangaListEvent()),
            child: const MangaHomePage(),
        )));
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 50),
          SizedBox(height: 8),
          Text(label, style: TextStyle(fontSize: 16)),
        ],
      ),
    );
  }

  Widget _buidUserPage(BuildContext context, IconData icon, String label, Widget page) {
    return GestureDetector(
      onTap: () {
       Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (_) => di.sl<AuthBloc>()..add(CheckLoggingInEvent()),
            child: const UserPage(),
            ),
        ));
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 50),
          SizedBox(height: 8),
          Text(label, style: const TextStyle(fontSize: 16)),
        ],
      ),
    );
  }

}

