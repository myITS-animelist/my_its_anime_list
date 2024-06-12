import 'package:flutter/material.dart';
import 'package:my_its_anime_list/features/manga/presentation/widgets/book_mark_button.dart';

class BookMark extends StatefulWidget {
  final String manga_id;
  final String user_id;

  const BookMark({super.key, required this.manga_id, required this.user_id});

  @override
  State<BookMark> createState() => _BookMarkState();
}

class _BookMarkState extends State<BookMark> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bookmark Button Demo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Add to list',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            BookmarkButton(manga_id: widget.manga_id, user_id: widget.user_id),
          ],
        ),
      ),
    );
  }
}
