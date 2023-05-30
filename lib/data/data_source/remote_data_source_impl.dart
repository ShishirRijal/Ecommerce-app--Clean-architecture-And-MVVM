import 'package:ecommerce_app/data/data_source/remote_data_source.dart';
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
}
