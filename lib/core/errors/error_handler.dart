import 'package:dio/dio.dart';

abstract class Failure {
  final String message;
  Failure(this.message);
}

class ServerFailure extends Failure {
  ServerFailure(super.message);
}

class NetworkFailure extends Failure {
  NetworkFailure(super.message);
}

class CacheFailure extends Failure {
  CacheFailure(super.message);
}

class ErrorHandler {
  static String handle(dynamic error) {
    if (error is DioException) {
      switch (error.type) {
        case DioExceptionType.connectionTimeout:
          return "Connection timeout with API server";
        case DioExceptionType.sendTimeout:
          return "Send timeout in association with API server";
        case DioExceptionType.receiveTimeout:
          return "Receive timeout in connection with API server";
        case DioExceptionType.badResponse:
          return _handleError(error.response?.statusCode, error.response?.data);
        case DioExceptionType.cancel:
          return "Request to API server was cancelled";
        case DioExceptionType.connectionError:
          return "No Internet Connection";
        default:
          return "Unexpected error occurred";
      }
    } else if (error is TypeError || error is FormatException) {
      return "Data conversion error - something went wrong with the data format";
    } else {
      return "Something went wrong. Please try again later.";
    }
  }

  static String _handleError(int? statusCode, dynamic error) {
    if (error != null && error is Map) {
      if (error['data'] != null) {
        if (error['data'] is Map && error['data']['message'] != null) {
          return error['data']['message'].toString();
        } else if (error['data'] is String) {
          return error['data'];
        }
      }
      if (error['message'] != null) {
        return error['message'].toString();
      }
    }

    switch (statusCode) {
      case 400:
        return 'Bad request';
      case 401:
        return 'Unauthorized';
      case 403:
        return 'Forbidden';
      case 404:
        return 'Not found';
      case 500:
        return 'Internal server error';
      case 502:
        return 'Bad gateway';
      default:
        return 'Oops something went wrong';
    }
  }
}
