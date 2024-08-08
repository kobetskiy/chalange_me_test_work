part of 'fetch_all_coins_bloc.dart';

sealed class FetchAllCoinsEvent extends Equatable {
  const FetchAllCoinsEvent();

  @override
  List<Object> get props => [];
}

class FetchAllCoins extends FetchAllCoinsEvent {}
