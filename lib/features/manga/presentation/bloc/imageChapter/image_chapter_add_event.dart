import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';

abstract class ImageChapterAddEventAbstract extends Equatable {
  const ImageChapterAddEventAbstract();

  @override
  List<Object> get props => [];
}

class ImageChapterAddEvent extends ImageChapterAddEventAbstract {
  final String chapter;
  final String id;
  final XFile file;

  const ImageChapterAddEvent(this.id, this.chapter, this.file);

  @override
  List<Object> get props => [id, chapter, file];
}
