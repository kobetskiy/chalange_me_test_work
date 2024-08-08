import 'package:flutter/material.dart';
import 'package:test_work/model/coin_model.dart';
import 'coin_tile.dart';

class CoinsList extends StatelessWidget {
  const CoinsList({super.key, required this.coinsList});

  final List<CoinModel> coinsList;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: coinsList.isEmpty
              ? const Center(
                  child: Text('No Coin Found'),
                )
              : ListView.builder(
                  itemCount: coinsList.length,
                  itemBuilder: (context, index) {
                    return CoinTile(coin: coinsList[index], index: index);
                  },
                ),
        ),
      ],
    );
  }
}
