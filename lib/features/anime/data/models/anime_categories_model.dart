import 'package:my_its_anime_list/features/anime/domain/entities/anime_categories.dart';

class AnimeCategoriesModel extends AnimeCategoriesEntity {
  const AnimeCategoriesModel({
    required String title,
    required String rankingType,
  }) : super(
    title: title,
    rankingType: rankingType,
  );

  factory AnimeCategoriesModel.fromJson(Map<String, dynamic> json) {
    return AnimeCategoriesModel(
      title: json['title'],
      rankingType: json['rankingType'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'rankingType': rankingType,
    };
  }
}

const animeCategories = [
  AnimeCategoriesModel(title: 'Top Anime', rankingType: 'all'),
  AnimeCategoriesModel(title: 'Top Airing', rankingType: 'airing'),
  AnimeCategoriesModel(title: 'Top Upcoming', rankingType: 'upcoming'),
  AnimeCategoriesModel(title: 'Top TV Series', rankingType: 'tv'),
  AnimeCategoriesModel(title: 'Top OVA', rankingType: 'ova'),
  AnimeCategoriesModel(title: 'Top Movies', rankingType: 'movie'),
  AnimeCategoriesModel(title: 'Top Specials', rankingType: 'special'),
  AnimeCategoriesModel(title: 'Top Popular', rankingType: 'bypopularity'),
  AnimeCategoriesModel(title: 'Top Favorited', rankingType: 'favorite'),
];