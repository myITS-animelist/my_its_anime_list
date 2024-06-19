import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:my_its_anime_list/features/manga/data/models/comment_model.dart';
import 'package:my_its_anime_list/features/manga/data/models/manga_model.dart';
import 'package:my_its_anime_list/features/manga/domain/entities/manga.dart';

abstract class MangaDataSource {
  Stream<List<MangaModel>> getMangaList();
  Future<DocumentSnapshot> fetchUser();
  Stream<List<MangaModel>> getMostPopularManga();
  Future<void> addOrUpdateReadingStatus(
      String userId, String mangaId, String currentChapter);
  Future<List<Map<String, dynamic>>> getReadingManga(String userId);
  Future<void> addBookmark(String userId, String mangaId, String title);
  Future<void> removeBookmark(String userId, String mangaId);
  Future<bool> isBookmarked(String userId, String mangaId);
  Future<List<Map<String, dynamic>>> getBookmarks(String userId);
  Future<void> updateReadCount(String mangaId);
  Stream<List<Comment>> getAllComments(String mangaId);
  Future<void> addComment(String mangaId, String userId, String content);
  Future<List<MangaModel>> searchMangaByTitle(String title);
}

class MangaDataSourceImpl implements MangaDataSource {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Stream<List<MangaModel>> getMangaList() {
    return firestore.collection('manga').snapshots().map((snapshot) {
      return snapshot.docs
          .map((doc) => MangaModel.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
    });
  }

  @override
  Future<DocumentSnapshot> fetchUser() async {
    User currentUser = FirebaseAuth.instance.currentUser!;
    DocumentSnapshot doc = await FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser.uid)
        .get();
    return doc;
  }

