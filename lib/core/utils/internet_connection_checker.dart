import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:injectable/injectable.dart';
import 'dart:async';

@Injectable()
class InternetConnectionChecker {
  final Connectivity _connectivity = Connectivity();
  StreamSubscription<ConnectivityResult>? _subscription;

  // Start listening to connectivity changes
  void startListening(Function(ConnectivityResult) onConnectivityChanged) {
    _subscription = _connectivity.onConnectivityChanged.listen((result) {
      onConnectivityChanged(result); // Callback with new connectivity result
    });
  }

  // Stop listening to connectivity changes
  void stopListening() {
    _subscription?.cancel();
  }

  // Check current connectivity status
  Future<bool> isConnected() async {
    var connectivityResult = await _connectivity.checkConnectivity();
    return connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi;
  }
}
