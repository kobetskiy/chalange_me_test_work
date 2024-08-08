import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:test_work/bloc/fetch_coin_chart_bloc/fetch_coin_chart_bloc.dart';
import 'package:test_work/model/coin_model.dart';

class CoinChartWidget extends StatelessWidget {
  const CoinChartWidget({required this.coin, required this.state});

  final CoinModel coin;
  final FetchCoinChartSuccess state;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      child: LineChart(
        LineChartData(
          minX: state.minX,
          minY: state.minY,
          maxX: state.maxX,
          maxY: state.maxY,
          titlesData: FlTitlesData(show: false),
          borderData: FlBorderData(show: false),
          gridData: FlGridData(
            getDrawingHorizontalLine: (value) => FlLine(strokeWidth: 0),
            getDrawingVerticalLine: (value) => FlLine(strokeWidth: 0),
          ),
          lineTouchData: LineTouchData(enabled: false),
          lineBarsData: [
            LineChartBarData(
              spots: state.flSpotList,
              dotData: FlDotData(show: false),
              color: coin.priceChangePercentage24h! > 0
                  ? Colors.green
                  : Colors.red,
            ),
          ],
        ),
      ),
    );
  }
}