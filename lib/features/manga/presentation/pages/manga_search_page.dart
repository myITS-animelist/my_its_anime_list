import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_its_anime_list/features/manga/data/datasources/manga_datasource.dart';
import 'package:my_its_anime_list/features/manga/data/models/manga_model.dart';
import 'package:my_its_anime_list/features/manga/presentation/pages/manga_detail_page.dart';

class MangaSearchPageDelegate extends SearchDelegate<String> {
  final MangaDataSource dataSource = MangaDataSourceImpl();

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return _buildSearchResults();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return _buildSearchResults();
  }

  Widget _buildSearchResults() {
    if (query.isEmpty) {
      return Center(
        child: Text('Enter a manga title to search'),
      );
    }

    return FutureBuilder(
      future: dataSource.searchMangaByTitle(query),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        }

        List<MangaModel> mangaList = snapshot.data!;

        return ListView.builder(
          itemCount: mangaList.length,
          itemBuilder: (context, index) {
            String title = mangaList[index].title;
            return ListTile(
              title: Text(title),
              onTap: () {
                close(context, title);
                Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => MangaDetailPage(
                        manga: mangaList[index],
                      ),
                    ),
                  );
                // Navigate to manga details or perform other actions
              },
            );
          },
        );
      },
    );
  }
}
