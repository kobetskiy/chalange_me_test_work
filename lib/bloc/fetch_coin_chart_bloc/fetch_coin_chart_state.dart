part of 'fetch_coin_chart_bloc.dart';

sealed class FetchCoinChartState extends Equatable {
  const FetchCoinChartState();

  @override
  List<Object> get props => [];
}

final class FetchCoinChartInitial extends FetchCoinChartState {}

final class FetchCoinChartLoading extends FetchCoinChartState {}

final class FetchCoinChartSuccess extends FetchCoinChartState {
  final List<FlSpot> flSpotList;
  final double minX;
  final double maxX;
  final double minY;
  final double maxY;

  const FetchCoinChartSuccess(this.flSpotList, this.minX, this.maxX, this.minY, this.maxY);

  @override
  List<Object> get props => [flSpotList, minX, maxX, minY, maxY];
}

final class FetchCoinChartFailure extends FetchCoinChartState {
  final Object? error;

  const FetchCoinChartFailure({required this.error});
}
