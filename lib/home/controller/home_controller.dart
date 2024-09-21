import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:websocket_example/config/mixins/app_state_handle_mixins.dart';
import 'package:websocket_example/data/response/app_response.dart';
import 'package:websocket_example/home/model/coin_data_model.dart';

class HomeController extends ChangeNotifier with AppStateHandleMixin<CoinData> {
  late WebSocketChannel _channel;

  void connectToSocet() {
    final wsUrl = Uri.parse('wss://stream.binance.com:9443/ws/btcusdt@ticker');
    _channel = WebSocketChannel.connect(wsUrl);
  }

  void fetchDataFromSocket() {
    _channel.stream.listen((data) {
      final streamData = jsonDecode(data);
      log(streamData.toString());
      final coinData = CoinData.fromJson(streamData);
      setAppResponse = ApiResponse.completed(coinData);
    }).onError((e) {
      setAppResponse = ApiResponse.error(e.toString());
    });
  }

  void homeInitFunction() {
    setAppResponse = ApiResponse.loading();
    connectToSocet();
    fetchDataFromSocket();
  }

  String formatTime(int timestamp) {
    // Given timestamp in milliseconds

    // Convert timestamp to DateTime
    DateTime utcDateTime =
        DateTime.fromMillisecondsSinceEpoch(timestamp, isUtc: true);

    // Add 5 hours 30 minutes to convert UTC to IST
    DateTime istDateTime = utcDateTime.add(Duration(hours: 5, minutes: 30));

    // Format the DateTime to 24-hour string format
    String formattedTime =
        "${istDateTime.year}-${_twoDigits(istDateTime.month)}-${_twoDigits(istDateTime.day)} "
        "${_twoDigits(istDateTime.hour)}:${_twoDigits(istDateTime.minute)}:${_twoDigits(istDateTime.second)}";

    print(formattedTime);
    return formattedTime; // Output: 2024-09-21 12:25:59
  }

// Helper function to add leading zero to single digit numbers
  String _twoDigits(int n) {
    return n.toString().padLeft(2, '0');
  }
}
