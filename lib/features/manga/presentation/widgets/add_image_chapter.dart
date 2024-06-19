import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_its_anime_list/dependency_injection.dart';
import 'package:my_its_anime_list/features/manga/domain/usecases/add_image_chapter.dart';
import 'package:my_its_anime_list/features/manga/presentation/bloc/imageChapter/image_chapter_add_bloc.dart';
import 'package:my_its_anime_list/features/manga/presentation/bloc/imageChapter/image_chapter_add_event.dart';
import 'package:my_its_anime_list/features/manga/presentation/bloc/imageChapter/image_chapter_add_state.dart';

class AddImageChapter extends StatefulWidget {
  final String id;
  final String chapNumber;
  const AddImageChapter({super.key, required this.id, required this.chapNumber});

  @override
  State<AddImageChapter> createState() => _AddImageChapterState();
}

class _AddImageChapterState extends State<AddImageChapter> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ImageChapterAddBloc(sl<ImageChapterAddUseCase>()),
      child: BlocConsumer<ImageChapterAddBloc, ImageChapterAddState> (
        listener: (context, state) {
          if (state is ImageChapterAdded) {
            ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Image added successfully!')),
                );
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          if (state is ImageChapterAdding) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return IconButton(
            onPressed: () async {
              ImagePicker imagePicker = ImagePicker();

              XFile? file = await imagePicker.pickImage(source: ImageSource.gallery);
              if (file == null) {
                return;
              }

              BlocProvider.of<ImageChapterAddBloc>(context).add(ImageChapterAddEvent(widget.id, widget.chapNumber, file));
            },
            icon: const Icon(Icons.add),
          );
        },
      )

    );

  
  }
}
