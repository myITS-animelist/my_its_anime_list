import 'package:flutter/material.dart';
import 'package:my_its_anime_list/features/manga/data/datasources/manga_datasource.dart';
import 'package:my_its_anime_list/features/manga/data/models/manga_model.dart';
import 'package:my_its_anime_list/features/manga/presentation/pages/manga_detail_page.dart';
import 'package:my_its_anime_list/features/manga/presentation/pages/manga_page.dart';
import 'package:my_its_anime_list/features/manga/presentation/pages/manga_search_home_page.dart';
import 'package:my_its_anime_list/features/anime_2/screens/home_screen.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Anime Search',
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.purple,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: AnimeSearchPage(),
    );
  }
}

class AnimeSearchPage extends StatefulWidget {
  const AnimeSearchPage({super.key});

  @override
  State<AnimeSearchPage> createState() => _AnimeSearchPageState();
}

class _AnimeSearchPageState extends State<AnimeSearchPage> {
  final MangaDataSource mangaDataSource = MangaDataSourceImpl();
  TextEditingController _controller = TextEditingController();

  List<MangaModel> mangaList = [];
  String query = '';

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed
    _controller.dispose();
    super.dispose();
  }

  void clearTextField() {
    _controller.clear(); // Clears the text in the TextField
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.menu),
        title: Text('MyITS Anime List'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(),
            Text(
              'MyITS Anime List',
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: 'Enter anime name...',
                filled: true,
                fillColor: Colors.grey[800],
                prefixIcon: Icon(Icons.search, color: Colors.white),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide.none,
                ),
              ),
              onChanged: (value) {
                setState(() {
                  query = value;
                });
              },
              
              // add ontab or onpressed
              onSubmitted: (value) async {
                // query mangaDataSource.searchMangaByTitle
                List<MangaModel> mangaListSet = await mangaDataSource.searchMangaByTitle(query);
                setState(() {
                  mangaList = mangaListSet;
                });

                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => MangaSearchHome(mangaList: mangaList),
                ));
                
                clearTextField();
              },
            ),
            SizedBox(height: 20),
            Text(
              'MyITS Anime List.to - Just a better place to read manga online for free!',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SocialMediaButton(icon: Icons.share, label: 'Share'),
                SocialMediaButton(icon: Icons.message, label: 'Tweet'),
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton.icon(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => MangaPage(),
                    ));
                  },
                  icon: Icon(Icons.home, color: Colors.white),
                  label: Text('Manga', style: TextStyle(color: Colors.white)),
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.purple,
                    padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
                  ),
                ),
                SizedBox(width: 20),
                TextButton.icon(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => HomeScreen(),
                    ));
                  },
                  icon: Icon(Icons.home, color: Colors.white),
                  label: Text('Anime', style: TextStyle(color: Colors.white)),
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.purple,
                    padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
                  ),
                ),
              ],
            ),
            
            Spacer(),
          ],
        ),
      ),
    );
  }
}

class SocialMediaButton extends StatelessWidget {
  final IconData icon;
  final String label;

  SocialMediaButton({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: ElevatedButton.icon(
        onPressed: () {},
        icon: Icon(icon, color: Colors.white),
        label: Text(label, style: TextStyle(color: Colors.white)),
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
        ),
      ),
    );
  }
}
