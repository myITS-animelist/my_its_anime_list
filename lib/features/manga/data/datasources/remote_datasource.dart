import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_its_anime_list/features/manga/data/models/manga_model.dart';
import 'package:uuid/uuid.dart';

abstract class RemoteDataSource {
  Stream<List<MangaModel>> getMangaList();
  Stream<MangaModel> getMangaDetail(String id);
  Future<void> createManga(Map<String, dynamic> manga);
  Future<void> addChapter(String id, Map<String, dynamic> chapter);
  Future<void> addContentToChapter(
      String mangaId, Map<String, dynamic> newContent, int chapterNum);
  Future<void> addImageChapter(String id, String chapNumber, XFile file);
  Future<void> addUserManga(String manga_id, String user_id);
}

class RemoteDataSourceImpl implements RemoteDataSource {
  final FirebaseFirestore firestore;

  RemoteDataSourceImpl(this.firestore);

  @override
  Stream<List<MangaModel>> getMangaList() {

    return firestore.collection('manga').snapshots().map((snapshot) {
      return snapshot.docs
          .map((doc) => MangaModel.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
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
    // generate unique id for the document
    var uuid = Uuid();

    Map<String, dynamic> data = {
      'id': uuid.v4(),
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

    print("Creating Manga with data: $data");

    await firestore.collection('manga').add(data);
  }

  @override
  Future<void> addChapter(String id, Map<String, dynamic> chapter) async {
    // final snapshot = await firestore.collection('manga').doc(id).get();

    // add query to get the document where the id is equal to the id parameter
    final snapshot =
        await firestore.collection('manga').where('id', isEqualTo: id).get();

    if (snapshot.docs.isNotEmpty) {
      final docId = snapshot.docs.first.id;
      final doc = snapshot.docs.first.data();
      List<dynamic> chapters = doc['chapter'] ?? [];

      chapters.add(chapter);

      await firestore
          .collection('manga')
          .doc(docId)
          .update({'chapter': chapters});
    } else {
      print("Document does not exist!");
    }

    print("bjirr ${snapshot.docs.first}");
  }

  @override
  Future<void> addUserManga(String manga_id, String user_id) async {
    var data = await firestore
        .collection('user_manga')
        .where('user_id', isEqualTo: user_id)
        .get();

    if (data.docs.isNotEmpty) {
      final docId = data.docs.first.id;
      final doc = data.docs.first.data();
      List<dynamic> manga = doc['manga'] ?? [];

      manga.add(manga_id);

      await firestore
          .collection('user_manga')
          .doc(docId)
          .update({'manga': manga});
    }

    Map<String, dynamic> userManga = {
      'user_id': "${user_id}",
      'manga': [manga_id],
    };

    await firestore.collection('user_manga').add(userManga);
  }

  @override
  Future<void> addImageChapter(String id, String chapNumber, XFile file) async {
    Reference referenceRoot = FirebaseStorage.instance.ref();
    Reference referenceDirImages = referenceRoot.child('images');

    String uniqueFileName = DateTime.now().millisecondsSinceEpoch.toString();

    Reference referenceImageToUpload = referenceDirImages.child(uniqueFileName);

    // define the image url
    String imageUrl = '';

    try {
      await referenceImageToUpload.putFile(File(file.path));
      imageUrl = await referenceImageToUpload.getDownloadURL();
    } catch (error) {
      // handle error
      print("Error uploading image: $error");
    }

    // add query to get the document where the id is equal to the id parameter
    final snapshot =
        await firestore.collection('manga').where('id', isEqualTo: id).get();

    if (snapshot.docs.isNotEmpty) {
      final docId = snapshot.docs.first.id;
      final doc = snapshot.docs.first.data();
      List<dynamic> chapters = doc['chapter'] ?? [];

      // Find the chapter with chapter: 1
      for (int i = 0; i < chapters.length; i++) {
        if (chapters[i]['chapter'] == chapNumber) {
          // Add new content to the chapter's content array
          chapters[i]['content'].add({'imgUrl': imageUrl});
          break;
        }
      }

      // Update the document with the new chapters array
      await firestore
          .collection('manga')
          .doc(docId)
          .update({'chapter': chapters});
    } else {
      print("Document does not exist!");
    }

    print("bjirr ${snapshot.docs.first}");
  }

  @override
  Future<void> addContentToChapter(
      String mangaId, Map<String, dynamic> newContent, int chapterNum) async {
    // Reference to the Firestore collection and document
    CollectionReference mangaCollection =
        FirebaseFirestore.instance.collection('manga');

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
