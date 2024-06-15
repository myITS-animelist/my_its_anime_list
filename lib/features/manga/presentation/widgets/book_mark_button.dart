import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_its_anime_list/dependency_injection.dart';
import 'package:my_its_anime_list/features/manga/data/datasources/manga_datasource.dart';
import 'package:my_its_anime_list/features/manga/domain/usecases/add_user_manga.dart';
import 'package:my_its_anime_list/features/manga/presentation/bloc/userManga/user_manga_add_bloc.dart';
import 'package:my_its_anime_list/features/manga/presentation/bloc/userManga/user_manga_add_event.dart';
import 'package:my_its_anime_list/features/manga/presentation/bloc/userManga/user_manga_add_state.dart';

class BookmarkButton extends StatefulWidget {
  final String manga_id;
  final String user_id;
  final String title;

  const BookmarkButton(
      {super.key,
      required this.manga_id,
      required this.user_id,
      required this.title});

  @override
  _BookmarkButtonState createState() => _BookmarkButtonState();
}

class _BookmarkButtonState extends State<BookmarkButton> {
  bool bookmarkStatus = false;
  bool isLoading = true;
  final MangaDataSource dataSource = MangaDataSourceImpl();

  @override
  void initState() {
    super.initState();
    print("USER ID COYYY: ${widget.user_id}");
    dataSource.isBookmarked(widget.user_id, widget.manga_id).then((value) {
      setState(() {
        bookmarkStatus = value;
        print("BOOKMARK STATUS: $value");
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const CircularProgressIndicator()
        : IconButton(
            onPressed: () async {
              if (bookmarkStatus) {
                print("REMOVE BOOKMARK");
                await dataSource.removeBookmark(
                    widget.user_id, widget.manga_id);
                setState(() {
                  bookmarkStatus = false;
                });
              } else {
                print("ADD BOOKMARK");
                await dataSource.addBookmark(
                    widget.user_id, widget.manga_id, widget.title);
                setState(() {
                  bookmarkStatus = true;
                });
              }
            },
            icon: bookmarkStatus
                ? const Icon(
                    Icons.bookmark,
                    color: Color(
                      0xffFFD700,
                    ),
                  )
                : const Icon(
                    Icons.bookmark_border,
                    color: Color(
                      0xff0000FF,
                    ),
                  ),
          );
  }
}
