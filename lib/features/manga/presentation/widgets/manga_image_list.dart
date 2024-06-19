import 'package:flutter/material.dart';
import 'package:my_its_anime_list/features/manga/presentation/widgets/add_image_chapter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MangaImageList extends StatefulWidget {
  final List<dynamic> content;
  final String chapTitle;
  final String chapNumber;
  final String id;

  const MangaImageList(this.content, this.chapTitle, this.chapNumber, this.id,
      {super.key});

  @override
  State<MangaImageList> createState() => _MangaImageListState();
}

class _MangaImageListState extends State<MangaImageList> {

  String? role;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();

    SharedPreferences.getInstance().then((prefs) {
      setState(() {
        role = prefs.getString('role')!;
        isLoading = false;
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    return 
    isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        :
    Scaffold(
        appBar: AppBar(
          title: Text(widget.chapTitle),
          actions: [
            role == 'admin'
                ?
            AddImageChapter(id: widget.id, chapNumber: widget.chapNumber): Container(),
          ],
        ),
        body: ListView(
          children: widget.content.map((e) {
            var contentMap = e as Map<String, dynamic>;
            return Image.network(contentMap['imgUrl']);
          }).toList(),
        ));
  }
}
