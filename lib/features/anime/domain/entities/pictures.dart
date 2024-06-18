import 'package:equatable/equatable.dart';

class PictureEntity extends Equatable {
  final String medium;
  final String large;

  const PictureEntity({
    required this.medium,
    required this.large,
  });

  @override
  List<Object?> get props => [medium, large];
}