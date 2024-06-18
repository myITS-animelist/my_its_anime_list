import 'package:flutter/material.dart';

import 'package:my_its_anime_list/features/anime_2/api/get_seasonal_animes_api.dart';
import 'package:my_its_anime_list/features/anime_2/screens/anime_details_screen.dart';
import 'package:my_its_anime_list/features/anime_2/screens/view_all_seasonal_animes_screen.dart';
import 'package:my_its_anime_list/features/anime_2/widgets/anime_tile.dart';

class SeasonalAnimeView extends StatelessWidget {
  const SeasonalAnimeView({
    Key? key,
    required this.label,
  }) : super(key: key);

  final String label;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getSeasonalAnimesApi(limit: 10),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }

        if (snapshot.hasData) {
          final animes = snapshot.data!;
          return Column(
            children: [
              // Top Animes this Season + View all
              SizedBox(
                height: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      label,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ViewAllSeasonalAnimesScreen(
                              label: label,
                            ),
                          ),
                        );
                      },
                      child: const Text('View all'),
                    ),
                  ],
                ),
              ),
              // Image Slider
              SizedBox(
                height: 300,
                child: ListView.separated(
                  itemCount: animes.length,
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  separatorBuilder: (context, index) {
                    return const SizedBox(width: 10);
                  },
                  itemBuilder: (context, index) {
                    final anime = animes.elementAt(index);
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AnimeDetailsScreen(id: anime.node.id),
                          ),
                        );
                      },
                      child: AnimeTile(
                        anime: anime.node,
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        }

        return Text(
          snapshot.error.toString(),
        );
      },
    );
  }
}
