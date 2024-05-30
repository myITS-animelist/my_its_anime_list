

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AddChapterForm extends StatefulWidget {
  const AddChapterForm({super.key});

  @override
  State<AddChapterForm> createState() => _AddChapterFormState();
}

class _AddChapterFormState extends State<AddChapterForm> {

  late TextEditingController chapterController;

  @override
  void initState() {
    super.initState();
    chapterController = TextEditingController();
    print("Init State: Initialized controller.");
  }

  @override
  Widget build(BuildContext context) {
    return  Center(
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
                      // setState(() {
                      //   chapter['chapter'] = value;
                      //   print("TextField onChanged: Chapter updated to $value");
                      // }
                      // );
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