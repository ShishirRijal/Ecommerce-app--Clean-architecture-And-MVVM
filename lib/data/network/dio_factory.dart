import 'package:dio/dio.dart';
import 'package:ecommerce_app/app/constants.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

const String applicationJson = "application/json";
const String contentType = "content-type";
const String accept = "accept";
const String authorization = "authorization";
const String defaultLanguage = "language";

class DioFactory {
  Future<Dio> getDio() async {
    Dio dio = Dio();
    int time = 60 * 1000; // 1 minute
    final timeOut = Duration(milliseconds: time);
    Map<String, String> headers = {
      contentType: applicationJson,
      accept: accept,
      authorization: Constants.token,
      defaultLanguage: Constants.language,
    };
    dio.options = BaseOptions(
      baseUrl: Constants.baseUrl,
      connectTimeout: timeOut,
      sendTimeout: timeOut,
      headers: headers,
    );

    if (kReleaseMode) {
      debugPrint("Release mode...");
    } else {
      dio.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: true,
      ));
    }

    return dio;
  }
}
