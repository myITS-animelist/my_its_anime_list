import 'package:flutter/material.dart';
import 'package:my_its_anime_list/features/manga/presentation/widgets/add_image_chapter.dart';

class MangaImageList extends StatelessWidget {
  final List<dynamic> content;
  final String chapTitle;
  final String chapNumber;
  final String id;

  const MangaImageList(this.content, this.chapTitle, this.chapNumber, this.id,
      {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(chapTitle),
          actions: [
            AddImageChapter(id: id, chapNumber: chapNumber),
          ],
        ),
        body: ListView(
          children: content.map((e) {
            var contentMap = e as Map<String, dynamic>;
            return Image.network(contentMap['imgUrl']);
          }).toList(),
        ));
  }
}
