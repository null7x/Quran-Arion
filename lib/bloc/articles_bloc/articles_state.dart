enum ArticlesStatus { initial, loading, success, error }

class Article {
  final int id;
  final String title;
  final String content;
  final String category;
  final String author;
  final DateTime publishedDate;
  final String imageUrl;
  final int readTimeInMinutes;
  final int views;

  Article({
    required this.id,
    required this.title,
    required this.content,
    required this.category,
    required this.author,
    required this.publishedDate,
    required this.imageUrl,
    required this.readTimeInMinutes,
    required this.views,
  });

  Article copyWith({
    int? id,
    String? title,
    String? content,
    String? category,
    String? author,
    DateTime? publishedDate,
    String? imageUrl,
    int? readTimeInMinutes,
    int? views,
  }) {
    return Article(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      category: category ?? this.category,
      author: author ?? this.author,
      publishedDate: publishedDate ?? this.publishedDate,
      imageUrl: imageUrl ?? this.imageUrl,
      readTimeInMinutes: readTimeInMinutes ?? this.readTimeInMinutes,
      views: views ?? this.views,
    );
  }
}

class ArticlesState {
  final List<Article> articles;
  final List<Article> bookmarkedArticles;
  final ArticlesStatus status;
  final String? error;
  final String? selectedCategory;
  final List<String> categories;

  ArticlesState({
    this.articles = const [],
    this.bookmarkedArticles = const [],
    this.status = ArticlesStatus.initial,
    this.error,
    this.selectedCategory,
    this.categories = const [],
  });

  ArticlesState copyWith({
    List<Article>? articles,
    List<Article>? bookmarkedArticles,
    ArticlesStatus? status,
    String? error,
    String? selectedCategory,
    List<String>? categories,
  }) {
    return ArticlesState(
      articles: articles ?? this.articles,
      bookmarkedArticles: bookmarkedArticles ?? this.bookmarkedArticles,
      status: status ?? this.status,
      error: error ?? this.error,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      categories: categories ?? this.categories,
    );
  }
}
