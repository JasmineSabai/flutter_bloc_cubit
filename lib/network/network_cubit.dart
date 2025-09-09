import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../constants/app_enum.dart';

class NetworkCubit extends Cubit<ConnectivityStatus> {
  final Connectivity _connectivity = Connectivity();

  NetworkCubit() : super(ConnectivityStatus.connected) {
    _connectivity.onConnectivityChanged.listen((result) {
      if (result == ConnectivityResult.none) {
        emit(ConnectivityStatus.disconnected);
      } else {
        emit(ConnectivityStatus.connected);
      }
    });
  }
}
