import 'package:equatable/equatable.dart';

class AnimeEntity extends Equatable{
  final int ? id;
  final String ? title;
  final int ? rating;
  final String ? synopsis;
  final String ? poster;
  final String ? type;
  final int ? episode;
  final String ? status;
  final String ? premiered;

  const AnimeEntity({
   this.id,
   this.title,
   this.rating,
   this.synopsis,
   this.poster,
   this.type,
   this.episode,
   this.status,
   this.premiered
});

  @override
  List < Object ? > get props {
    return [
      id,
      title,
      rating,
      synopsis,
      poster,
      type,
      episode,
      status,
      premiered
    ];
  }
}