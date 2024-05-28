import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_its_anime_list/features/manga/presentation/bloc/manga_bloc.dart';
import 'package:my_its_anime_list/features/manga/presentation/bloc/manga_state.dart';
import 'package:my_its_anime_list/features/manga/presentation/widgets/manga_image_list.dart';

class MangaHomePage extends StatelessWidget {
  const MangaHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("My ITS Anime List"),
          centerTitle: true,
        ),
        body: BlocBuilder<MangaBloc, MangaState>(builder: (context, state) {
          if (state is MangaLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is MangaLoaded) {
            return GridView.builder(
              itemCount: state.mangalist!.length,
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio: 0.47,
              ),
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    // Handle image tap
                    Navigator.pushNamed(context, '/manga_detail',
                        arguments: state.mangalist![index]);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 5,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          children: [
                            ClipRRect(
                              borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(10)),
                              child: Image.network(
                                state.mangalist![index].cover,
                                fit: BoxFit.cover,
                                width: double.infinity,
                                height: 300,
                              ),
                            ),
                            Positioned(
                              top: 10,
                              right: 10,
                              child: Container(
                                color: Colors.blue,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 4),
                                child: Text(
                                  state.mangalist![index].type,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            state.mangalist![index].title,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: state.mangalist![index].chapter.reversed
                                .take(2)
                                .map((chapter) {
                              return GestureDetector(
                                onTap: () {
                                  Map<String, dynamic> chapterMap = chapter;
                                  print(chapterMap['chapter']);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => MangaImageList(
                                        chapterMap['content'] as List<dynamic>,
                                        "Chapter " + chapter['chapter'].toString(),
                                      ),
                                    ),
                                  );
                                },
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Chapter ${chapter['chapter']}',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12),
                                    ),
                                    SizedBox(width: 8),
                                    const Text(
                                      '1 hour',
                                      style: TextStyle(
                                          color: Colors.grey, fontSize: 10),
                                    ),
                                  ],
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          } else if (state is MangaError) {
            return Center(
              child: Text(state.message),
            );
          } else {
            return const Center(
              child: Text("Unknown state"),
            );
          }
        }));
  }
}
