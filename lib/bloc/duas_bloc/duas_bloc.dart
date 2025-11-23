import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'duas_event.dart';
part 'duas_state.dart';

class DuasBloc extends Bloc<DuasEvent, DuasState> {
  static const List<String> duaCategories = [
    'Morning & Evening',
    'Prayer',
    'Healing',
    'Protection',
    'Sustenance',
    'Family',
    'Knowledge',
    'Forgiveness',
  ];

  static final List<Dua> allDuas = [
    Dua(
      id: 1,
      arabicText: 'اللَّهُمَّ إِنِّي أَسْأَلُكَ الْعَفْوَ وَالْعَافِيَةَ',
      englishTranslation: 'O Allah, I ask You for pardon and well-being',
      russianTranslation: 'О Аллах, я прошу у Тебя прощения и благополучия',
      category: 'Prayer',
      benefits: 'Seeking forgiveness and blessings',
    ),
    Dua(
      id: 2,
      arabicText: 'رَبَّنَا آتِنَا فِي الدُّنْيَا حَسَنَةً',
      englishTranslation: 'Our Lord, give us good in this world',
      russianTranslation: 'Наш Господь, даруй нам добро в этой жизни',
      category: 'Sustenance',
      benefits: 'Asking for blessings in worldly life',
    ),
    Dua(
      id: 3,
      arabicText: 'اللَّهُمَّ أَنْتَ سَلَامٌ وَمِنْكَ السَّلَامُ',
      englishTranslation: 'O Allah, You are Peace and from You is all peace',
      russianTranslation: 'О Аллах, Ты - Мир и от Тебя исходит мир',
      category: 'Protection',
      benefits: 'Seeking peace and security',
    ),
    Dua(
      id: 4,
      arabicText: 'رَبِّ اشْرَحْ لِي صَدْرِي وَيَسِّرْ لِي أَمْرِي',
      englishTranslation: 'My Lord, open my chest for me and ease my affair',
      russianTranslation: 'Мой Господь, раскрой мне грудь и облегчи мне мое дело',
      category: 'Knowledge',
      benefits: 'For clarity of mind and ease in tasks',
    ),
    Dua(
      id: 5,
      arabicText: 'اللَّهُمَّ اهْدِنَا الصِّرَاطَ الْمُسْتَقِيمَ',
      englishTranslation: 'O Allah, guide us to the straight path',
      russianTranslation: 'О Аллах, направь нас на прямой путь',
      category: 'Prayer',
      benefits: 'Seeking divine guidance',
    ),
    Dua(
      id: 6,
      arabicText: 'اللَّهُمَّ صَلِّ وَسَلِّمْ عَلَى نَبِيِّنَا مُحَمَّدٍ',
      englishTranslation: 'O Allah, bless and grant peace to our Prophet Muhammad',
      russianTranslation: 'О Аллах, благослови и даруй мир пророку Мухаммаду',
      category: 'Prayer',
      benefits: 'Honoring the Prophet Muhammad',
    ),
    Dua(
      id: 7,
      arabicText: 'اللَّهُمَّ عَافِنِي فِي بَدَنِي',
      englishTranslation: 'O Allah, grant me health in my body',
      russianTranslation: 'О Аллах, даруй мне здоровье в моем теле',
      category: 'Healing',
      benefits: 'For physical health and healing',
    ),
    Dua(
      id: 8,
      arabicText: 'اللَّهُمَّ أَصْلِحْ لِي دِينِي الَّذِي هُوَ عِصْمَةُ أَمْرِي',
      englishTranslation: 'O Allah, set right my religion which is the protection of my affairs',
      russianTranslation: 'О Аллах, исправь мне мою религию, которая есть защита моих дел',
      category: 'Prayer',
      benefits: 'Strengthening faith and piety',
    ),
    Dua(
      id: 9,
      arabicText: 'اللَّهُمَّ احْفَظْنِي مِنْ بَيْنِ يَدَيَّ وَمِنْ خَلْفِي',
      englishTranslation: 'O Allah, protect me from before me and behind me',
      russianTranslation: 'О Аллах, защити меня спереди и сзади',
      category: 'Protection',
      benefits: 'Complete protection in all directions',
    ),
    Dua(
      id: 10,
      arabicText: 'اللَّهُمَّ اجْعَلْ أَوْسَعَ رِزْقِي فِي أَحَبِّ سِنِّي إِلَيَّ',
      englishTranslation: 'O Allah, make my sustenance widest at the age most beloved to me',
      russianTranslation: 'О Аллах, сделай мою пропитание достаточной в возрасте, мне наиболее дорогом',
      category: 'Sustenance',
      benefits: 'For abundant provision in life',
    ),
  ];

  DuasBloc() : super(const DuasState()) {
    on<GetDuasEvent>(_onGetDuas);
    on<GetCategoriesEvent>(_onGetCategories);
    on<SearchDuasEvent>(_onSearchDuas);
  }

  Future<void> _onGetDuas(
      GetDuasEvent event, Emitter<DuasState> emit) async {
    emit(state.copyWith(status: Status.loading));

    try {
      await Future.delayed(const Duration(milliseconds: 300));

      final duas = event.category == null
          ? allDuas
          : allDuas.where((dua) => dua.category == event.category).toList();

      emit(state.copyWith(
        duas: duas,
        selectedCategory: event.category,
        status: Status.complete,
      ));
    } catch (e) {
      emit(state.copyWith(status: Status.error));
    }
  }

  Future<void> _onGetCategories(
      GetCategoriesEvent event, Emitter<DuasState> emit) async {
    emit(state.copyWith(status: Status.loading));

    try {
      await Future.delayed(const Duration(milliseconds: 200));

      emit(state.copyWith(
        categories: duaCategories,
        status: Status.complete,
      ));
    } catch (e) {
      emit(state.copyWith(status: Status.error));
    }
  }

  Future<void> _onSearchDuas(
      SearchDuasEvent event, Emitter<DuasState> emit) async {
    emit(state.copyWith(status: Status.loading));

    try {
      await Future.delayed(const Duration(milliseconds: 300));

      final query = event.query.toLowerCase();
      final results = allDuas
          .where((dua) =>
              dua.arabicText.toLowerCase().contains(query) ||
              dua.englishTranslation.toLowerCase().contains(query) ||
              dua.russianTranslation.toLowerCase().contains(query) ||
              dua.category.toLowerCase().contains(query))
          .toList();

      emit(state.copyWith(
        duas: results,
        status: Status.complete,
      ));
    } catch (e) {
      emit(state.copyWith(status: Status.error));
    }
  }
}
