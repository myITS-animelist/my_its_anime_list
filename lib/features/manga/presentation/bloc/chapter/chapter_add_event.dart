import 'package:equatable/equatable.dart';

abstract class ChapterAddEvent extends Equatable {
  const ChapterAddEvent();

  @override
  List<Object> get props => [];
}

class AddChapterEvent extends ChapterAddEvent {
  final Map<String, dynamic> chapter;
  final String id;

  const AddChapterEvent(this.id, this.chapter);

  @override
  List<Object> get props => [id, chapter];
}
