import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:test_work/bloc/fetch_coin_chart_bloc/fetch_coin_chart_bloc.dart';
import 'package:test_work/model/coin_model.dart';

class CoinChartWidget extends StatelessWidget {
  const CoinChartWidget({super.key, required this.coin, required this.state});

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
          titlesData: const FlTitlesData(show: false),
          borderData: FlBorderData(show: false),
          gridData: FlGridData(
            getDrawingHorizontalLine: (value) => const FlLine(strokeWidth: 0),
            getDrawingVerticalLine: (value) => const FlLine(strokeWidth: 0),
          ),
          lineTouchData: const LineTouchData(enabled: false),
          lineBarsData: [
            LineChartBarData(
              spots: state.flSpotList,
              dotData: const FlDotData(show: false),
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