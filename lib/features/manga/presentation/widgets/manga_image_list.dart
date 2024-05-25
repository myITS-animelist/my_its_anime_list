import 'package:flutter/material.dart';

class MangaImageList extends StatelessWidget {
  final List<dynamic> content;
  final String chapTitle;

  const MangaImageList(this.content, this.chapTitle, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(chapTitle),
      ),
      body: ListView(
        children: content.map((e) {
          var contentMap = e as Map<String, dynamic>;
          return Image.network(contentMap['imgUrl']);
        }).toList(),
      )
    );
  }
}
