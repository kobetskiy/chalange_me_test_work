part of 'fetch_coin_chart_bloc.dart';

sealed class FetchCoinChartEvent extends Equatable {
  const FetchCoinChartEvent();

  @override
  List<Object> get props => [];
}

class FetchChartData extends FetchCoinChartEvent {
  final CoinModel coin;
  final String days;

  const FetchChartData({required this.coin, required this.days});

  @override
  List<Object> get props => [coin, days];
}