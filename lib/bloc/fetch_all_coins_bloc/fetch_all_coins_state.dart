part of 'fetch_all_coins_bloc.dart';

sealed class FetchAllCoinsState extends Equatable {
  const FetchAllCoinsState();

  @override
  List<Object> get props => [];
}

final class FetchAllCoinsInitial extends FetchAllCoinsState {}

final class FetchAllCoinsLoading extends FetchAllCoinsState {}

final class FetchAllCoinsSuccess extends FetchAllCoinsState {
  final List<CoinModel> coins;

  const FetchAllCoinsSuccess(this.coins);
}

final class FetchAllCoinsFailure extends FetchAllCoinsState {
  final Object? error;

  const FetchAllCoinsFailure({required this.error});
}
