import 'package:my_its_anime_list/features/anime_2/views/featured_animes.dart';
import 'package:flutter/material.dart';

import 'package:my_its_anime_list/features/anime_2/common/extensions/extensions.dart';
import 'package:my_its_anime_list/features/anime_2/common/utils/utils.dart';
import 'package:my_its_anime_list/features/anime_2/common/styles/paddings.dart';
import 'package:my_its_anime_list/features/anime_2/screens/home_screen.dart';
import 'package:my_its_anime_list/features/anime_2/widgets/seasonal_anime_view.dart';
import 'package:my_its_anime_list/features/anime_2/widgets/top_animes_list.dart';

class AnimesScreen extends StatefulWidget {
  const AnimesScreen({super.key});

  @override
  State<AnimesScreen> createState() => _AnimesScreenState();
}

class _AnimesScreenState extends State<AnimesScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final currentSeason = getCurrentSeason().capitalize();
    return Scaffold(
      appBar: AppBar(
        title: const Text('MyITS animelist'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushReplacementNamed(
                HomeScreen.routeName,
                arguments: 1,
              );
            },
            icon: const Icon(
              Icons.search,
            ),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          setState(() {});
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Top Animes Slider
              const SizedBox(
                height: 300,
                child: TopAnimesList(),
              ),

              Padding(
                padding: Paddings.noBottomPadding,
                child: Column(
                  children: [
                    // Top Ranked animes
                    const SizedBox(
                      height: 350,
                      child: FeaturedAnimes(
                        rankingType: 'all',
                        label: 'Top Ranked',
                      ),
                    ),

                    // Top Popular Animes
                    const SizedBox(
                      height: 350,
                      child: FeaturedAnimes(
                        rankingType: 'bypopularity',
                        label: 'Top Popular',
                      ),
                    ),

                    // Top Movie Animes
                    const SizedBox(
                      height: 350,
                      child: FeaturedAnimes(
                        rankingType: 'movie',
                        label: 'Top Movie Animes',
                      ),
                    ),

                    // Top Upcoming Animes
                    const SizedBox(
                      height: 350,
                      child: FeaturedAnimes(
                        rankingType: 'upcoming',
                        label: 'Top Upcoming Animes',
                      ),
                    ),

                    // Top Movie Animes
                    SizedBox(
                      height: 350,
                      child: SeasonalAnimeView(
                        label: 'Top Animes this $currentSeason',
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
