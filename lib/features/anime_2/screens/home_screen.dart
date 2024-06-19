import 'package:flutter/material.dart';

import 'package:my_its_anime_list/features/anime_2/screens/animes_screen.dart';
import 'package:my_its_anime_list/features/anime_2/screens/categories_screen.dart';
import 'package:my_its_anime_list/features/anime_2/screens/search_screen.dart';
import 'package:my_its_anime_list/features/anime_2/screens/settings_screen.dart';
import 'package:my_its_anime_list/features/anime_2/screens/anime_bookmarks.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
    this.index,
  });

  final int? index;

  static const routeName = '/home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _destinations = [
    const NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
    const NavigationDestination(icon: Icon(Icons.search), label: 'Search'),
    const NavigationDestination(
        icon: Icon(Icons.category), label: 'Categories'),
    const NavigationDestination(icon: Icon(Icons.settings), label: 'Settings'),
    const NavigationDestination(icon: Icon(Icons.bookmark), label: 'Bookmarks')
  ];

  final _screens = const [
    AnimesScreen(),
    SearchScreen(),
    CategoriesScreen(),
    SettingsScreen(),
    BookmarksScreen()
  ];

  int _currentScreenIndex = 0;

  @override
  void initState() {
    if (widget.index != null) {
      _currentScreenIndex = widget.index!;
    }
    super.initState();
  }

  bool canPop() {
    if (_currentScreenIndex == 0) {
      return true;
    } else {
      return false;
    }
  }

  bool onPopInvoked(bool didPop) {
    if (!didPop) {
      _currentScreenIndex = 0;
      setState(() {});
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: onPopInvoked,
      canPop: canPop(),
      child: Scaffold(
        body: _screens[_currentScreenIndex],
        bottomNavigationBar: NavigationBar(
          elevation: 12,
          destinations: _destinations,
          animationDuration: const Duration(milliseconds: 200),
          backgroundColor: Theme.of(context).dialogBackgroundColor,
          selectedIndex: _currentScreenIndex,
          onDestinationSelected: (value) {
            setState(() {
              _currentScreenIndex = value;
            });
          },
        ),
      ),
    );
  }
}
