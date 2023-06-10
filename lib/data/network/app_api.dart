import 'package:dio/dio.dart';
import 'package:ecommerce_app/app/constants.dart';
import 'package:ecommerce_app/data/data.dart';
import 'package:retrofit/http.dart';

import '../responses/home_data_response.dart';

part 'app_api.g.dart';

@RestApi(baseUrl: Constants.baseUrl)
abstract class AppServiceClient {
  factory AppServiceClient(Dio dio, {String baseUrl}) = _AppServiceClient;

  @POST('/customers/login')
  Future<AuthResponse> login({
    @Field('email') required String email,
    @Field('password') required String password,
    @Field('imei') required String imei,
    @Field('device_name') required String deviceName,
  });

  @POST('/forgot-password')
  Future<ForgotPasswordResponse> forgotPassword({
    @Field('email') required String email,
  });

  @POST('/customers/register')
  Future<AuthResponse> register({
    @Field('country_mobile_code') required String countryMobileCode,
    @Field('username') required String username,
    @Field('email') required String email,
    @Field('password') required String password,
    @Field('mobile_number') required String mobileNumber,
    @Field('profile_picture') required String profilePicture,
  });

  @GET('/home')
  Future<HomeResponse> home();
}
