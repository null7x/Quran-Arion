import 'package:flutter_bloc/flutter_bloc.dart';
import 'articles_event.dart';
import 'articles_state.dart';

class ArticlesBloc extends Bloc<ArticlesEvent, ArticlesState> {
  ArticlesBloc() : super(ArticlesState()) {
    on<LoadArticlesEvent>(_onLoadArticles);
    on<SearchArticlesEvent>(_onSearchArticles);
    on<LoadArticleByCategoryEvent>(_onLoadByCategory);
    on<BookmarkArticleEvent>(_onBookmarkArticle);
    on<RemoveArticleBookmarkEvent>(_onRemoveBookmark);
    on<LoadFavoriteArticlesEvent>(_onLoadFavorites);
    on<GetArticleCategoriesEvent>(_onGetCategories);
  }

  final List<Article> _allArticles = [
    Article(
      id: 1,
      title: 'The Five Pillars of Islam',
      content: 'Understanding the foundation of Islamic faith and practice...',
      category: 'Islamic Basics',
      author: 'Dr. Ahmed Hassan',
      publishedDate: DateTime.now().subtract(const Duration(days: 5)),
      imageUrl: 'assets/images/pillars.png',
      readTimeInMinutes: 8,
      views: 1250,
    ),
    Article(
      id: 2,
      title: 'Islamic History: The Golden Age',
      content: 'Exploring the scientific and cultural achievements of early Islam...',
      category: 'History',
      author: 'Prof. Fatima Al-Rashid',
      publishedDate: DateTime.now().subtract(const Duration(days: 3)),
      imageUrl: 'assets/images/goldenage.png',
      readTimeInMinutes: 12,
      views: 890,
    ),
    Article(
      id: 3,
      title: 'Daily Life Tips for Muslims',
      content: 'Practical advice for maintaining Islamic values in modern life...',
      category: 'Lifestyle',
      author: 'Hassan Mohammed',
      publishedDate: DateTime.now().subtract(const Duration(days: 1)),
      imageUrl: 'assets/images/lifestyle.png',
      readTimeInMinutes: 6,
      views: 2100,
    ),
    Article(
      id: 4,
      title: 'Understanding Islamic Jurisprudence',
      content: 'An introduction to Fiqh and Islamic law...',
      category: 'Islamic Basics',
      author: 'Scholar Aisha Khan',
      publishedDate: DateTime.now().subtract(const Duration(days: 7)),
      imageUrl: 'assets/images/jurisprudence.png',
      readTimeInMinutes: 10,
      views: 650,
    ),
  ];

  final List<String> _categories = [
    'Islamic Basics',
    'History',
    'Lifestyle',
    'Education',
    'Health',
    'Technology',
  ];

  Future<void> _onLoadArticles(LoadArticlesEvent event, Emitter<ArticlesState> emit) async {
    emit(state.copyWith(status: ArticlesStatus.loading));
    try {
      await Future.delayed(const Duration(milliseconds: 500));
      emit(state.copyWith(
        articles: _allArticles,
        categories: _categories,
        status: ArticlesStatus.success,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: ArticlesStatus.error,
        error: e.toString(),
      ));
    }
  }

  Future<void> _onSearchArticles(SearchArticlesEvent event, Emitter<ArticlesState> emit) async {
    emit(state.copyWith(status: ArticlesStatus.loading));
    try {
      await Future.delayed(const Duration(milliseconds: 300));
      final results = _allArticles
          .where((article) =>
              article.title.toLowerCase().contains(event.query.toLowerCase()) ||
              article.content.toLowerCase().contains(event.query.toLowerCase()))
          .toList();
      emit(state.copyWith(
        articles: results,
        status: ArticlesStatus.success,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: ArticlesStatus.error,
        error: e.toString(),
      ));
    }
  }

  Future<void> _onLoadByCategory(
      LoadArticleByCategoryEvent event, Emitter<ArticlesState> emit) async {
    emit(state.copyWith(status: ArticlesStatus.loading));
    try {
      await Future.delayed(const Duration(milliseconds: 300));
      final filtered =
          _allArticles.where((article) => article.category == event.category).toList();
      emit(state.copyWith(
        articles: filtered,
        selectedCategory: event.category,
        status: ArticlesStatus.success,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: ArticlesStatus.error,
        error: e.toString(),
      ));
    }
  }

  Future<void> _onBookmarkArticle(BookmarkArticleEvent event, Emitter<ArticlesState> emit) async {
    try {
      final article = _allArticles.firstWhere((a) => a.id == event.articleId);
      final updatedBookmarks = [...state.bookmarkedArticles];
      if (!updatedBookmarks.any((a) => a.id == event.articleId)) {
        updatedBookmarks.add(article);
      }
      emit(state.copyWith(bookmarkedArticles: updatedBookmarks));
    } catch (e) {
      emit(state.copyWith(
        status: ArticlesStatus.error,
        error: e.toString(),
      ));
    }
  }

  Future<void> _onRemoveBookmark(
      RemoveArticleBookmarkEvent event, Emitter<ArticlesState> emit) async {
    try {
      final updated = state.bookmarkedArticles.where((a) => a.id != event.articleId).toList();
      emit(state.copyWith(bookmarkedArticles: updated));
    } catch (e) {
      emit(state.copyWith(
        status: ArticlesStatus.error,
        error: e.toString(),
      ));
    }
  }

  Future<void> _onLoadFavorites(LoadFavoriteArticlesEvent event, Emitter<ArticlesState> emit) async {
    emit(state.copyWith(status: ArticlesStatus.loading));
    try {
      await Future.delayed(const Duration(milliseconds: 300));
      emit(state.copyWith(
        articles: state.bookmarkedArticles,
        status: ArticlesStatus.success,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: ArticlesStatus.error,
        error: e.toString(),
      ));
    }
  }

  Future<void> _onGetCategories(GetArticleCategoriesEvent event, Emitter<ArticlesState> emit) async {
    emit(state.copyWith(categories: _categories));
  }
}
