import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:my_its_anime_list/features/authentication/presentation/pages/user_page.dart';
import 'package:my_its_anime_list/features/manga/presentation/pages/manga_home_page.dart';
import 'package:my_its_anime_list/features/manga/presentation/pages/manga_list_page.dart';
import 'package:my_its_anime_list/features/manga/presentation/pages/manga_search_page.dart';
import 'package:my_its_anime_list/features/manga/presentation/widgets/manga_list_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MangaPage extends StatefulWidget {
  const MangaPage({super.key});

  @override
  State<MangaPage> createState() => MangaPageState();
}

class MangaPageState extends State<MangaPage> {
  int _navSelectedIndex = 1;
  late PageController _pageController;
  late User user;
  String? name;
  String? user_id;
  String? profileImageUrl;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchUser();
    _pageController = PageController(initialPage: _navSelectedIndex);
  }

  Future<void> fetchUser() async {
    User currentUser = FirebaseAuth.instance.currentUser!;
    DocumentSnapshot doc = await FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser.uid)
        .get();
    setState(() {
      user = currentUser;
      name = doc['name'];
      user_id = doc['id'];
      profileImageUrl = doc['profileImageUrl'];
      isLoading = false;

      // add role to shared preferences
      
    });

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('role', doc['role']);
  }

  @override
  Widget build(BuildContext context) {
    return 
    isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        :
    Scaffold(
      extendBody: true,
      resizeToAvoidBottomInset: false,
      // AppBar on top
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const UserPage(),
                ),
              );
            },
            icon: Hero(
              tag: "profileImage",
              child: CircleAvatar(
                radius: 15,
                backgroundImage: NetworkImage(profileImageUrl ?? ''),
              ),
            )),
        title: Text(
          "ฅᨐฅ",
          style: TextStyle(
            fontSize: 20,
            color: Theme.of(context).colorScheme.onBackground.withOpacity(0.5),
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              showSearch(
                context: context,
                delegate: MangaSearchPageDelegate(),
              );
            },
            icon: const Icon(Icons.search),
          )
        ],
      ),

      // Main Content
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children:  <Widget>[
          const MangaListPage(),
          // AnimeList(),
          // HomeFeed(),
          MangaList(user_id: user_id!),
        ],
      ),

      // Bottom Navogation Bar Material 3 design
      bottomNavigationBar: Container(
        margin: const EdgeInsets.fromLTRB(85, 0, 85, 30),
        height: 65,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: NavigationBar(
            indicatorColor: Theme.of(context).colorScheme.primary,
            selectedIndex: _navSelectedIndex,
            labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
            onDestinationSelected: (int index) {
              setState(() {
                _navSelectedIndex = index;
                _pageController.jumpToPage(index);
              });
            },
            destinations: const <Widget>[
              NavigationDestination(
                icon: Icon(Icons.tv_outlined),
                label: "Anime",
              ),
              NavigationDestination(
                icon: Icon(Icons.home_outlined),
                label: "Home",
              ),
              NavigationDestination(
                icon: Icon(Icons.book_outlined),
                label: "Manga",
              ),
            ],
          ),
        ),
      ),
    );
    ;
  }
}
