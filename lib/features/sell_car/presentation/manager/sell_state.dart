sealed class SellState {}

final class SellInitial extends SellState {}

final class SellLoading extends SellState {}

final class SellSuccess extends SellState {}

final class SellError extends SellState {}
