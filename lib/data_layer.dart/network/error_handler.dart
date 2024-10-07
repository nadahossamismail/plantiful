// ignore_for_file: constant_identifier_names

import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:plantiful/data_layer.dart/network/failure.dart';

enum DataSource {
  SUCCESS,
  NO_CONTENT,
  BAD_REQUEST,
  FORBIDDEN,
  UNAUTORISED,
  NOT_FOUND,
  INTERNAL_SERVER_ERROR,
  CONNECT_TIMEOUT,
  CANCEL,
  RECIEVE_TIMEOUT,
  SEND_TIMEOUT,
  CACHE_ERROR,
  DEFAULT,
  UnKNOWN,
  NO_INTERNET_CONNECTION,
}

class ResponseCode {
  static const int SUCCESS = 200;
  static const int NO_CONTENT = 201;
  static const int BAD_REQUEST = 400; // failure , Api rejected request
  static const int UNAUTORISED = 401; // failure , user is unauthorized
  static const int FORBIDDEN = 403;
  static const int NOT_FOUND = 404;
  static const int INTERNAL_SERVER_ERROR = 500;

// local
  static const int CONNECT_TIMEOUT = -1;
  static const int CANCEL = -2;
  static const int RECIEVE_TIMEOUT = -3;
  static const int SEND_TIMEOUT = -4;
  static const int CACHE_ERROR = -5;
  static const int NO_INTERNET_CONNECTION = -6;
  static const int UnKNOWN = -7;
  static const int DEFAULT = -8;
}

class ResponseMessage {
  static const String SUCCESS = "Sucess!";
  static const String NO_CONTENT = "Sucess!";
  static const String BAD_REQUEST = "Bad request";
  static const String UNAUTORISED = "User is unauthorized";
  static const String FORBIDDEN = "Forbidden request";
  static const String INTERNAL_SERVER_ERROR = "Something went wrong";
  static const String NOT_FOUND = "Not found";
  static const String DEFAULT = "Something went wrong, try again later";

// local
  static const String CONNECT_TIMEOUT = "Please check your internet connection";
  static const String CANCEL = "Request was cancelled";
  static const String RECIEVE_TIMEOUT =
      "Please, check your internet connection";
  static const String SEND_TIMEOUT = "Send time out";
  static const String CACHE_ERROR = "Cache error";
  static const String NO_INTERNET_CONNECTION =
      "Please check your internet connection";
  static const String UnKNOWN = "Something went wrong";
}

extension DataSourceExtension on DataSource {
  Failure getFailure() {
    switch (this) {
      case DataSource.SUCCESS:
        return Failure(ResponseCode.SUCCESS, ResponseMessage.SUCCESS);

      case DataSource.UnKNOWN:
        return Failure(ResponseCode.UnKNOWN, ResponseMessage.UnKNOWN);

      case DataSource.NO_CONTENT:
        return Failure(ResponseCode.NO_CONTENT, ResponseMessage.NO_CONTENT);
      case DataSource.BAD_REQUEST:
        return Failure(ResponseCode.BAD_REQUEST, ResponseMessage.BAD_REQUEST);
      case DataSource.FORBIDDEN:
        return Failure(ResponseCode.FORBIDDEN, ResponseMessage.FORBIDDEN);
      case DataSource.UNAUTORISED:
        return Failure(ResponseCode.UNAUTORISED, ResponseMessage.UNAUTORISED);
      case DataSource.NOT_FOUND:
        return Failure(ResponseCode.NOT_FOUND, ResponseMessage.NOT_FOUND);
      case DataSource.INTERNAL_SERVER_ERROR:
        return Failure(ResponseCode.INTERNAL_SERVER_ERROR,
            ResponseMessage.INTERNAL_SERVER_ERROR);
      case DataSource.CONNECT_TIMEOUT:
        return Failure(
            ResponseCode.CONNECT_TIMEOUT, ResponseMessage.CONNECT_TIMEOUT);
      case DataSource.CANCEL:
        return Failure(ResponseCode.CANCEL, ResponseMessage.CANCEL);
      case DataSource.RECIEVE_TIMEOUT:
        return Failure(
            ResponseCode.RECIEVE_TIMEOUT, ResponseMessage.RECIEVE_TIMEOUT);
      case DataSource.SEND_TIMEOUT:
        return Failure(ResponseCode.SEND_TIMEOUT, ResponseMessage.SEND_TIMEOUT);
      case DataSource.CACHE_ERROR:
        return Failure(ResponseCode.CACHE_ERROR, ResponseMessage.CACHE_ERROR);
      case DataSource.NO_INTERNET_CONNECTION:
        return Failure(ResponseCode.NO_INTERNET_CONNECTION,
            ResponseMessage.NO_INTERNET_CONNECTION);
      case DataSource.DEFAULT:
        return Failure(ResponseCode.DEFAULT, ResponseMessage.DEFAULT);
    }
  }
}

Failure _handleError(DioException error) {
  switch (error.type) {
    case DioExceptionType.connectionTimeout:
      return DataSource.CONNECT_TIMEOUT.getFailure();
    case DioExceptionType.sendTimeout:
      return DataSource.SEND_TIMEOUT.getFailure();
    case DioExceptionType.receiveTimeout:
      return DataSource.RECIEVE_TIMEOUT.getFailure();

    case DioExceptionType.badResponse:
      if (error.response != null) {
        if (error.response?.data is String) {
          var message = error.response?.data != ""
              ? error.response?.data
              : "Something went wrong";
          return Failure(error.response?.statusCode ?? 0, message);
        }

        return Failure(error.response?.statusCode ?? 0,
            error.response?.data["message"] ?? "Something went wrong");
      } else {
        return DataSource.DEFAULT.getFailure();
      }

    case DioExceptionType.unknown:
      return DataSource.UnKNOWN.getFailure();
    case DioExceptionType.connectionError:
      return DataSource.CONNECT_TIMEOUT.getFailure();
    case DioExceptionType.cancel:
      return DataSource.CANCEL.getFailure();
    default:
      return DataSource.DEFAULT.getFailure();
  }
}

class ErrorHandler implements Exception {
  late Failure failure;

  ErrorHandler.handle(dynamic error) {
    if (error is DioException) {
      failure = _handleError(error);
      log("from DioExp:$error");
    } else {
      log("from else: $error");
      failure = DataSource.DEFAULT.getFailure();
    }
  }
}
