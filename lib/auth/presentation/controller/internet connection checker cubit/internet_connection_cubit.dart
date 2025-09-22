import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'internet_connection_state.dart';

class InternetCubit extends Cubit<InternetConnectionState> {
  final Connectivity _connectivity;
  late final StreamSubscription _subscription;

  InternetCubit(this._connectivity) : super(NoConnection()) {
    _initConnection();
    _subscription = _connectivity.onConnectivityChanged.listen((results) {
      if (results.contains(ConnectivityResult.none)) {
        emit(NoConnection());
      } else {
        emit(ConnectionFounded());
      }
    });
  }

  Future<void> _initConnection() async {
    final results = await _connectivity.checkConnectivity();
    if (results.contains(ConnectivityResult.none)) {
      emit(NoConnection());
    } else {
      emit(ConnectionFounded());
    }
  }

  @override
  Future<void> close() {
    _subscription.cancel();
    return super.close();
  }
}
