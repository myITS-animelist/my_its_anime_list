import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_its_anime_list/features/anime_2/models/anime_details.dart';

class FirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> saveAnimeDetails(AnimeDetails anime) async {
    try {
      await _firestore.collection('anime_details').add(anime.toMap());
    } catch (e) {
      throw Exception('Error saving anime details: $e');
    }
  }
}
