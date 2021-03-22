import 'package:cointickyapp/helpers/network_helper.dart';

const apiKey = 'get your api key at bitcoinaverage';
const bitCoinAverageUrl =
    'https://apiv2.bitcoinaverage.com/indices/global/ticker/BTC';

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = ['BTC', 'ETH', 'LTC'];

class Coin {
  Future<dynamic> getCoinData() async {
    String url = '${bitCoinAverageUrl}USD';
    print(url);

    NetworkHelper networkHelper = new NetworkHelper(url, apiKey);
    var coinData = await networkHelper.getData();

    return coinData;
  }

  Future<dynamic> getCurrentCoinData(String selectedCurrency) async {
    String url = '${bitCoinAverageUrl}$selectedCurrency';
    print(url);

    NetworkHelper networkHelper = new NetworkHelper(url, apiKey);
    var coinData = await networkHelper.getData();

    return coinData;
  }

  Future<dynamic> getCryptoCurrentCoinData(
      String crypto, String selectedCurrency) async {
    const bitCryptoCoinAverageUrl =
        'https://apiv2.bitcoinaverage.com/indices/global/ticker/';
    String url = '${bitCryptoCoinAverageUrl}$crypto$selectedCurrency';
    print(url);

    NetworkHelper networkHelper = new NetworkHelper(url, apiKey);
    var coinData = await networkHelper.getData();

    return coinData;
  }
}
