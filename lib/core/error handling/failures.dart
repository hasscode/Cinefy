import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class Failures {
  final String errMessage;
  Failures(this.errMessage);
}

class ServerFailure extends Failures {
  ServerFailure(super.errMessage);

  factory ServerFailure.fromDioException(DioException dioException) {
    switch (dioException.type) {
      case DioExceptionType.connectionTimeout:
        return ServerFailure('Connection Timeout');
      case DioExceptionType.sendTimeout:
        return ServerFailure('Send Timeout');
      case DioExceptionType.receiveTimeout:
        return ServerFailure('Receive Timeout');
      case DioExceptionType.badCertificate:
        return ServerFailure('Bad Certificate');
      case DioExceptionType.badResponse:
        return ServerFailure.fromResponse(
          dioException.response?.statusCode ?? 0,
          dioException.response?.data,
        );
      case DioExceptionType.cancel:
        return ServerFailure('Request Cancelled');
      case DioExceptionType.connectionError:
        return ServerFailure('Internet Connection not found');
      case DioExceptionType.unknown:
        return ServerFailure("Unexpected Error: ${dioException.message}");
    }
  }

  factory ServerFailure.fromResponse(int status, dynamic response) {
    if (status == 400 || status == 401 || status == 403) {
      return ServerFailure(response['status_message']);
    } else if (status == 404) {
      return ServerFailure('Error: Not found');
    } else if (status == 500) {
      return ServerFailure('Internal Server Error');
    } else {
      return ServerFailure('Error, Try Again later');
    }
  }
  factory ServerFailure.fromSuccessBody(Map<String, dynamic> json) {
    return ServerFailure(json['status_message'] ?? 'Unknown error');
  }

  factory ServerFailure.fromFirebaseAuth(FirebaseAuthException exception) {
    final message = exception.message ?? "Unexpected Firebase error";

    if (message.contains(']')) {
      return ServerFailure(message.split(']').last.trim());
    }
    return ServerFailure(message);
  }
}