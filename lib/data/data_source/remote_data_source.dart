import 'package:ecommerce_app/data/data.dart';

abstract class RemoteDataSource {
  Future<AuthResponse> login(LoginRequest loginRequest);
}
