import 'package:flutter/material.dart';
import 'package:my_its_anime_list/features/manga/data/datasources/manga_datasource.dart';
import 'package:my_its_anime_list/features/manga/presentation/widgets/add_chapter_form.dart';
import 'package:my_its_anime_list/features/manga/presentation/widgets/manga_image_list.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChapterBottomSheet extends StatefulWidget {
  final List<Map<String, dynamic>> chapter;
  final String id;
  final String user_id;
  const ChapterBottomSheet(
      {super.key,
      required this.id,
      required this.chapter,
      required this.user_id});

  @override
  State<ChapterBottomSheet> createState() => _ChapterBottomSheetState();
}

class _ChapterBottomSheetState extends State<ChapterBottomSheet> {
  final MangaDataSource dataSource = MangaDataSourceImpl();
  String? role;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();

    SharedPreferences.getInstance().then((prefs) {
      setState(() {
        role = prefs.getString('role')!;
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return 
    isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        :
    ElevatedButton(
      onPressed: () {
        showModalBottomSheet(
            isDismissible: true,
            enableDrag: false,
            context: context,
            builder: (context) => Scaffold(
                  appBar: AppBar(
                    title: Text("Chapter"),
                    actions: [
                      role == 'admin'
                          ?
                      AddChapterForm(id: widget.id) : Container(),
                    ],
                  ),
                  body: ListView(
                    children: widget.chapter.map((e) {
                      var chapterMap = e as Map<String, dynamic>;
                      var chapTitle =
                          "chapter " + chapterMap['chapter'].toString();
                      return ListTile(
                          leading: Icon(Icons.book),
                          title: ElevatedButton(
                              child: Text(chapTitle),
                              onPressed: () async {
                                await dataSource.addOrUpdateReadingStatus(
                                    widget.user_id,
                                    widget.id,
                                    chapterMap['chapter'].toString());

                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => MangaImageList(
                                      chapterMap['content'] as List<dynamic>,
                                      chapTitle,
                                      chapterMap['chapter'].toString(),
                                      widget.id,
                                    ),
                                  ),
                                );
                              })
                          // Text('chapter ' + chapterMap['chapter'].toString()),
                          );
                    }).toList(),
                  ),
                ));
      },
      child: Text("All Chapter"),
    );
  }
}
