
import 'package:equatable/equatable.dart';

abstract class ChapterAddState extends Equatable {
  const ChapterAddState();
  
  @override
  List<Object> get props => [];
}

class ChapterAdd extends ChapterAddState {
  const ChapterAdd();

  @override
  List<Object> get props => [];
}

class ChapterAdding extends ChapterAddState {
  const ChapterAdding();

  @override
  List<Object> get props => [];
}

class ChapterAdded extends ChapterAddState {
  const ChapterAdded();

  @override
  List<Object> get props => [];
}

class ChapterAddError extends ChapterAddState {
  final String message;

  const ChapterAddError(this.message);

  @override
  List<Object> get props => [message];
}

class ChapterAddEmpty extends ChapterAddState {
  const ChapterAddEmpty();

  @override
  List<Object> get props => [];
}



