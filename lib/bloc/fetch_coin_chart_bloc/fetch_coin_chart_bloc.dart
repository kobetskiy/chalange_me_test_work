import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:test_work/model/coin_model.dart';
import 'package:test_work/service/http_service.dart';

part 'fetch_coin_chart_event.dart';
part 'fetch_coin_chart_state.dart';

class FetchCoinChartBloc
    extends Bloc<FetchCoinChartEvent, FetchCoinChartState> {
  FetchCoinChartBloc() : super(FetchCoinChartInitial()) {
    on<FetchChartData>((event, emit) async {
      try {
        emit(FetchCoinChartLoading());
        final data = await HttpService.fetchNDayPriceData(
          event.coin.id,
          event.days,
        );
        List<FlSpot> flSpotList = [];
        for (var chart in data) {
          flSpotList.add(FlSpot(chart.time.toDouble(), chart.price));
        }
        double minX = data.first.time.toDouble();
        double maxX = data.last.time.toDouble();
        data.sort((a, b) => a.price.compareTo(b.price));
        double minY = data.first.price;
        double maxY = data.last.price;
        emit(FetchCoinChartSuccess(flSpotList, minX, maxX, minY, maxY));
      } catch (e) {
        emit(FetchCoinChartFailure(error: e));
      }
    });
  }
}
