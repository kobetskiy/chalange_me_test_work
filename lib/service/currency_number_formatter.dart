import 'package:intl/intl.dart';

class CurrencyNumberFormatter {
  static String idr(double number) {
    NumberFormat currencyFormatter = NumberFormat.currency(
      locale: 'en_US',
      symbol: '\$',
      decimalDigits: 3,
    );
    return currencyFormatter.format(number);
  }
}
