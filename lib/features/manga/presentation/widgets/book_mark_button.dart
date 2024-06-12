import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_its_anime_list/dependency_injection.dart';
import 'package:my_its_anime_list/features/manga/domain/usecases/add_user_manga.dart';
import 'package:my_its_anime_list/features/manga/presentation/bloc/userManga/user_manga_add_bloc.dart';
import 'package:my_its_anime_list/features/manga/presentation/bloc/userManga/user_manga_add_event.dart';
import 'package:my_its_anime_list/features/manga/presentation/bloc/userManga/user_manga_add_state.dart';

class BookmarkButton extends StatefulWidget {
  final String manga_id;
  final String user_id;

  const BookmarkButton(
      {super.key, required this.manga_id, required this.user_id});

  @override
  _BookmarkButtonState createState() => _BookmarkButtonState();
}

class _BookmarkButtonState extends State<BookmarkButton> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserMangaAddBloc(sl<AddUserMangaUseCase>()),
      child: BlocConsumer<UserMangaAddBloc, UserMangaAddState>(
        listener: (context, state) {
          if (state is UserMangaAdded) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Manga added successfully!')),
            );
          }
        },
        builder: (context, state) {
          if (state is UserMangaAdding) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return IconButton(
            onPressed: () {
              BlocProvider.of<UserMangaAddBloc>(context)
                  .add(UserMangaAddEvent(widget.manga_id, widget.user_id));
            },
            icon: const Icon(Icons.bookmark),
          );
        },
      
      ),
    );
  }
}
