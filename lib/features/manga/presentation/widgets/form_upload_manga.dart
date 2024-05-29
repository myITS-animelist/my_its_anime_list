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
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    TextField(
                      controller: titleController,
                      autocorrect: true,
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      decoration: const InputDecoration(
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          border: OutlineInputBorder(),
                          labelText: 'title',
                          hintText: 'masukkan title'),
                      onChanged: (value) {
                        mangaData['title'] = value;
                      },
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: authorController,
                      autocorrect: true,
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      decoration: const InputDecoration(
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          border: OutlineInputBorder(),
                          labelText: 'author',
                          hintText: 'masukkan author'),
                      onChanged: (value) {
                        mangaData['author'] = value;
                      },
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: sinopsisController,
                      autocorrect: true,
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      decoration: const InputDecoration(
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          border: OutlineInputBorder(),
                          labelText: 'sinopsis',
                          hintText: 'masukkan sinopsis'),
                      onChanged: (value) {
                        mangaData['sinopsis'] = value;
                      },
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: statusController,
                      autocorrect: true,
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      decoration: const InputDecoration(
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          border: OutlineInputBorder(),
                          labelText: 'status',
                          hintText: 'masukkan status'),
                      onChanged: (value) {
                        mangaData['status'] = value;
                      },
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: typeController,
                      autocorrect: true,
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      decoration: const InputDecoration(
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          border: OutlineInputBorder(),
                          labelText: 'type',
                          hintText: 'masukkan type'),
                      onChanged: (value) {
                        mangaData['type'] = value;
                      },
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: releaseController,
                      autocorrect: true,
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      decoration: const InputDecoration(
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          border: OutlineInputBorder(),
                          labelText: 'release',
                          hintText: 'masukkan release'),
                      onChanged: (value) {
                        mangaData['release'] = value;
                      },
                    ),
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
                    IconButton(
                      onPressed: () async {
                        ImagePicker imagePicker = ImagePicker();

                        XFile? file = await imagePicker.pickImage(
                            source: ImageSource.gallery);

                        var pathfile = file?.path;

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
                              .putFile(File(file!.path));
                          imageUrl =
                              await referenceImageToUpload.getDownloadURL();
                          setState(() {
                            mangaData['cover'] = imageUrl;
                            print("mangaData['cover'] ${mangaData['cover']}");
                          });
                          print(imageUrl);
                        } catch (error) {
                          // handle error
                        }
                      },
                      icon: const Icon(Icons.add),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        // use bloc to upload manga
                        setState(() {
                          mangaData['chapter'] = chapters;
                          print("data chapter $chapters");
                          print("mangaData: ${mangaData['chapter']}");
                        });
                        context
                            .read<MangaBlocCreate>()
                            .add(CreateMangaEvent(mangaData));
                      },
                      child: const Text('Upload'),
                    )
                  ],
                ),
              );
            },
          ),
        ));
  }
}
