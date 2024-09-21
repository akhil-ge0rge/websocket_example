// To parse this JSON data, do
//
//     final coinData = coinDataFromJson(jsonString);

import 'dart:convert';

CoinData coinDataFromJson(String str) => CoinData.fromJson(json.decode(str));

String coinDataToJson(CoinData data) => json.encode(data.toJson());

class CoinData {
  String eventType;
  int eventTime;
  String symbol;
  String priceChange;
  String priceChangePercentage;
  String weightedAveragePrice;

  String lastPrice;
  String lastQuantity;
  String bestBidPrice;
  String bestBidQuantity;
  String coinDataA;

  String openPrice;
  String highestPrice;
  String lowestPrice;

  CoinData({
    required this.eventType,
    required this.eventTime,
    required this.symbol,
    required this.priceChange,
    required this.priceChangePercentage,
    required this.weightedAveragePrice,
    required this.lastPrice,
    required this.lastQuantity,
    required this.bestBidPrice,
    required this.bestBidQuantity,
    required this.coinDataA,
    required this.openPrice,
    required this.highestPrice,
    required this.lowestPrice,
  });

  factory CoinData.fromJson(Map<String, dynamic> json) => CoinData(
        eventType: json["e"],
        eventTime: json["E"],
        symbol: json["s"],
        priceChange: json["p"],
        priceChangePercentage: json["P"],
        weightedAveragePrice: json["w"],
        lastPrice: json["c"],
        lastQuantity: json["Q"],
        bestBidPrice: json["b"],
        bestBidQuantity: json["B"],
        coinDataA: json["a"],
        openPrice: json["o"],
        highestPrice: json["h"],
        lowestPrice: json["l"],
      );

  Map<String, dynamic> toJson() => {
        "e": eventType,
        "E": eventTime,
        "s": symbol,
        "p": priceChange,
        "P": priceChangePercentage,
        "w": weightedAveragePrice,
        "c": lastPrice,
        "Q": lastQuantity,
        "b": bestBidPrice,
        "B": bestBidQuantity,
        "a": coinDataA,
        "o": openPrice,
        "h": highestPrice,
        "l": lowestPrice,
      };
}
