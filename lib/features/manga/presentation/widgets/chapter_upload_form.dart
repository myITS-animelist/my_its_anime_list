import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ChapterUploadForm extends StatefulWidget {
  final Function(Map<String, dynamic>) updateChapter;

  const ChapterUploadForm({required this.updateChapter, super.key});

 

  @override
  State<ChapterUploadForm> createState() => _ChapterUploadFormState();
}

class _ChapterUploadFormState extends State<ChapterUploadForm> {
  late TextEditingController chapterController;
  late Map<String, dynamic> chapter;

  @override
  void initState() {
    super.initState();
    chapterController = TextEditingController();
    chapter = {
      "chapter": "",
      "content": [],
    };
    print("Init State: Initialized controller and chapter map.");
  }

  @override
  void dispose() {
    chapterController.dispose();
    super.dispose();
    print("Dispose: Controller disposed.");
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text("Add Chapter"),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            content: TextField(
                controller: chapterController,
                autocorrect: true,
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.done,
                decoration: const InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    border: OutlineInputBorder(),
                    labelText: 'Chapter',
                    hintText: 'masukkan chapter'),
                     onChanged: (value) {
                      setState(() {
                        chapter['chapter'] = value;
                        print("TextField onChanged: Chapter updated to $value");
                      });
                    },
              ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("Cancel"),
              ),
              TextButton(
                onPressed: () {
                    try {
                      print("Data before update: $chapter");
                      widget.updateChapter({
                        'chapter': chapterController.text,
                        'content': [],
                      });
                      print("Dialog: Add pressed. Chapter: $chapter");
                      Navigator.pop(context);
                    } catch (error) {
                      print("Error updating chapter: $error");
                    }
                  // Navigator.pop(context);
                },
                child: Text("Add"),
              ),
            ],
          )
        );
      }, child: Text("Add Chapter"),
    ));
  }
}
