import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_its_anime_list/features/manga/data/datasources/manga_datasource.dart';
import 'package:my_its_anime_list/features/manga/data/models/comment_model.dart';

class CommentSection extends StatefulWidget {
  final String mangaId;
  final String userId;

  CommentSection({required this.mangaId, required this.userId});

  @override
  _CommentSectionState createState() => _CommentSectionState();
}

class _CommentSectionState extends State<CommentSection> {
  final TextEditingController _commentController = TextEditingController();
  final MangaDataSource _commentDataSource = MangaDataSourceImpl();

  Future<void> _addComment() async {
    if (_commentController.text.isEmpty) return;

    await _commentDataSource.addComment(
      widget.mangaId,
      widget.userId,
      _commentController.text,
    );

    _commentController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _commentController,
            decoration: InputDecoration(
              hintText: 'Add a comment...',
              suffixIcon: IconButton(
                icon: Icon(Icons.send),
                onPressed: _addComment,
              ),
            ),
          ),
          SizedBox(height: 10),
          Expanded(
            child: StreamBuilder<List<Comment>>(
              stream: _commentDataSource.getAllComments(widget.mangaId),
              builder: (context, snapshot) {
                print("SNAPSHOTT: ${snapshot.data}");
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Comments not available.'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text('No comments found.'));
                }

                final comments = snapshot.data!;

                return ListView.builder(
                  itemCount: comments.length,
                  itemBuilder: (context, index) {
                    final comment = comments[index];
                    return ListTile(
                      title: Text(comment.userId),
                      subtitle: Text(comment.content),
                      trailing: Text(
                        comment.timestamp.toString(),
                        style: TextStyle(fontSize: 12),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
