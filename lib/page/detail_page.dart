import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_work/bloc/fetch_coin_chart_bloc/fetch_coin_chart_bloc.dart';
import 'package:test_work/widgets/export.dart';
import '../model/coin_model.dart';
import '../service/currency_number_formatter.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key, required this.coin});
  final CoinModel coin;

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return FetchCoinChartBloc()
          ..add(FetchChartData(coin: widget.coin, days: '1'));
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            widget.coin.name!,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),
        body: BlocBuilder<FetchCoinChartBloc, FetchCoinChartState>(
          builder: (context, state) {
            if (state is FetchCoinChartSuccess) {
              return Padding(
                padding: const EdgeInsets.all(12),
                child: SizedBox(
                  width: double.infinity,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _CoinDetailsWidget(coin: widget.coin),
                        const SizedBox(height: 24),
                        CoinChartWidget(coin: widget.coin, state: state),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            SwitchChartTimeButton(
                              coin: widget.coin,
                              isSelected: selectedIndex == 0,
                              onPressed: () {
                                selectedIndex = 0;
                                if (selectedIndex == 0) return;
                                setState(() {});
                                context.read<FetchCoinChartBloc>().add(
                                    FetchChartData(
                                        coin: widget.coin, days: '1'));
                              },
                              child: const Text('24H'),
                            ),
                            SwitchChartTimeButton(
                              coin: widget.coin,
                              isSelected: selectedIndex == 1,
                              onPressed: () {
                                if (selectedIndex == 1) return;
                                selectedIndex = 1;
                                setState(() {});
                                context.read<FetchCoinChartBloc>().add(
                                    FetchChartData(
                                        coin: widget.coin, days: '7'));
                              },
                              child: const Text('7D'),
                            ),
                            SwitchChartTimeButton(
                              coin: widget.coin,
                              isSelected: selectedIndex == 2,
                              onPressed: () {
                                if (selectedIndex == 2) return;
                                selectedIndex = 2;
                                setState(() {});
                                context.read<FetchCoinChartBloc>().add(
                                    FetchChartData(
                                        coin: widget.coin, days: '30'));
                              },
                              child: const Text('30D'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            } else if (state is FetchCoinChartFailure) {
              return Center(child: Text(state.error.toString()));
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}

class _CoinDetailsWidget extends StatelessWidget {
  const _CoinDetailsWidget({required this.coin});

  final CoinModel coin;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${coin.name} Price',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            CurrencyNumberFormatter.idr(coin.currentPrice!),
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 28,
                ),
          ),
          const SizedBox(height: 4),
          Text(
            coin.priceChangePercentage24h! > 0
                ? '+${coin.priceChangePercentage24h.toString().substring(0, 6)}%'
                : '${coin.priceChangePercentage24h.toString().substring(0, 7)}%',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: coin.priceChangePercentage24h! > 0
                  ? Colors.green
                  : Colors.red,
            ),
          ),
        ],
      ),
    );
  }
}
