
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_its_anime_list/features/manga/data/models/manga_model.dart';
import 'package:my_its_anime_list/features/manga/domain/entities/manga.dart';

abstract class MangaDataSource {
  Stream<List<MangaModel>> getMangaList();
  Future<DocumentSnapshot> fetchUser();
  Stream<List<MangaModel>> getMostPopularManga();
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
    // setState(() {
    //   user = currentUser;
    //   name = doc['name'];
    //   profileImageUrl = doc['profileImageUrl'];
    // });
    return doc;
  }

  @override
  Stream<List<MangaModel>> getMostPopularManga() {
    // limit to 10 most popular manga ordered by readCount
    return firestore.collection('manga').orderBy('readCount', descending: true).limit(10).snapshots().map((snapshot) {
      return snapshot.docs
          .map((doc) => MangaModel.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
    });
    
  }
}