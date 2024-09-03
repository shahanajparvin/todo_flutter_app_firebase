
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:injectable/injectable.dart';

@Injectable()
class InternetConnectionChecker {
  final Connectivity _connectivity = Connectivity();

  Future<bool> isConnected() async {
    //return false;
    var connectivityResult = await _connectivity.checkConnectivity();
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      return true;
    }
    return false;
  }
}
