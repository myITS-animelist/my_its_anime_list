import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:my_its_anime_list/features/manga/domain/entities/manga.dart';
import 'package:my_its_anime_list/features/manga/presentation/widgets/chapter_bottom_sheet.dart';

class MangaDetailPage extends StatelessWidget {
  final MangaEntity manga;

  const MangaDetailPage({super.key, required this.manga});

  @override
  Widget build(BuildContext context) {
    if (kDebugMode) {
      print(manga.chapter);
    }
    return Scaffold(
      appBar: AppBar(
        title: Text("${manga.title} "),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          Image.network(manga.cover),
          ListTile(
            title: const Text("Author"),
            subtitle: Text(manga.author),
          ),
          ListTile(
            title: Text("Sinopsis"),
            subtitle: Text(manga.sinopsis),
          ),
          ListTile(
            title: Text("Status"),
            subtitle: Text(manga.status),
          ),
          ListTile(
            title: Text("Type"),
            subtitle: Text(manga.type),
          ),
          ListTile(
            title: Text("Release"),
            subtitle: Text(manga.release),
          ),
          ListTile(
            title: Text("Genre"),
            subtitle: Text(manga.genre.join(", ")),
          ),
          ListTile(
            title: Text("Chapter"),
            subtitle: ChapterBottomSheet(id: manga.id, chapter: manga.chapter), 
          ),
        ],
      ),
    );
  }
}
