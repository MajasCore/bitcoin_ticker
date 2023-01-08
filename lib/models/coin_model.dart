import 'dart:convert';

CoinData coinDataFromJson(String str) => CoinData.fromJson(json.decode(str));

String coinDataToJson(CoinData data) => json.encode(data.toJson());

class CoinData {
  CoinData({
    this.time,
    this.assetIdBase,
    this.assetIdQuote,
    this.rate,
  });

  DateTime time;
  String assetIdBase;
  String assetIdQuote;
  double rate;

  factory CoinData.fromJson(Map<String, dynamic> json) => CoinData(
        time: DateTime.parse(json["time"]),
        assetIdBase: json["asset_id_base"],
        assetIdQuote: json["asset_id_quote"],
        rate: json["rate"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "time": time.toIso8601String(),
        "asset_id_base": assetIdBase,
        "asset_id_quote": assetIdQuote,
        "rate": rate,
      };
}
