import 'package:ecommerce_app/data/network/network_info.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class NetworkInfoImplementer implements NetworkInfo {
  final InternetConnectionChecker _connectionChecker;
  NetworkInfoImplementer(this._connectionChecker);
  @override
  Future<bool> get isConnected async {
    return await _connectionChecker.hasConnection;
  }
}
