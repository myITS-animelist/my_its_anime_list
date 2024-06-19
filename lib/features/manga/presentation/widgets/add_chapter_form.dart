import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_its_anime_list/dependency_injection.dart';
import 'package:my_its_anime_list/features/manga/domain/usecases/add_chapter.dart';
import 'package:my_its_anime_list/features/manga/presentation/bloc/chapter/chapter_add_bloc.dart';
import 'package:my_its_anime_list/features/manga/presentation/bloc/chapter/chapter_add_event.dart';
import 'package:my_its_anime_list/features/manga/presentation/bloc/chapter/chapter_add_state.dart';

class AddChapterForm extends StatefulWidget {
  final String id;

  const AddChapterForm({super.key, required this.id});

  @override
  State<AddChapterForm> createState() => _AddChapterFormState();
}

class _AddChapterFormState extends State<AddChapterForm> {
  late TextEditingController chapterController;

  @override
  void initState() {
    super.initState();
    print("Manga ID ${widget.id}"); // 1


    chapterController = TextEditingController();
    print("Init State: Initialized controller.");
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: ElevatedButton(
      onPressed: () {
        showDialog(
            context: context,
            builder: (context) => BlocProvider(
              create: (context) => ChapterAddBloc(sl<AddChapter>()),
              child: BlocConsumer<ChapterAddBloc, ChapterAddState>(
                listener: (context, state) {
                  if (state is ChapterAdded) {
                    Navigator.pop(context);
                  }
                },
                builder: (context, state) {
                  if (state is ChapterAdding) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  return AlertDialog(
                    title: const Text("Add Chapter"),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    content: TextField(
                        controller: chapterController,
                        autocorrect: true,
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.done,
                        decoration: const InputDecoration(
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            border: OutlineInputBorder(),
                            labelText: 'Chapter',
                            hintText: 'masukkan chapter'),
                        onChanged: (value) {
                          print("Chapter: $value"); // 2
                        }),
                    actions: [
                      ElevatedButton(
                        onPressed: () {
                          BlocProvider.of<ChapterAddBloc>(context).add(
                              AddChapterEvent(
                                  widget.id,
                                  {
                                    "chapter": chapterController.text,
                                    "content": [],
                                  }));
                        },
                        child: const Text("Add"),
                      )
                    ],
                  );
                  
                },
              )
              
               
            )
        );
      },
      child: Icon(Icons.add),
    ));
  }
}
