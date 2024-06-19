
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:my_its_anime_list/features/manga/data/datasources/remote_datasource.dart';
// import 'package:my_its_anime_list/features/manga/data/repositories/manga_repository_impl.dart';
// import 'package:my_its_anime_list/features/manga/domain/repositories/manga_repository.dart';
// import 'package:my_its_anime_list/features/manga/domain/usecases/create_manga.dart';
// import 'package:my_its_anime_list/firebase_options.dart';

// void main() async {
//   TestWidgetsFlutterBinding.ensureInitialized();

//   await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
//   );
//   final FirebaseFirestore firestore = FirebaseFirestore.instance;

//   final RemoteDataSource remoteDataSource = RemoteDataSourceImpl(firestore);
//   final MangaRepository mangaRepository = MangaRepositoryImpl(remoteDataSource);

//   final mangas = [{
//       "id": '1',
//       "title": 'Sample Manga 1',
//       "author": 'Author 1',
//       "sinopsis": 'This is a sample sinopsis for manga 1.',
//       "cover": 'https://firebasestorage.googleapis.com/v0/b/myits-animelist.appspot.com/o/images%2Fdragonball.jpe?alt=media&token=88e0838f-b6e4-425a-ac77-c65e8bceb912',
//       "status": 'Ongoing',
//       "type": 'Shounen',
//       "chapter": [
//         {
//           'chapter': "1",
//           'content': [
//             {'imgUrl': 'https://firebasestorage.googleapis.com/v0/b/myits-animelist.appspot.com/o/images%2Fonepiece.jpg?alt=media&token=01ccdd46-7157-4dc8-a999-914ad7ed5a6d'},
//             {'imgUrl': 'https://firebasestorage.googleapis.com/v0/b/myits-animelist.appspot.com/o/images%2Fonepiece.jpg?alt=media&token=01ccdd46-7157-4dc8-a999-914ad7ed5a6d'}
//           ],
//         },
//       ],
//       "release": '2022',
//       "genre": ['Action', 'Adventure'],
//   }, 
//   {
//       "id": '2',
//       "title": 'Sample Manga 2',
//       "author": 'Author 2',
//       "sinopsis": 'This is a sample sinopsis for manga 2.',
//       "cover": 'https://firebasestorage.googleapis.com/v0/b/myits-animelist.appspot.com/o/images%2Fonepiece.jpg?alt=media&token=01ccdd46-7157-4dc8-a999-914ad7ed5a6d',
//       "status": 'Completed',
//       "type": 'Shounen',
//       "chapter": [
//         {
//           'chapter': "1",
//           'content': [
//             {'imgUrl': 'https://firebasestorage.googleapis.com/v0/b/myits-animelist.appspot.com/o/images%2Fonepiece.jpg?alt=media&token=01ccdd46-7157-4dc8-a999-914ad7ed5a6d'},
//             {'imgUrl': 'https://firebasestorage.googleapis.com/v0/b/myits-animelist.appspot.com/o/images%2Fonepiece.jpg?alt=media&token=01ccdd46-7157-4dc8-a999-914ad7ed5a6d'}
//           ],
//         },
//       ],
//       "release": '2022',
//       "genre": ['Action', 'Adventure'],
//   },
//   {
//       "id": '3',
//       "title": 'Sample Manga 3',
//       "author": 'Author 3',
//       "sinopsis": 'This is a sample sinopsis for manga 3.',
//       "cover": 'https://firebasestorage.googleapis.com/v0/b/myits-animelist.appspot.com/o/images%2Fonepiece.jpg?alt=media&token=01ccdd46-7157-4dc8-a999-914ad7ed5a6d',
//       "status": 'Ongoing',
//       "type": 'Shounen',
//       "chapter": [
//         {
//           'chapter': "1",
//           'content': [
//             {'imgUrl': 'https://firebasestorage.googleapis.com/v0/b/myits-animelist.appspot.com/o/images%2Fonepiece.jpg?alt=media&token=01ccdd46-7157-4dc8-a999-914ad7ed5a6d'},
//             {'imgUrl': 'https://firebasestorage.googleapis.com/v0/b/myits-animelist.appspot.com/o/images%2Fonepiece.jpg?alt=media&token=01ccdd46-7157-4dc8-a999-914ad7ed5a6d'}
//           ],
//         },
//       ],
//       "release": '2022',
//       "genre": ['Action', 'Adventure'],
//   },
//   {
//       "id": '4',
//       "title": 'Sample Manga 4',
//       "author": 'Author 4',
//       "sinopsis": 'This is a sample sinopsis for manga 4.',
//       "cover": 'https://firebasestorage.googleapis.com/v0/b/myits-animelist.appspot.com/o/images%2Fonepiece.jpg?alt=media&token=01ccdd46-7157-4dc8-a999-914ad7ed5a6d',
//       "status": 'Completed',
//       "type": 'Shounen',
//       "chapter": [
//         {
//           'chapter': "1",
//           'content': [
//             {'imgUrl': 'https://firebasestorage.googleapis.com/v0/b/myits-animelist.appspot.com/o/images%2Fonepiece.jpg?alt=media&token=01ccdd46-7157-4dc8-a999-914ad7ed5a6d'},
//             {'imgUrl': 'https://firebasestorage.googleapis.com/v0/b/myits-animelist.appspot.com/o/images%2Fonepiece.jpg?alt=media&token=01ccdd46-7157-4dc8-a999-914ad7ed5a6d'}
//           ],
//         },
//       ],
//       "release": '2022',
//       "genre": ['Action', 'Adventure'],
//   },
//   {
//       "id": '5',
//       "title": 'Sample Manga 5',
//       "author": 'Author 5',
//       "sinopsis": 'This is a sample sinopsis for manga 5.',
//       "cover": 'https://firebasestorage.googleapis.com/v0/b/myits-animelist.appspot.com/o/images%2Fonepiece.jpg?alt=media&token=01ccdd46-7157-4dc8-a999-914ad7ed5a6d',
//       "status": 'Ongoing',
//       "type": 'Shounen',
//       "chapter": [
//         {
//           'chapter': "1",
//           'content': [
//             {'imgUrl': 'https://firebasestorage.googleapis.com/v0/b/myits-animelist.appspot.com/o/images%2Fonepiece.jpg?alt=media&token=01ccdd46-7157-4dc8-a999-914ad7ed5a6d'},
//             {'imgUrl': 'https://firebasestorage.googleapis.com/v0/b/myits-animelist.appspot.com/o/images%2Fonepiece.jpg?alt=media&token=01ccdd46-7157-4dc8-a999-914ad7ed5a6d'}
//           ],
//         },
//       ],
//       "release": '2022',
//       "genre": ['Action', 'Adventure'],
//   },
//   {
//       "id": '6',
//       "title": 'Sample Manga 6',
//       "author": 'Author 6',
//       "sinopsis": 'This is a sample sinopsis for manga 6.',
//       "cover": 'https://firebasestorage.googleapis.com/v0/b/myits-animelist.appspot.com/o/images%2Fonepiece.jpg?alt=media&token=01ccdd46-7157-4dc8-a999-914ad7ed5a6d',
//       "status": 'Completed',
//       "type": 'Shounen',
//       "chapter": [
//         {
//           'chapter': "1",
//           'content': [
//             {'imgUrl': 'https://firebasestorage.googleapis.com/v0/b/myits-animelist.appspot.com/o/images%2Fonepiece.jpg?alt=media&token=01ccdd46-7157-4dc8-a999-914ad7ed5a6d'},
//             {'imgUrl': 'https://firebasestorage.googleapis.com/v0/b/myits-animelist.appspot.com/o/images%2Fonepiece.jpg?alt=media&token=01ccdd46-7157-4dc8-a999-914ad7ed5a6d'}
//           ],
//         },
//       ],
//       "release": '2022',
//       "genre": ['Action', 'Adventure'],
//   },
//   {
//       "id": '7',
//       "title": 'Sample Manga 7',
//       "author": 'Author 7',
//       "sinopsis": 'This is a sample sinopsis for manga 7.',
//       "cover": 'https://firebasestorage.googleapis.com/v0/b/myits-animelist.appspot.com/o/images%2Fonepiece.jpg?alt=media&token=01ccdd46-7157-4dc8-a999-914ad7ed5a6d',
//       "status": 'Ongoing',
//       "type": 'Shounen',
//       "chapter": [
//         {
//           'chapter': "1",
//           'content': [
//             {'imgUrl': 'https://firebasestorage.googleapis.com/v0/b/myits-animelist.appspot.com/o/images%2Fonepiece.jpg?alt=media&token=01ccdd46-7157-4dc8-a999-914ad7ed5a6d'},
//             {'imgUrl ': 'https://firebasestorage.googleapis.com/v0/b/myits-animelist.appspot.com/o/images%2Fonepiece.jpg?alt=media&token=01ccdd46-7157-4dc8-a999-914ad7ed5a6d'}
//           ],
//         },
//       ],
//       "release": '2022',
//       "genre": ['Action', 'Adventure'],
//   },
//   {
//       "id": '8',
//       "title": 'Sample Manga 8',
//       "author": 'Author 8',
//       "sinopsis": 'This is a sample sinopsis for manga 8.',
//       "cover": 'https://firebasestorage.googleapis.com/v0/b/myits-animelist.appspot.com/o/images%2Fonepiece.jpg?alt=media&token=01ccdd46-7157-4dc8-a999-914ad7ed5a6d',
//       "status": 'Completed',
//       "type": 'Shounen',
//       "chapter": [
//         {
//           'chapter': "1",
//           'content': [
//             {'imgUrl': 'https://firebasestorage.googleapis.com/v0/b/myits-animelist.appspot.com/o/images%2Fonepiece.jpg?alt=media&token=01ccdd46-7157-4dc8-a999-914ad7ed5a6d'},
//             {'imgUrl': 'https://firebasestorage.googleapis.com/v0/b/myits-animelist.appspot.com/o/images%2Fonepiece.jpg?alt=media&token=01ccdd46-7157-4dc8-a999-914ad7ed5a6d'}
//           ],
//         },
//       ],
//       "release": '2022',
//       "genre": ['Action', 'Adventure'],
//   },
//   {
//       "id": '9',
//       "title": 'Sample Manga 9',
//       "author": 'Author 9',
//       "sinopsis": 'This is a sample sinopsis for manga 9.',
//       "cover": 'https://firebasestorage.googleapis.com/v0/b/myits-animelist.appspot.com/o/images%2Fonepiece.jpg?alt=media&token=01ccdd46-7157-4dc8-a999-914ad7ed5a6d',
//       "status": 'Ongoing',
//       "type": 'Shounen',
//       "chapter": [
//         {
//           'chapter': "1",
//           'content': [
//             {'imgUrl': 'https://firebasestorage.googleapis.com/v0/b/myits-animelist.appspot.com/o/images%2Fonepiece.jpg?alt=media&token=01ccdd46-7157-4dc8-a999-914ad7ed5a6d'},
//             {'imgUrl': 'https://firebasestorage.googleapis.com/v0/b/myits-animelist.appspot.com/o/images%2Fonepiece.jpg?alt=media&token=01ccdd46-7157-4dc8-a999-914ad7ed5a6d'}
//           ],
//         },
//       ],
//       "release": '2022',
//       "genre": ['Action', 'Adventure'],
//   },
//   ];

//   final CreateManga createManga = CreateManga(mangaRepository);

//   for (var manga in mangas) {
//     await createManga.execute(manga);
//   }  
// }