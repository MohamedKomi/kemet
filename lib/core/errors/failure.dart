import 'package:dio/dio.dart';

abstract class Failures {
  final String errorMessage;

  const Failures(this.errorMessage);
}

class ServerFailure extends Failures {
  const ServerFailure(super.errorMessage);

  factory ServerFailure.fromDioError(DioException dioError) {
    switch (dioError.type) {
      case DioExceptionType.connectionTimeout:
        return const ServerFailure('Connection timeout with ApiServer');
      case DioExceptionType.sendTimeout:
        return const ServerFailure('Send timeout with ApiServer');

      case DioExceptionType.receiveTimeout:
        return const ServerFailure('Receive timeout with ApiServer');

      case DioExceptionType.badCertificate:
        return const ServerFailure('Bad certificate with ApiServer');

      case DioExceptionType.badResponse:
        return ServerFailure.fromResponse(
            dioError.response!.statusCode!, dioError.response!.data);
      case DioExceptionType.cancel:
        return const ServerFailure('Your request was canceled');
      case DioExceptionType.connectionError:
        return const ServerFailure(
            'Your Internet connection lost, Please try again');

      case DioExceptionType.unknown:
        if (dioError.message!.contains('ServerException')) {
          return const ServerFailure('No internet connection');
        }
        return const ServerFailure(
            'Unexpected error, Please try again later! ');
      default:
        return const ServerFailure(
            'Opps ,There was an error, Please try again!');
    }
  }

  factory ServerFailure.fromResponse(int statusCode, dynamic response) {
    if (statusCode == 400 || statusCode == 401 || statusCode == 403) {
      return ServerFailure(response['message']);
    } else if (statusCode == 404) {
      return const ServerFailure(
          'Your request not found, Please try again later!');
    } else if (statusCode == 500) {
      return const ServerFailure(
          'Internal server error, Please try again later!');
    } else if (statusCode == 0) {//edited
      return ServerFailure(response);
    } else {
      return const ServerFailure('Opps ,There was an error, Please try again!');
    }
  }
}
