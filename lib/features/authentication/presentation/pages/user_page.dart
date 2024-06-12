import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_its_anime_list/features/authentication/presentation/pages/auth/sign_in_page.dart';
import '../bloc/authentication/auth_bloc.dart';

class UserPage extends StatefulWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  late User user;
  String? name;
  String? profileImageUrl;

  @override
  void initState() {
    super.initState();
    fetchUser();
  }

  Future<void> fetchUser() async {
    User currentUser = FirebaseAuth.instance.currentUser!;
    DocumentSnapshot doc = await FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser.uid)
        .get();
    setState(() {
      user = currentUser;
      name = doc['name'];
      profileImageUrl = doc['profileImageUrl'];
    });
  }

  Future<void> updateProfilePicture() async {
    final ImagePicker _picker = ImagePicker();
    XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      Reference ref = FirebaseStorage.instance
          .ref()
          .child('userProfileImages')
          .child('${user.uid}.jpg');

      await ref.putFile(File(image.path));

      String downloadUrl = await ref.getDownloadURL();

      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .update({'profileImageUrl': downloadUrl});

      setState(() {
        profileImageUrl = downloadUrl;
      });
    }
  }

  Future<void> removeProfilePicture() async {
    User currentUser = FirebaseAuth.instance.currentUser!;

    await FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser.uid)
        .update({
      'profileImageUrl': '',
    });

    setState(() {
      profileImageUrl = null;
    });
  }

  Future<void> deleteAccount(BuildContext context) async {
    User currentUser = FirebaseAuth.instance.currentUser!;

    final passwordController = TextEditingController();

    await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Enter your password'),
          content: TextField(
            controller: passwordController,
            obscureText: true,
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: Text('OK'),
              onPressed: () {
                String password = passwordController.text;
                Navigator.of(context).pop(password);
              },
            ),
          ],
        );
      },
    ).then((password) async {
      if (password != null) {
        AuthCredential credential = EmailAuthProvider.credential(
          email: currentUser.email!,
          password: password,
        );
        await currentUser.reauthenticateWithCredential(credential);

        await FirebaseFirestore.instance
            .collection('users')
            .doc(currentUser.uid)
            .delete();

        await currentUser.delete();

        BlocProvider.of<AuthBloc>(context).add(LogOutEvent());

        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const SignIn()));
      }
    });
  }

  Future<void> logoutAccount(BuildContext context) async {
    User currentUser = FirebaseAuth.instance.currentUser!;

    await FirebaseAuth.instance.signOut();

    BlocProvider.of<AuthBloc>(context).add(LogOutEvent());
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const SignIn()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Profile'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.add_a_photo),
              title: Text('Update Profile Picture'),
              onTap: updateProfilePicture,
            ),
            ListTile(
              leading: Icon(Icons.remove_circle),
              title: Text('Remove Profile Picture'),
              onTap: removeProfilePicture,
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Logout'),
              onTap: () => logoutAccount(context),
            ),
            ListTile(
              leading: Icon(Icons.delete),
              title: Text('Delete Account'),
              onTap: () => deleteAccount(context),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            if (profileImageUrl != null)
              Center(
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(profileImageUrl!),
                ),
              )
            else
              const Center(child: Icon(Icons.account_circle, size: 100)),
            const SizedBox(height: 16),
            Text(
              name ?? 'No name',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
