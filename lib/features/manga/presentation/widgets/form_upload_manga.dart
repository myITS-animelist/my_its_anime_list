import 'dart:io';
import 'package:get_it/get_it.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_its_anime_list/dependency_injection.dart';
import 'package:my_its_anime_list/features/manga/domain/usecases/create_manga.dart';
import 'package:my_its_anime_list/features/manga/presentation/bloc/manga_bloc.dart';
import 'package:my_its_anime_list/features/manga/presentation/bloc/manga_create_bloc.dart';
import 'package:my_its_anime_list/features/manga/presentation/bloc/manga_create_state.dart';
import 'package:my_its_anime_list/features/manga/presentation/bloc/manga_create_event.dart';
import 'package:my_its_anime_list/features/manga/presentation/bloc/manga_state.dart';
import 'package:my_its_anime_list/features/manga/presentation/widgets/chapter_upload_form.dart';

class FormUplaodManga extends StatefulWidget {
  const FormUplaodManga({super.key});

  @override
  State<FormUplaodManga> createState() => _FormUplaodMangaState();
}

class _FormUplaodMangaState extends State<FormUplaodManga> {
  late Map<String, dynamic> mangaData = {
    'title': '',
    'author': '',
    'sinopsis': '',
    'cover': '',
    'status': '',
    'type': '',
    'release': '',
    'genre': [],
    'chapter': []
  };
  late List<String> genre;
  late List<Map<String, dynamic>> chapters = [];
  String imageUrl = '';
  TextEditingController titleController = TextEditingController();
  TextEditingController authorController = TextEditingController();
  TextEditingController sinopsisController = TextEditingController();
  TextEditingController statusController = TextEditingController();
  TextEditingController typeController = TextEditingController();
  TextEditingController releaseController = TextEditingController();
  TextEditingController genreController = TextEditingController();

  void _updateChapter(Map<String, dynamic> data) {
    setState(() {
      print(
        "data chapter $data",
      );
      chapters.add(data);
      mangaData['chapter'] = chapters;
      print("chapter['chapter'] $chapters");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Upload Manga"),
          centerTitle: true,
        ),
        body: BlocProvider(
          create: (context) => MangaBlocCreate(sl<CreateManga>()),
          child: BlocConsumer<MangaBlocCreate, MangaCreateState>(
            listener: (context, state) {
              if (state is MangaCreated) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Manga created successfully!')),
                );
                Navigator.pop(context);
              } else if (state is MangaCreateError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Error: ${state.message}')),
                );
              }
            },
            builder: (context, state) {
              if (state is MangaCreating) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: 
                  Center(
                    child:  Column(
                    children: [
                      TextFieldWidget(
                          textController: titleController,
                          mangaData: mangaData,
                          input: "title"),
                      const SizedBox(height: 8),
                      TextFieldWidget(
                          textController: authorController,
                          mangaData: mangaData,
                          input: 'author'),
                      const SizedBox(height: 8),
                      TextFieldWidget(
                          textController: sinopsisController,
                          mangaData: mangaData,
                          input: 'sinopsis'),
                      const SizedBox(height: 8),
                      TextFieldWidget(
                          textController: statusController,
                          mangaData: mangaData,
                          input: 'status'),
                      const SizedBox(height: 8),
                      TextFieldWidget(
                          textController: typeController,
                          mangaData: mangaData,
                          input: 'type'),
                      const SizedBox(height: 8),
                      TextFieldWidget(
                          textController: releaseController,
                          mangaData: mangaData,
                          input: 'release'),
                      ChapterUploadForm(updateChapter: _updateChapter),
                      Expanded(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: chapters.map((data) {
                              return Container(
                                margin: EdgeInsets.all(8.0),
                                padding: EdgeInsets.all(16.0),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Text('Chapter ${data['chapter']}'),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                      // show image if image have been uploaded
                      if (imageUrl.isNotEmpty)
                        Image.network(
                          imageUrl,
                          width: 100,
                          height: 100,
                        ),
                      IconButton(
                        onPressed: () async {
                          ImagePicker imagePicker = ImagePicker();

                          XFile? file = await imagePicker.pickImage(
                              source: ImageSource.gallery);
                          if (file == null) {
                            return;
                          }
                          String uniqueFileName =
                              DateTime.now().millisecondsSinceEpoch.toString();

                          Reference referenceRoot =
                              FirebaseStorage.instance.ref();
                          Reference referenceDirImages =
                              referenceRoot.child('images');

                          Reference referenceImageToUpload =
                              referenceDirImages.child(uniqueFileName);

                          try {
                            await referenceImageToUpload
                                .putFile(File(file.path));
                            imageUrl =
                                await referenceImageToUpload.getDownloadURL();
                            setState(() {
                              mangaData['cover'] = imageUrl;
                            });
                          } catch (error) {
                            // handle error
                          }
                        },
                        icon: const Icon(Icons.add),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              // use bloc to upload manga
                              setState(() {
                                mangaData['title'] = titleController.text;
                                mangaData['author'] = authorController.text;
                                mangaData['sinopsis'] = sinopsisController.text;
                                mangaData['status'] = statusController.text;
                                mangaData['type'] = typeController.text;
                                mangaData['release'] = releaseController.text;
                                mangaData['chapter'] = chapters;
                              });
                              context
                                  .read<MangaBlocCreate>()
                                  .add(CreateMangaEvent(mangaData));
                            },
                            child: const Text('Upload'),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              // delete uploaded image from firebase storage
                              if (imageUrl.isNotEmpty) {
                                Reference referenceRoot =
                                    FirebaseStorage.instance.ref();
                                Reference referenceDirImages =
                                    referenceRoot.child('images');
                                Reference referenceImageToDelete =
                                    referenceDirImages.child(imageUrl);
                                referenceImageToDelete.delete();
                              }
                              Navigator.pop(context);
                            },
                            child: const Text('Cancel'),
                          ),
                        ],
                      )
                    ],
                  ),
               )
                  ),
              );
            },
          ),
        ));
  }
}

class TextFieldWidget extends StatelessWidget {
  const TextFieldWidget({
    super.key,
    required this.textController,
    required this.mangaData,
    required this.input,
  });

  final TextEditingController textController;
  final Map<String, dynamic> mangaData;
  final String input;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: textController,
      autocorrect: true,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          border: const OutlineInputBorder(),
          labelText: input,
          hintText: 'masukkan $input'),
      onChanged: (value) {
        mangaData[input] = value;
      },
    );
  }
}
