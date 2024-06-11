
import 'package:equatable/equatable.dart';

abstract class ImageChapterAddState extends Equatable {
  const ImageChapterAddState();
  
  @override
  List<Object> get props => [];
}

class ImageChapterAdd extends ImageChapterAddState {
  const ImageChapterAdd();

  @override
  List<Object> get props => [];
}

class ImageChapterAdding extends ImageChapterAddState {
  const ImageChapterAdding();

  @override
  List<Object> get props => [];
}

class ImageChapterAdded extends ImageChapterAddState {
  const ImageChapterAdded();

  @override
  List<Object> get props => [];
}

class ImageChapterError extends ImageChapterAddState {
  final String message;

  const ImageChapterError(this.message);

  @override
  List<Object> get props => [message];
}

class ImageChapterEmpty extends ImageChapterAddState {
  const ImageChapterEmpty();

  @override
  List<Object> get props => [];
}



