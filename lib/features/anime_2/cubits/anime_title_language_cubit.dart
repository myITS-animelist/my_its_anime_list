import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:my_its_anime_list/features/anime_2/database_helper/database_helper.dart';

typedef IsEnglish = bool;

class AnimeTitleLanguageCubit extends Cubit<IsEnglish> {
  AnimeTitleLanguageCubit() : super(false) {
    _fetchAnimeTitleLanguage();
  }

  bool get isEnglish => state;

  // Fetch initial language
  Future _fetchAnimeTitleLanguage() async {
    final isEnglish = await DatabaseHelper.instance.isEnglish;
    emit(isEnglish);
  }

  // Change Anime Title Language
  Future changeAnimeTitleLanguage({required bool isEnglish}) async {
    await DatabaseHelper.instance.setIsEnglish(isEnglish);
    emit(isEnglish);
  }
}
