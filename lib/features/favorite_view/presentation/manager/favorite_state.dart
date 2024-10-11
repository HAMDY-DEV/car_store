sealed class FavoriteState {}

final class FavoriteInitial extends FavoriteState {}

final class FavoriteLoading extends FavoriteState {}

final class FavoriteSuccess extends FavoriteState {}

final class FavoriteError extends FavoriteState {}

final class GetUserFavoriteLoading extends FavoriteState {}

final class GetUserFavoriteSuccess extends FavoriteState {
  final List<dynamic> listId;
  GetUserFavoriteSuccess({required this.listId});
}

final class GetUserFavoriteError extends FavoriteState {}
