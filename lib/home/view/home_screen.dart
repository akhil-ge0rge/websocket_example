import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:websocket_example/data/response/app_response.dart';
import 'package:websocket_example/home/controller/home_controller.dart';
import 'package:websocket_example/home/model/coin_data_model.dart';

import '../../data/response/status.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late HomeController homeController;

  @override
  void initState() {
    super.initState();
    homeController = context.read<HomeController>();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        homeController.homeInitFunction();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final textStyle = TextStyle(
      fontSize: 17,
      fontWeight: FontWeight.bold,
      color: Colors.white,
      letterSpacing: 0.5, // Add some spacing for a sleek look
    );
    return Scaffold(
      body: Selector<HomeController, ApiResponse<CoinData>?>(
          selector: (p0, p1) => p1.appResponse,
          builder: (context, value, child) {
            switch (value?.status) {
              case Status.loading:
                return const CircularProgressIndicator.adaptive();
              case Status.completed:
                final price = value?.data?.lastPrice.toString();
                final time = homeController.formatTime(value!.data!.eventTime);
                final symbol = value?.data?.symbol.toString();
                final lowestPrice = value?.data?.lowestPrice.toString();
                final highestPrice = value?.data?.highestPrice.toString();
                final openPrice = value?.data?.openPrice.toString();
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Center(
                      child: Text(
                        "Symbol : $symbol",
                        style: textStyle,
                      ),
                    ),
                    Text(
                      "Current Price : $price",
                      style: textStyle,
                    ),
                    Text(
                      "Date & Time : $time",
                      style: textStyle,
                    ),
                    Text(
                      "Open Price : $openPrice",
                      style: textStyle,
                    ),
                    Text(
                      "Lowest Price : $lowestPrice",
                      style: textStyle,
                    ),
                    Text(
                      "Highest Price : $highestPrice",
                      style: textStyle,
                    )
                  ],
                );
              case Status.error:
                return Text(value!.message.toString());
              default:
                return const SizedBox();
            }
          }),
    );
  }
}
