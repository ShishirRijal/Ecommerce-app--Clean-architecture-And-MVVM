import 'package:ecommerce_app/data/data.dart';

class RemoteDataSourceImpl implements RemoteDataSource {
  RemoteDataSourceImpl(this._client);

  final AppServiceClient _client;

  @override
  Future<AuthResponse> login(LoginRequest loginRequest) async {
    return await _client.login(
      email: loginRequest.email,
      password: loginRequest.password,
      imei: "",
      deviceName: "",
    );
  }

  @override
  Future<ForgotPasswordResponse> forgotPassword(String email) async {
    return await _client.forgotPassword(email: email);
  }

  @override
  Future<AuthResponse> register(RegisterRequest registerRequest) async {
    return await _client.register(
        countryMobileCode: registerRequest.countryMobileCode,
        username: registerRequest.username,
        email: registerRequest.email,
        password: registerRequest.password,
        profilePicture: registerRequest.password);
  }
}
