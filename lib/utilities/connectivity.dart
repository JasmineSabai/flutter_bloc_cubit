import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';

Future<void> checkNetwork() async {
  final ConnectivityResult result = (await Connectivity().checkConnectivity()) as ConnectivityResult;

  if (result == ConnectivityResult.mobile) {
    print("Connected to Mobile Network");
  } else if (result == ConnectivityResult.wifi) {
    print("Connected to Wi-Fi");
  } else {
    print("No internet connection");
  }
}

StreamSubscription? connectivitySubscription;

void startNetworkListener() {
  connectivitySubscription = Connectivity().onConnectivityChanged.listen((result) {
    if (result == ConnectivityResult.none) {
      print("🚫 No internet connection");
    } else {
      print("✅ Internet is back: $result");
    }
  });
}

void stopNetworkListener() {
  connectivitySubscription?.cancel();
}
