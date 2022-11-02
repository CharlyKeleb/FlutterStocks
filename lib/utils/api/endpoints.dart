import 'package:flutter_stocks/utils/api/key.dart';

class Endpoints {
  static String baseURL = 'http://api.marketstack.com/v1';
  static String companyURL = '$baseURL/tickers?access_key=$apiKey';
}
