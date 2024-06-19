import 'package:flutter/material.dart';

import 'package:my_its_anime_list/features/anime_2/common/styles/paddings.dart';
import 'package:my_its_anime_list/features/anime_2/widgets/anime_list_tile.dart';
import 'package:my_its_anime_list/features/anime_2/models/anime.dart';

class AnimeListView extends StatelessWidget {
  const AnimeListView({
    super.key,
    required this.animes,
  });

  final Iterable<Anime> animes;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: Paddings.defaultPadding,
      child: ListView.builder(
        itemCount: animes.length,
        itemBuilder: (context, index) {
          final anime = animes.elementAt(index);
          return AnimeListTile(
            anime: anime,
          );
        },
      ),
    );
  }
}
