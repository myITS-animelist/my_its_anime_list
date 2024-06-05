import 'package:flutter/material.dart';
import 'package:my_its_anime_list/features/manga/presentation/widgets/manga_image_list.dart';

class ChapterBottomSheet extends StatelessWidget {
  final List<Map<String, dynamic>> chapter;
  const ChapterBottomSheet({super.key, required this.chapter});

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
                        IconButton(
                          icon: Icon(Icons.add),
                          onPressed: (){},
                        ),
                      ],
                  ),
                  body: ListView(
                    children: chapter.map((e) {
                      var chapterMap = e as Map<String, dynamic>;
                      var chapTitle = "chapter " + chapterMap['chapter'].toString() ;
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
                              ),
                            ),
                          )
                        )
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
