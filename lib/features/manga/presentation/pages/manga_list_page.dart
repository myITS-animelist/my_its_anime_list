import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:my_its_anime_list/features/manga/data/datasources/manga_datasource.dart';
import 'package:my_its_anime_list/features/manga/data/models/manga_model.dart';
import 'package:my_its_anime_list/features/manga/presentation/pages/manga_detail_page.dart';
import 'package:my_its_anime_list/features/manga/presentation/pages/manga_most_popular.dart';
import 'package:my_its_anime_list/features/manga/presentation/widgets/form_upload_manga.dart';
import 'package:my_its_anime_list/features/manga/presentation/widgets/manga_image_list.dart';

class MangaListPage extends StatefulWidget {
  const MangaListPage({super.key});

  @override
  State<MangaListPage> createState() => _MangaListPageState();
}

class _MangaListPageState extends State<MangaListPage> {
  final MangaDataSource mangaDataSource = MangaDataSourceImpl();
  String? role;

  @override
  void initState() {
    super.initState();
    mangaDataSource.fetchUser().then((value) {
      setState(() {
        role = value['role'];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<MangaModel>>(
      stream: mangaDataSource.getMangaList(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('No manga available'));
        } else {
          return _buildMangaList(context, snapshot.data!);
        }
      },
    );
  }

  Widget _buildMangaList(BuildContext context, List<MangaModel> mangalist) {
    return Column(
      children: [
        Column(
          children: [
            const MangaMostPopular(),
            SizedBox(
              height: 320,
              child: GridView.builder(
                itemCount: mangalist.length,
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 150,
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 5,
                  childAspectRatio: 0.52,
                ),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      // Handle image tap
                      print("State: $mangalist");
                      // Navigator.pushNamed(context, '/manga_detail',
                      //     arguments: mangalist[index]);

                      Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => MangaDetailPage(manga: mangalist![index])
                                    ),
                                  );
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
                                    top: Radius.circular(5)),
                                child: Image.network(
                                  mangalist[index].cover,
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                  height: 150,
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
                                    mangalist![index].type,
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
                              mangalist![index].title,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: mangalist![index]
                                  .chapter
                                  .reversed
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
                                          chapterMap['content']
                                              as List<dynamic>,
                                          "Chapter " +
                                              chapter['chapter'].toString(),
                                          chapter['chapter'].toString(),
                                          mangalist![index].id,
                                        ),
                                      ),
                                    );
                                  },
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
              ),
            ),
          ],
        ),
        Center(
            child: Container(
          height: 50,
          width: 200,
          child: role == 'admin'
              ? IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const FormUplaodManga(),
                      ),
                    );
                  },
              )
              : null,
        ))
      ],
    );
  }
}
