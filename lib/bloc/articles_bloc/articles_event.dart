abstract class ArticlesEvent {}

class LoadArticlesEvent extends ArticlesEvent {
  final String? category;
  LoadArticlesEvent({this.category});
}

class SearchArticlesEvent extends ArticlesEvent {
  final String query;
  SearchArticlesEvent(this.query);
}

class LoadArticleByCategoryEvent extends ArticlesEvent {
  final String category;
  LoadArticleByCategoryEvent(this.category);
}

class BookmarkArticleEvent extends ArticlesEvent {
  final int articleId;
  BookmarkArticleEvent(this.articleId);
}

class RemoveArticleBookmarkEvent extends ArticlesEvent {
  final int articleId;
  RemoveArticleBookmarkEvent(this.articleId);
}

class LoadFavoriteArticlesEvent extends ArticlesEvent {}

class GetArticleCategoriesEvent extends ArticlesEvent {}
