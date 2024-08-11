import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_work/service/currency_number_formatter.dart';
import 'package:test_work/model/coin_model.dart';
import 'package:test_work/page/detail_page.dart';
import 'package:test_work/bloc/fetch_coin_chart_bloc/fetch_coin_chart_bloc.dart';
import 'coin_chart_widget.dart';

class CoinTile extends StatefulWidget {
  const CoinTile({super.key, required this.coin, required this.index});

  final CoinModel coin;
  final int index;

  @override
  State<CoinTile> createState() => _CoinTileState();
}

class _CoinTileState extends State<CoinTile>
    with SingleTickerProviderStateMixin {
  final fetchCoinChartBloc = FetchCoinChartBloc();
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    fetchCoinChartBloc.add(FetchChartData(coin: widget.coin, days: '7'));

    _controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.0, 1.0, curve: Curves.easeIn),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(-1.0, 0.0),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 1.0, curve: Curves.easeInOut),
      ),
    );

    Future.delayed(Duration(milliseconds: widget.index * 200), () {
      _controller.forward();
    });
  }

  @override
  void dispose() {
    fetchCoinChartBloc.close();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: SlideTransition(
        position: _slideAnimation,
        child: Card(
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          elevation: 7,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: InkWell(
            customBorder: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailPage(coin: widget.coin),
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 10, 16, 16),
              child: Column(
                children: [
                  Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(25),
                        child: Image.network(
                          widget.coin.image ?? '',
                          width: 50,
                          height: 50,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.coin.name ?? '',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const SizedBox(height: 20),
                          Text(
                            CurrencyNumberFormatter.idr(
                              widget.coin.currentPrice!
                            ),
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            widget.coin.priceChangePercentage24h! > 0
                                ? '+${widget.coin.priceChangePercentage24h.toString().substring(0, 6)}%'
                                : '${widget.coin.priceChangePercentage24h.toString().substring(0, 7)}%',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              color: widget.coin.priceChangePercentage24h! > 0
                                  ? Colors.green
                                  : Colors.red,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  BlocBuilder<FetchCoinChartBloc, FetchCoinChartState>(
                    bloc: fetchCoinChartBloc,
                    builder: (context, state) {
                      if (state is FetchCoinChartSuccess) {
                        return SizedBox(
                          height: 100,
                          child: CoinChartWidget(
                            coin: widget.coin,
                            state: state,
                          ),
                        );
                      } else if (state is FetchCoinChartFailure) {
                        return Center(child: Text(state.error.toString()));
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
