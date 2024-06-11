import 'package:flutter/material.dart';
import 'package:my_its_anime_list/features/manga/presentation/widgets/add_chapter_form.dart';
import 'package:my_its_anime_list/features/manga/presentation/widgets/manga_image_list.dart';

class ChapterBottomSheet extends StatefulWidget {
  final List<Map<String, dynamic>> chapter;
  final String id;
  const ChapterBottomSheet(
      {super.key, required this.id, required this.chapter});

  @override
  State<ChapterBottomSheet> createState() => _ChapterBottomSheetState();
}

class _ChapterBottomSheetState extends State<ChapterBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        showModalBottomSheet(
            isDismissible: true,
            enableDrag: false,
            context: context,
            builder: (context) => Scaffold(
                  appBar: AppBar(
                    title: Text("Chapter"),
                    actions: [
                       AddChapterForm(id: widget.id),
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
                              onPressed: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => MangaImageList(
                                        chapterMap['content'] as List<dynamic>,
                                        chapTitle,
                                        chapterMap['chapter'].toString(),
                                        widget.id,
                                      ),
                                    ),
                                  ))
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
