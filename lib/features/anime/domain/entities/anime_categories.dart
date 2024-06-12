import 'package:equatable/equatable.dart';

class AnimeCategoriesEntity extends Equatable {
  final String title;
  final String rankingType;

  const AnimeCategoriesEntity({
    required this.title,
    required this.rankingType,
  });

  @override
  List<Object?> get props => [title, rankingType];
}