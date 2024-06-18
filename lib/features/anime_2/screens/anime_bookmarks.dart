import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:my_its_anime_list/features/anime_2/core/widgets/bookmarks_provider.dart';
import 'package:my_its_anime_list/features/anime_2/screens/anime_details_screen.dart';

class BookmarksScreen extends StatelessWidget {
  static const routeName = '/bookmarks';

  const BookmarksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bookmarked Animes'),
      ),
      body: Consumer<BookmarksProvider>(
        builder: (context, bookmarksProvider, child) {
          final bookmarkedAnimes = bookmarksProvider.bookmarkedAnimes;

          if (bookmarkedAnimes.isEmpty) {
            return const Center(
              child: Text('No bookmarked animes yet!'),
            );
          }

          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 9 / 16,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
            ),
            itemCount: bookmarkedAnimes.length,
            itemBuilder: (context, index) {
              final anime = bookmarkedAnimes[index];
              return InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => AnimeDetailsScreen(id: anime.id),
                    ),
                  );
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.network(
                          anime.mainPicture.large,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      anime.title,
                      style: Theme.of(context).textTheme.titleSmall,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