  @override
  Stream<List<MangaModel>> getMostPopularManga() {
    // limit to 10 most popular manga ordered by readCount
    return firestore
        .collection('manga')
        .orderBy('readCount', descending: true)
        .limit(10)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => MangaModel.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
    });
  }

  @override
  Future<void> updateReadCount(String mangaId) async {
    final mangaRef =
        firestore.collection('manga').where("id", isEqualTo: mangaId);

    final snapshot = await mangaRef.get();
    if (snapshot.docs.isNotEmpty) {
      final mangaDocId = snapshot.docs.first.id;
      final mangaDoc = snapshot.docs.first.data();

      final readCount = mangaDoc['readCount'] + 1;

      await firestore.collection('manga').doc(mangaDocId).update({
        'readCount': readCount,
      });
    }
  }

  @override
  Future<void> addOrUpdateReadingStatus(
      String userId, String mangaId, String currentChapter) async {
    await updateReadCount(mangaId);

    final userRef = FirebaseFirestore.instance
        .collection('users')
        .where('id', isEqualTo: userId);
    final snapshot = await userRef.get();
    if (snapshot.docs.isNotEmpty) {
      final userDocId = snapshot.docs.first.id;
      final readingStatusRef = FirebaseFirestore.instance
          .collection('users')
          .doc(userDocId)
          .collection('readingStatus')
          .doc(mangaId);

      await readingStatusRef.set({
        'currentChapter': currentChapter,
      }, SetOptions(merge: true));
    }
  }

  @override
  Future<List<Map<String, dynamic>>> getReadingManga(String userId) async {
    List<Map<String, dynamic>> readingManga = [];
    List<Map<String, dynamic>> mangaList = [];

    final userRef =
        firestore.collection('users').where('id', isEqualTo: userId);
    final snapshot = await userRef.get();
    if (snapshot.docs.isNotEmpty) {
      final userDocId = snapshot.docs.first.id;
      final readingStatusRef = firestore
          .collection('users')
          .doc(userDocId)
          .collection('readingStatus');

      final readingStatusSnapshot = await readingStatusRef.get();
      print("readingStatusSnapshot: ${readingStatusSnapshot.docs}");

      readingManga = readingStatusSnapshot.docs
          .map((doc) => {
                'id': doc.id,
                'currentChapter': doc['currentChapter'],
              })
          .toList();

      print("READING MANGA: $readingManga");

      for (var reading in readingManga) {
        final mangaRef =
            firestore.collection('manga').where('id', isEqualTo: reading['id']);
        print("READING ID: ${reading['id']}");
        final mangaSnapshot = await mangaRef.get();

        print("MANGA SNAPSHOT: ${mangaSnapshot.docs}");

        if (mangaSnapshot.docs.isNotEmpty) {
          print("COYYYY MASUK");
          final mangaDocId = mangaSnapshot.docs.first.id;
          
          print("MANGA DOC ID: $mangaDocId");

          final mangaDoc = mangaSnapshot.docs.first.data();

          print("MANGA DOC: $mangaDoc");

          mangaList.add({
            'id': mangaDocId,
            'title': mangaDoc['title'],
            'author': mangaDoc['author'],
            'sinopsis': mangaDoc['sinopsis'],
            'cover': mangaDoc['cover'],
            'status': mangaDoc['status'],
            'type': mangaDoc['type'],
            'chapter': mangaDoc['chapter'],
            'release': mangaDoc['release'],
            'genre': mangaDoc['genre'],
            'readCount': mangaDoc['readCount'],
            'currentChapter': reading['currentChapter'],
          });
        } else {
          print("MANGA NOT FOUND");
        }
      }

      return mangaList;
    }
    return [];
  }

  @override
  Future<void> addBookmark(String userId, String mangaId, String title) async {
    final userRef =
        firestore.collection('users').where('id', isEqualTo: userId);
    final snapshot = await userRef.get();
    print(snapshot.docs);
    if (snapshot.docs.isNotEmpty) {
      final userDocId = snapshot.docs.first.id;
      final bookmarkRef = firestore
          .collection('users')
          .doc(userDocId)
          .collection('bookmarks')
          .doc(mangaId);

      await bookmarkRef.set({
        'title': title,
      });

      print('Bookmark added');
    }
  }

  @override
  Future<void> removeBookmark(String userId, String mangaId) async {
    final userRef =
        firestore.collection('users').where('id', isEqualTo: userId);
    final snapshot = await userRef.get();
    if (snapshot.docs.isNotEmpty) {
      final userDocId = snapshot.docs.first.id;
      final bookmarkRef = firestore
          .collection('users')
          .doc(userDocId)
          .collection('bookmarks')
          .doc(mangaId);

      await bookmarkRef.delete();
    }
  }

  @override
  Future<bool> isBookmarked(String userId, String mangaId) async {
    final userRef =
        firestore.collection('users').where('id', isEqualTo: userId);
    final snapshot = await userRef.get();
    if (snapshot.docs.isNotEmpty) {
      final userDocId = snapshot.docs.first.id;
      final bookmarkRef = firestore
          .collection('users')
          .doc(userDocId)
          .collection('bookmarks')
          .doc(mangaId);

      final bookmarkSnapshot = await bookmarkRef.get();
      return bookmarkSnapshot.exists;
    }
    return false;
  }

  @override
  Future<List<Map<String, dynamic>>> getBookmarks(String userId) async {
    List<Map<String, dynamic>> bookmarks = [];
    List<Map<String, dynamic>> mangaList = [];

    final userRef =
        firestore.collection('users').where('id', isEqualTo: userId);
    final snapshot = await userRef.get();
    if (snapshot.docs.isNotEmpty) {
      final userDocId = snapshot.docs.first.id;
      final bookmarksRef =
          firestore.collection('users').doc(userDocId).collection('bookmarks');

      final bookmarksSnapshot = await bookmarksRef.get();
      print("bookmarkSnapshot: ${bookmarksSnapshot.docs}");

      bookmarks = bookmarksSnapshot.docs
          .map((doc) => {
                'id': doc.id,
                'title': doc['title'],
              })
          .toList();

      // query for get manga data

      for (var bookmark in bookmarks) {
        final mangaRef = firestore
            .collection('manga')
            .where('id', isEqualTo: bookmark['id']);
        final mangaSnapshot = await mangaRef.get();
        final mangaDocId = mangaSnapshot.docs.first.id;
        final mangaDoc = mangaSnapshot.docs.first.data();

        mangaList.add({
          'id': mangaDocId,
          'title': mangaDoc['title'],
          'author': mangaDoc['author'],
          'sinopsis': mangaDoc['sinopsis'],
          'cover': mangaDoc['cover'],
          'status': mangaDoc['status'],
          'type': mangaDoc['type'],
          'chapter': mangaDoc['chapter'],
          'release': mangaDoc['release'],
          'genre': mangaDoc['genre'],
          'readCount': mangaDoc['readCount'],
        });
      }

      return mangaList;
    }
    return [];
  }

  @override
  Stream<List<Comment>> getAllComments(String mangaId) {
    final mangaRef =
        firestore.collection('manga').where("id", isEqualTo: mangaId);

    return mangaRef.snapshots().asyncExpand((snapshot) {
      if (snapshot.docs.isNotEmpty) {
        final mangaDocId = snapshot.docs.first.id;
        print('mangaDocId: $mangaDocId');
        final commentsRef = firestore
            .collection('manga')
            .doc(mangaDocId)
            .collection('comments')
            .orderBy('timestamp', descending: true);
        print('commentsRef: $commentsRef');

        return commentsRef.snapshots().map((snapshot) {
          print("snapshot.docs ${snapshot.docs.first.data()}");
          return snapshot.docs.map((doc) {
            print("doc.data() ${doc.data()}");
            print(
                "Comment.fromJson(doc.data()) ${Comment.fromJson(doc.data())}");
            return Comment.fromJson(doc.data());
          }).toList();
        });
      } else {
        print('No comments');
        return Stream.value([]);
      }
    });
  }

  @override
  Future<void> addComment(String mangaId, String userId, String content) async {
    final mangaRef =
        firestore.collection('manga').where("id", isEqualTo: mangaId);
    final snapshot = await mangaRef.get();

    if (snapshot.docs.isNotEmpty) {
      final mangaDocId = snapshot.docs.first.id;
      final commentsRef =
          firestore.collection('manga').doc(mangaDocId).collection('comments');

      DateTime now = DateTime.now();

      // Format the date using intl package
      String formattedDate = DateFormat('yyyy-MM-dd').format(now);

      await commentsRef.add({
        'userId': userId,
        'content': content,
        'timestamp': formattedDate,
      });
    }
  }

  @override
  Future<List<MangaModel>> searchMangaByTitle(String title) async {
    final snapshot = await FirebaseFirestore.instance
        .collection('manga')
        .where('title', isGreaterThanOrEqualTo: title)
        .where('title', isLessThan: title + 'z')
        .get();
    print("snapshot.docs search ${snapshot.docs}");

    return snapshot.docs.map((doc) {
      print("doc.data() search ${doc.data()}");
      return MangaModel.fromJson(doc.data() as Map<String, dynamic>);
    }).toList();
  }
}
