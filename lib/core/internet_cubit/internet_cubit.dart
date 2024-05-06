import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'internet_state.dart';

class InternetCubit extends Cubit<InternetState> {

  InternetCubit() : super(InternetInitial());

  void connected() {
    emit(ConnectedState(message: "Connected"));
  }

  void notConnected() {
    emit(NotConnectedState(message: "Not Connected"));
  }

 checkConnection()  {
    Connectivity()
        .onConnectivityChanged
        .listen((List<ConnectivityResult> result) {
      if (result.contains(ConnectivityResult.mobile) ||
          result.contains(ConnectivityResult.wifi)) {
        connected();
      } else {
        notConnected();
      }
    });
  }


}
