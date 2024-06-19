import 'package:flutter/material.dart';
import 'package:my_its_anime_list/features/manga/domain/entities/manga.dart';
import 'package:my_its_anime_list/features/manga/presentation/pages/manga_detail_page.dart';

class MangaBookMark extends StatefulWidget {
  final String title;
  final List<Map<String, dynamic>> mangaList;

  const MangaBookMark(
      {super.key, required this.title, required this.mangaList});

  @override
  State<MangaBookMark> createState() => _MangaBookMarkState();
}

class _MangaBookMarkState extends State<MangaBookMark> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.all(8.0),
        children: [
          // Use ListView.builder to build the list of MangaCard widgets
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: widget.mangaList.length,
            itemBuilder: (context, index) {
              return MangaCard(manga: widget.mangaList[index]);
            },
          ),
        ],
      ),
    );
  }
}

class MangaCard extends StatelessWidget {
  final Map<String, dynamic> manga;

  const MangaCard({Key? key, required this.manga}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {

        List<Map<String, dynamic>> mangaChapter = [];
        List<String> genres = [];

        for (var genre in manga['genre']) {
          genres.add(genre);
        }

        for (var chapter in manga['chapter']) {
          mangaChapter.add({
            'chapter': chapter['chapter'],
            'content': chapter['content'],
          });
        }

        MangaEntity mangaEnt = MangaEntity(
            id: manga['id'],
            title: manga['title'],
            author: manga['author'],
            cover: manga['cover'],
            sinopsis: manga['sinopsis'],
            chapter: mangaChapter,
            status: manga['status'],
            type: manga['type'],
            release: manga['release'],
            genre: genres,
            readCount: manga['readCount'],
          );
        // Handle onTap action here, e.g., navigate to manga details page
        // For demonstration, we'll print the manga title to the console
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => MangaDetailPage(manga: mangaEnt),
          ),
        );
      },
      child: Card(
        color: Colors.deepPurple.shade100,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        margin: EdgeInsets.symmetric(vertical: 8),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Image.network(
                manga['cover'],
                width: 80,
                height: 120,
                fit: BoxFit.cover,
              ),
              SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      manga['title'],
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 5),
                    Text(
                      manga['sinopsis'],
                      style: TextStyle(color: Colors.white70),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Icon(Icons.star, color: Colors.yellow),
                        SizedBox(width: 5),
                        Text(
                          '5', // Replace with manga['rating'] if available
                          style: TextStyle(color: Colors.white),
                        ),
                        Spacer(),
                        Icon(Icons.tv,
                            color: const Color.fromRGBO(244, 67, 54, 1)),
                        SizedBox(width: 5),
                        Text(
                          "${manga['chapter'].length}", // Assuming 'chapter' is a list
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MangaReadingStatus extends StatefulWidget {
  final String title;
  final List<Map<String, dynamic>> mangaList;

  const MangaReadingStatus(
      {super.key, required this.title, required this.mangaList});

  @override
  State<MangaReadingStatus> createState() => _MangaReadingStatusState();
}

class _MangaReadingStatusState extends State<MangaReadingStatus> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.all(8.0),
        children: [
          // Use ListView.builder to build the list of MangaCard widgets
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: widget.mangaList.length,
            itemBuilder: (context, index) {
              return MangaCardReadStatus(manga: widget.mangaList[index]);
            },
          ),
        ],
      ),
    );
  }
}

class MangaCardReadStatus extends StatelessWidget {
  final Map<String, dynamic> manga;

  const MangaCardReadStatus({super.key, required this.manga});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.deepPurple.shade100,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      margin: EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Image.network(
              manga['cover'],
              width: 80,
              height: 120,
              fit: BoxFit.cover,
            ),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    manga['title'],
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 5),
                  Text(
                    manga['sinopsis'],
                    style: TextStyle(color: Colors.white70),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.yellow),
                      SizedBox(width: 5),
                      Text(
                        '5',
                        style: TextStyle(color: Colors.white),
                      ),
                      Spacer(),
                      Icon(Icons.book,
                          color: const Color.fromRGBO(244, 67, 54, 1)),
                      SizedBox(width: 5),
                      Text(
                        "${manga['currentChapter']}",
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
