import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class Comment {
  final String userId;
  final String content;
  final String timestamp;

  Comment({
    required this.userId,
    required this.content,
    required this.timestamp,
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    // final timestamp = (json['timestamp'] as Timestamp).toDate();
    // String formattedDate = DateFormat('yyyy-MM-dd').format(timestamp);

    return Comment(
      userId: json['userId'],
      content: json['content'],
      timestamp: json['timestamp'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'content': content,
      'timestamp': timestamp,
    };
  }
}
