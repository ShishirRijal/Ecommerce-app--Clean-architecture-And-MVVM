import 'package:ecommerce_app/data/data.dart';

import '../responses/home_data_response.dart';
import '../responses/store_detail_response.dart';

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
        mobileNumber: registerRequest.mobileNumber,
        profilePicture: "");
  }

  @override
  Future<HomeResponse> getHome() async {
    return await _client.home();
  }

  @override
  Future<StoreDetailResponse> getStoreDetails() async {
    return await _client.getStoreDetails();
  }
}
