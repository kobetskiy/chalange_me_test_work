import 'dart:convert';
import 'package:http/http.dart';
import 'package:test_work/model/coin_model.dart';

class HttpService {
  static Future<List<CoinModel>> getListCoins() async {
    String apiUrl =
        'https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=5&page=1&sparkline=false';

    final response = await get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      List result = json.decode(response.body);
      final data = result.map((json) => CoinModel.fromJson(json)).toList();
      return data;
    }
    return <CoinModel>[];
  }

  static Future<List<PriceAndTime>> fetchNDayPriceData(
    String? coinId,
    String days,
  ) async {
    String api =
        'https://api.coingecko.com/api/v3/coins/$coinId/market_chart?vs_currency=idr&days=$days';

    final response = await get(Uri.parse(api));
    if (response.statusCode == 200) {
      Map<String, dynamic> result = json.decode(response.body);
      List rawList = result['prices'];
      List<List> chartData = rawList.map((e) => e as List).toList();
      List<PriceAndTime> priceAndTimeList = chartData
          .map((e) => PriceAndTime(time: e[0] as int, price: e[1] as double),)
          .toList();
      return priceAndTimeList;
    }
    return <PriceAndTime>[];
  }
}

class PriceAndTime {
  PriceAndTime({required this.time, required this.price});

  final int time;
  final double price;
}
