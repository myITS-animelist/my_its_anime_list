import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class FormUplaodManga extends StatefulWidget {
  const FormUplaodManga({super.key});

  @override
  State<FormUplaodManga> createState() => _FormUplaodMangaState();
}

class _FormUplaodMangaState extends State<FormUplaodManga> {

  String imageUrl = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Upload Manga"),
          centerTitle: true,
        ),
        body: Column(
          children: [
            TextFormField(),
            TextFormField(),
            IconButton(
              onPressed: () async {
                ImagePicker imagePicker = ImagePicker();

                XFile? file =
                    await imagePicker.pickImage(source: ImageSource.gallery);

                var pathfile = file?.path;

                if (file == null) {
                  return;
                }
                String uniqueFileName =
                    DateTime.now().millisecondsSinceEpoch.toString();

                // upload image to firebase_storage
                Reference referenceRoot = FirebaseStorage.instance.ref();
                Reference referenceDirImages = referenceRoot.child('images');

                // create reference for the image to be stored
                Reference referenceImageToUpload =
                    referenceDirImages.child(uniqueFileName);

                // upload the image to the firebase storage
                try {
                  await referenceImageToUpload.putFile(File(file!.path));
                  imageUrl = await referenceImageToUpload.getDownloadURL();
                } catch(error) {
                  // handle error
                }
              },
              icon: const Icon(Icons.add),
            )
          ],
        ));
  }
}
