import 'package:flutter/material.dart';
import 'package:my_its_anime_list/features/manga/data/datasources/manga_datasource.dart';
import 'package:my_its_anime_list/features/manga/presentation/widgets/list_grid_view.dart';

class MangaList extends StatefulWidget {
  final String user_id;

  const MangaList({super.key, required this.user_id});

  @override
  State<StatefulWidget> createState() => _MangaListState();
}

class _MangaListState extends State<MangaList>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin<MangaList> {
  late final TabController _tabController;
  final _tabTitles = [
    "Bookmark",
    "Last Read",
  ]; // used for both TabBar and TabBarView. Edit Carefully!!
  final MangaDataSource dataSource = MangaDataSourceImpl();
  List<Map<String, dynamic>>? bookmarkList = [];
  List<Map<String, dynamic>>? mangaLastReadList = [];

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    dataSource.getBookmarks(widget.user_id).then((value) {
      setState(() {
        bookmarkList = value;
        print("BOOKMARLIST: $bookmarkList");
        isLoading = false;
      });
    });

    dataSource.getReadingManga(widget.user_id).then((value) {
      setState(() {
        mangaLastReadList = value;
        print("LAST READ: $mangaLastReadList");
        isLoading = false;
      });
    });
  }

  void reload() {
    dataSource.getBookmarks(widget.user_id).then((value) {
      setState(() {
        bookmarkList = value;
        print("BOOKMARLIST: $bookmarkList");
        isLoading = false;
      });
    });

    dataSource.getReadingManga(widget.user_id).then((value) {
      setState(() {
        mangaLastReadList = value;
        print("LAST READ: $mangaLastReadList");
        isLoading = false;
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Column(
            children: <Widget>[
              Row(
                children: [
                  TabBar(
                    controller: _tabController,
                    isScrollable: true,
                    labelColor: Theme.of(context).colorScheme.secondary,
                    unselectedLabelColor: Theme.of(context).colorScheme.primary,
                    tabs: _tabTitles
                        .map((title) => Tab(
                              text: title,
                            ))
                        .toList(),
                  ),
               IconButton(
                icon: const Icon(Icons.refresh),
        onPressed: reload,
      ),
                ],
              ),
              // reload button
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: _tabTitles.map(
                    (title) {
                      if (title == "Bookmark") {
                        return MangaBookMark(
                            title: title, mangaList: bookmarkList!);
                      } else {
                        return MangaReadingStatus(
                          title: title,
                          mangaList: mangaLastReadList!,
                        );
                      }
                    },
                  ).toList(),
                ),
              )
            ],
          );
  }

  @override
  bool get wantKeepAlive => true;
}
