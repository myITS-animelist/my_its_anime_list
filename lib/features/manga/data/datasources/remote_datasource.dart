import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_its_anime_list/features/manga/data/models/manga_model.dart';

abstract class RemoteDataSource {
  Future<List<MangaModel>> getMangaList();
  Future<MangaModel> getMangaDetail(String id);
  Future<void> createManga(Map<String, dynamic> manga);
}

class RemoteDataSourceImpl implements RemoteDataSource {
  final FirebaseFirestore firestore;

  RemoteDataSourceImpl(this.firestore);

  @override
  Future<List<MangaModel>> getMangaList() async {
    final snapshot = await firestore.collection('manga').get();
    print(snapshot);
    return snapshot.docs.map((doc) => MangaModel.fromJson(doc.data())).toList();
  }

  @override
  Future<MangaModel> getMangaDetail(String id) async {
    final snapshot = await firestore.collection('manga').doc(id).get();
    return MangaModel.fromJson(snapshot.data()!);
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
}
