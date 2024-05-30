import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_its_anime_list/features/manga/data/models/manga_model.dart';

abstract class RemoteDataSource {
  Stream<List<MangaModel>> getMangaList();
  Stream<MangaModel> getMangaDetail(String id);
  Future<void> createManga(Map<String, dynamic> manga);
  Future<void> addChapter(String id, Map<String, dynamic> chapter);
  Future<void> addContentToChapter(String mangaId, Map<String, dynamic> newContent, int chapterNum);
}

class RemoteDataSourceImpl implements RemoteDataSource {
  final FirebaseFirestore firestore;

  RemoteDataSourceImpl(this.firestore);

  @override
  Stream<List<MangaModel>> getMangaList() {
    return firestore.collection('manga').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => MangaModel.fromJson(doc.data() as Map<String, dynamic>)).toList();
    });
  }

  @override
  Stream<MangaModel> getMangaDetail(String id) {
    return firestore.collection('manga').doc(id).snapshots().map((snapshot) {
      return MangaModel.fromJson(snapshot.data() as Map<String, dynamic>);
    });
  }

  @override
  Future<void> createManga(Map<String, dynamic> manga) async {
    Map<String, dynamic> data = {
      'id': manga['id'],
      'title': manga['title'],
      'author': manga['author'],
      'sinopsis': manga['sinopsis'],
      'cover': manga['cover'],
      'status': manga['status'],
      'type': manga['type'],
      'release': manga['release'],
      'chapter': manga['chapter'],
      'genre': manga['genre'],
    };


    final snapshot = await firestore.collection('manga').add(data);
  }

  @override
  Future<void> addChapter(String id, Map<String, dynamic> chapter) async {
    final snapshot = await firestore.collection('manga').doc(id).update({
      'chapter': FieldValue.arrayUnion([chapter])
    });
  }

  @override
  Future<void> addContentToChapter(String mangaId, Map<String, dynamic> newContent, int chapterNum) async {
    // Reference to the Firestore collection and document
    CollectionReference mangaCollection = FirebaseFirestore.instance.collection('manga');
    
    // Fetch the document
    DocumentSnapshot docSnapshot = await mangaCollection.doc(mangaId).get();

    if (docSnapshot.exists) {
      // Get the current chapter data
      Map<String, dynamic>? data = docSnapshot.data() as Map<String, dynamic>?;
      List<dynamic> chapters = data?['chapter'] ?? [];
      
      // Find the chapter with chapter: 1
      for (int i = 0; i < chapters.length; i++) {
        if (chapters[i]['chapter'] == chapterNum) {
          // Add new content to the chapter's content array
          chapters[i]['content'].add(newContent);
          break;
        }
      }

      // Update the document with the new chapters array
      await mangaCollection.doc(mangaId).update({'chapter': chapters});
    } else {
      print("Document does not exist!");
    }
  }
}
