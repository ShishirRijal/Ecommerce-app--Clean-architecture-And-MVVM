// ignore_for_file: constant_identifier_names
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';

import '../failure/failure.dart';

enum StatusCode {
  SUCCESS,
  NO_CONTENT,
  BAD_REQUEST,
  FORBIDDEN,
  UNAUTHORISED,
  NOT_FOUND,
  INTERNAL_SERVER_ERROR,
  CONNECTION_TIMEOUT,
  CANCEL,
  RECEIVE_TIMEOUT,
  SEND_TIMEOUT,
  CACHE_ERROR,
  NO_INTERNET_CONNECTION,
  UNKNOWN
}

class ResponseCode {
  // API status code
  static const int SUCCESS = 200; // success with data
  static const int NO_CONTENT = 201; // success with no content
  static const int BAD_REQUEST = 400; // failure, api rejected the request
  static const int FORBIDDEN = 403; // failure, api rejected teh Request
  static const int UNAUTHORISED = 401; // failure user in not authorised
  static const int NOT_FOUND =
      404; // failure, api url is not correct and not found..
  static const int INTERNAL_SERVER_ERROR = 500; // failure, crash in server side
  // Local status code
  static const int UNKNOWN = -1;
  static const int CONNECTION_TIMEOUT = -2;
  static const int CANCEL = -3;
  static const int RECEIVE_TIMEOUT = -4;
  static const int SEND_TIMEOUT = -5;
  static const int CACHE_ERROR = -6;
  static const int NO_INTERNET_CONNECTION = -7;
}

class ResponseMessage {
  // API status code
  static const String SUCCESS = "Success"; // success with data
  static const String NO_CONTENT =
      "Success, but no content"; // success with no content
  static const String BAD_REQUEST =
      "Bad request. Try again later"; // failure, api rejected the request
  static const String FORBIDDEN =
      "Forbidden request. Try again later"; // failure, api rejected teh Request
  static const String UNAUTHORISED =
      "User is unauthorized."; // failure user in not authorised
  static const String NOT_FOUND =
      "Url not found. Try checking the url"; // failure, api url is not correct and not found..
  static const String INTERNAL_SERVER_ERROR =
      "Something went wrong. Try again later."; // failure, crash in server side
  // Local status code
  static const String UNKNOWN = "Unknown error. Try again later.";
  static const String CONNECTION_TIMEOUT =
      "Connection timeout. Try again later.";
  static const String CANCEL = "Request cancelled. Try again later.";
  static const String RECEIVE_TIMEOUT = "Timeout error. Try again later.";
  static const String SEND_TIMEOUT = "Timeout error. Try again later.";
  static const String CACHE_ERROR = "Cache error. Try again later.";
  static const String NO_INTERNET_CONNECTION =
      "No internet connection. Try again later.";
}

extension StatusCodeExtension on StatusCode {
  Failure getFailure() {
    switch (this) {
      case StatusCode.BAD_REQUEST:
        return Failure(
            ResponseCode.BAD_REQUEST, ResponseMessage.BAD_REQUEST.tr());
      case StatusCode.FORBIDDEN:
        return Failure(ResponseCode.FORBIDDEN, ResponseMessage.FORBIDDEN.tr());
      case StatusCode.UNAUTHORISED:
        return Failure(
            ResponseCode.UNAUTHORISED, ResponseMessage.UNAUTHORISED.tr());
      case StatusCode.NOT_FOUND:
        return Failure(ResponseCode.NOT_FOUND, ResponseMessage.NOT_FOUND.tr());
      case StatusCode.INTERNAL_SERVER_ERROR:
        return Failure(ResponseCode.INTERNAL_SERVER_ERROR,
            ResponseMessage.INTERNAL_SERVER_ERROR.tr());
      case StatusCode.CONNECTION_TIMEOUT:
        return Failure(ResponseCode.CONNECTION_TIMEOUT,
            ResponseMessage.CONNECTION_TIMEOUT.tr());
      case StatusCode.CANCEL:
        return Failure(ResponseCode.CANCEL, ResponseMessage.CANCEL.tr());
      case StatusCode.RECEIVE_TIMEOUT:
        return Failure(
            ResponseCode.RECEIVE_TIMEOUT, ResponseMessage.RECEIVE_TIMEOUT.tr());
      case StatusCode.SEND_TIMEOUT:
        return Failure(
            ResponseCode.SEND_TIMEOUT, ResponseMessage.SEND_TIMEOUT.tr());
      case StatusCode.CACHE_ERROR:
        return Failure(
            ResponseCode.CACHE_ERROR, ResponseMessage.CACHE_ERROR.tr());
      case StatusCode.NO_INTERNET_CONNECTION:
        return Failure(ResponseCode.NO_INTERNET_CONNECTION,
            ResponseMessage.NO_INTERNET_CONNECTION.tr());
      default:
        return Failure(ResponseCode.UNKNOWN, ResponseMessage.UNKNOWN.tr());
    }
  }
}

class ErrorHandler implements Exception {
  late Failure failure;
  ErrorHandler.handle(dynamic error) {
    if (error is DioError) {
      // error is casued from response of api..
      failure = _handleError(error);
    } else {
      // default error..
      failure = StatusCode.UNKNOWN.getFailure();
    }
  }
}

Failure _handleError(DioError error) {
  switch (error.type) {
    case DioErrorType.connectionTimeout:
      return StatusCode.CONNECTION_TIMEOUT.getFailure();
    case DioErrorType.sendTimeout:
      return StatusCode.SEND_TIMEOUT.getFailure();
    case DioErrorType.receiveTimeout:
      return StatusCode.RECEIVE_TIMEOUT.getFailure();
    case DioErrorType.badResponse:
      switch (error.response?.statusCode) {
        case ResponseCode.BAD_REQUEST:
          return StatusCode.BAD_REQUEST.getFailure();
        case ResponseCode.FORBIDDEN:
          return StatusCode.FORBIDDEN.getFailure();
        case ResponseCode.UNAUTHORISED:
          return StatusCode.UNAUTHORISED.getFailure();
        case ResponseCode.NOT_FOUND:
          return StatusCode.NOT_FOUND.getFailure();
        case ResponseCode.INTERNAL_SERVER_ERROR:
          return StatusCode.INTERNAL_SERVER_ERROR.getFailure();
        default:
          return StatusCode.UNKNOWN.getFailure();
      }
    case DioErrorType.cancel:
      return StatusCode.CANCEL.getFailure();
    case DioErrorType.unknown:
      return StatusCode.UNKNOWN.getFailure();
    case DioErrorType.badCertificate:
      return StatusCode.BAD_REQUEST.getFailure();
    case DioErrorType.connectionError:
      return StatusCode.NO_INTERNET_CONNECTION.getFailure();
  }
}

class ApiInternalStatus {
  static const int SUCCESS = 0;
  static const int FAILURE = 1;
}
