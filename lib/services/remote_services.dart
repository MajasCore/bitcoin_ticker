import 'package:http/http.dart';
import '../models/coin_model.dart';

class RemoteService {
  String currency = 'USD';
  String coin;
  RemoteService({this.currency, this.coin});
  Future<CoinData> fetchCoinData() async {
    String currenci = currency;
    String coinn = coin;
    String apikey = 'BE0D138C-22DF-4FEB-8A1A-5020A3FA1E78';
    var uri = Uri.parse(
        'https://rest.coinapi.io/v1/exchangerate/$coinn/$currenci?apikey=$apikey');

    final response = await get(uri);

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      print('succesful');
      var json = response.body;
      print(json);
      return coinDataFromJson(json);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load CoinData bitch');
    }
  }
}
