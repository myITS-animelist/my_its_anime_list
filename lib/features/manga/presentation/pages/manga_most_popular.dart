import 'package:flutter/material.dart';
import 'package:my_its_anime_list/features/manga/data/datasources/manga_datasource.dart';
import 'package:my_its_anime_list/features/manga/data/models/manga_model.dart';
import 'package:my_its_anime_list/features/manga/domain/entities/manga.dart';
import 'package:my_its_anime_list/features/manga/presentation/pages/manga_detail_page.dart';
import 'package:my_its_anime_list/features/manga/presentation/pages/product_detail_screen.dart';

class MangaMostPopular extends StatefulWidget {
  const MangaMostPopular({super.key});

  @override
  State<MangaMostPopular> createState() => MangaMostPopularState();
}

class MangaMostPopularState extends State<MangaMostPopular> {
  final MangaDataSource mangaDataSource = MangaDataSourceImpl();
  String? role;
  
  
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start, 
      children: [
      Padding(
        padding: const EdgeInsets.all(5.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Most popular',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 0, 0, 0),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 0, 0, 0),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.grey),
              ),
              child: TextButton(
                onPressed: () {
                  // Navigator.push(context,
                  //     MaterialPageRoute(builder: (context) => Seeall()));
                },
                child: Text(
                  'See all',
                  style: TextStyle(
                    color: Color.fromARGB(255, 255, 255, 255),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      Container(
          margin: EdgeInsets.only(top: 4),
          height: 220,
          width: 380,
          child: StreamBuilder<List<MangaModel>>(
            stream: mangaDataSource.getMostPopularManga(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Center(child: Text('No manga available'));
              } else {
                return _buildMostPopularManga(context, snapshot.data!);
              }
            },
          )
        )
    ]);
  }

  Widget _buildMostPopularManga(BuildContext context, List<MangaModel> mangalist) {
  return  ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: mangalist.length,
                    itemBuilder: (BuildContext context, int index) {
                      MangaModel manga = mangalist[index];
                       MangaEntity mangaEntity = MangaEntity(
                        id: manga.id,
                        sinopsis: manga.sinopsis,
                          status: manga.status,
                        author: manga.author,
                        title: manga.title,
                        cover: manga.cover,
                        readCount: manga.readCount,
                        genre: manga.genre,
                        chapter: manga.chapter,
                        type: manga.type,
                        release: manga.release,
                      );

                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                               
                                return  MangaDetailPage(manga: mangaEntity);
                              }
                            ),
                          );
                        },
                        child: Container(
                          margin: EdgeInsets.all(8),
                          width: 100,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(14),
                                  child: Image(
                                    image: NetworkImage(manga.cover),
                                    fit: BoxFit.cover,
                                    width: 100,
                                    height: 150,
                                  ),
                                ),
                              ),
                              SizedBox(height: 5),
                              Text(
                                manga.title,
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(height: 5),
                              Text(
                                'readCount : ${manga.readCount}',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey[600],
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
  }
}


