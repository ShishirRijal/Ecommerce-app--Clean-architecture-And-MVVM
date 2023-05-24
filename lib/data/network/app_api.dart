import 'package:dio/dio.dart';
import 'package:ecommerce_app/app/constants.dart';
import 'package:ecommerce_app/data/data.dart';
import 'package:retrofit/http.dart';

part 'app_api.g.dart';

@RestApi(baseUrl: Constants.baseUrl)
abstract class AppServiceClient {
  factory AppServiceClient(Dio dio, {String baseUrl}) = _AppServiceClient;

  @POST('/customers/login')
  Future<AuthResponse> login();
}