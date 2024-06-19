import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:my_its_anime_list/features/manga/data/datasources/manga_datasource.dart';
import 'package:my_its_anime_list/features/manga/domain/entities/manga.dart';
import 'package:my_its_anime_list/features/manga/presentation/widgets/book_mark_button.dart';
import 'package:my_its_anime_list/features/manga/presentation/widgets/chapter_bottom_sheet.dart';
import 'package:my_its_anime_list/features/manga/presentation/widgets/comment_section.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MangaDetailPage extends StatefulWidget {
  final MangaEntity manga;

  const MangaDetailPage({super.key, required this.manga});

  @override
  State<MangaDetailPage> createState() => _MangaDetailPageState();
}

class _MangaDetailPageState extends State<MangaDetailPage> {
  final MangaDataSource dataSource = MangaDataSourceImpl();
  String? user_id;
  String? userName;
  bool isLloading = true;
  String? role;

  @override
  void initState() {
    super.initState();
    dataSource.fetchUser().then((value) {

      

      setState(() {
        user_id = value['id'];
        userName = value['name'];
        role = value['role'];
        print("USER ID: $user_id");
        isLloading = false;
        // reaload page
      });
    });

    // get role from shared preferences
    SharedPreferences.getInstance().then((prefs) {
        setState(() {
          role = prefs.getString('role');
        });
      });
  }

  @override
  Widget build(BuildContext context) {
    if (kDebugMode) {
      print(widget.manga.chapter);
    }
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.manga.title} "),
        centerTitle: true,
      ),
      body: isLloading
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              children: [
                Image.network(widget.manga.cover),
                BookmarkButton(
                    manga_id: widget.manga.id,
                    user_id: user_id!,
                    title: widget.manga.title),
                ListTile(
                  title: const Text("Author"),
                  subtitle: Text(widget.manga.author),
                ),
                ListTile(
                  title: Text("Sinopsis"),
                  subtitle: Text(widget.manga.sinopsis),
                ),
                ListTile(
                  title: Text("Status"),
                  subtitle: Text(widget.manga.status),
                ),
                ListTile(
                  title: Text("Type"),
                  subtitle: Text(widget.manga.type),
                ),
                ListTile(
                  title: Text("Release"),
                  subtitle: Text(widget.manga.release),
                ),
                ListTile(
                  title: Text("Genre"),
                  subtitle: Text(widget.manga.genre.join(", ")),
                ),
                ListTile(
                  title: Text("Chapter"),
                  subtitle: ChapterBottomSheet(
                    id: widget.manga.id,
                    chapter: widget.manga.chapter,
                    user_id: user_id!,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      builder: (context) => CommentSection(
                        mangaId: widget.manga.id,
                        userId: userName!,
                      ),
                    );
                  },
                  child: Text('Comments'),
                ),
              ],
            ),
    );
  }
}
