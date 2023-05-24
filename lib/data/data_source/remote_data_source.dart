import 'package:ecommerce_app/data/data.dart';
import 'package:ecommerce_app/data/request/request.dart';

abstract class RemoteDataSource {
  Future<AuthResponse> login(LoginRequest loginRequest);
}
