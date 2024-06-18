import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:my_its_anime_list/features/anime_2/models/anime_node.dart';

class BookmarksProvider with ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final List<AnimeNode> _bookmarkedAnimes = [];

  List<AnimeNode> get bookmarkedAnimes => List.unmodifiable(_bookmarkedAnimes);

  BookmarksProvider() {
    _loadBookmarks();
  }

  Future<void> _loadBookmarks() async {
    try {
      final snapshot = await _firestore.collection('anime_details').get();
      _bookmarkedAnimes.clear();
      for (var doc in snapshot.docs) {
        _bookmarkedAnimes.add(AnimeNode.fromJson(doc.data()));
      }
      notifyListeners();
    } catch (e) {
      print('Error loading bookmarks: $e');
    }
  }

  Future<void> addBookmark(AnimeNode anime) async {
    try {
      _bookmarkedAnimes.add(anime);
      notifyListeners();
      await _firestore.collection('anime_details').add(anime.toMap());
    } catch (e) {
      print('Error adding bookmark: $e');
    }
  }

  Future<void> removeBookmark(AnimeNode anime) async {
    try {
      _bookmarkedAnimes.remove(anime);
      notifyListeners();
      final snapshot = await _firestore
          .collection('anime_details')
          .where('id', isEqualTo: anime.id)
          .get();
      for (var doc in snapshot.docs) {
        await doc.reference.delete();
      }
    } catch (e) {
      print('Error removing bookmark: $e');
    }
  }
}
