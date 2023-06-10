import 'package:ecommerce_app/data/data.dart';

import '../responses/home_data_response.dart';

abstract class RemoteDataSource {
  Future<AuthResponse> login(LoginRequest loginRequest);
  Future<AuthResponse> register(RegisterRequest registerRequest);
  Future<ForgotPasswordResponse> forgotPassword(String email);
  Future<HomeResponse> getHome();
}
