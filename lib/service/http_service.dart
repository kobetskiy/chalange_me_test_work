import 'dart:convert';
import 'package:http/http.dart';
import 'package:test_work/model/coin_model.dart';

class HttpService {
  static const String apiKey =
      '018d21536000aa2c72005274888d29ff54d573174d6e4fcbc3d43b4d4a58840a';

  static Future<List<CoinModel>> getListCoins() async {
    String apiUrl =
        'https://min-api.cryptocompare.com/data/top/mktcapfull?limit=100&tsym=USD&api_key=$apiKey';

    final response = await get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      Map<String, dynamic> result = json.decode(response.body);
      List rawData = result['Data'];

      List<String> filterCoins = ['SOL', 'NOT', 'XRP', 'AVAX', 'ADA'];

      final data = rawData
          .where((json) => filterCoins.contains(json['CoinInfo']['Name']))
          .map((json) => CoinModel.fromCryptoCompareJson(json))
          .toList();

      return data;
    }
    return <CoinModel>[];
  }

  static Future<List<PriceAndTime>> fetchNDayPriceData(
    String? coinId,
    String days,
  ) async {
    String api =
        'https://min-api.cryptocompare.com/data/v2/histoday?fsym=$coinId&tsym=USD&limit=$days&api_key=$apiKey';

    final response = await get(Uri.parse(api));
    if (response.statusCode == 200) {
      Map<String, dynamic> result = json.decode(response.body);
      List rawData = result['Data']['Data'];
      List<PriceAndTime> priceAndTimeList = rawData
          .map((e) => PriceAndTime(time: e['time'] * 1000, price: e['close']))
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
