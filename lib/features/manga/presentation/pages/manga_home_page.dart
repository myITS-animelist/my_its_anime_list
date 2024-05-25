import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_its_anime_list/features/manga/presentation/bloc/manga_bloc.dart';
import 'package:my_its_anime_list/features/manga/presentation/bloc/manga_state.dart';


class MangaHomePage extends StatelessWidget {
  const MangaHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("My ITS Anime List"),
          centerTitle: true,
        ),
        body: BlocBuilder<MangaBloc, MangaState>(builder: (context, state) {
          if (state is MangaLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is MangaLoaded) {
            return ListView.builder(
              itemCount: state.mangalist!.length,
              itemBuilder: (context, index) {
                final manga = state.mangalist![index];
                return ListTile(
                  leading: Image.network(manga.cover),
                  title: Text(manga.title),
                  subtitle: Text(manga.author),
                  onTap: () => Navigator.pushNamed(context, '/manga_detail', arguments: manga),
                );
              }
            );
          } else if (state is MangaError) {
            return Center(
              child: Text(state.message),
            );
          } else {
            return const Center(
              child: Text("Unknown state"),
            );
          }
        }));
  }
}
