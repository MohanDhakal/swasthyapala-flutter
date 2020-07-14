//check if internet or data is available

import 'package:connectivity/connectivity.dart';

class Connection {
  static bool connectionStatus = false;

  static Future<bool> isConnected() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      return !connectionStatus;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      return !connectionStatus;
    } else
      return connectionStatus;
  }
}
