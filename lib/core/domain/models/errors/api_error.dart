import 'actiontrak_api_error.dart';
import 'api_error_data.dto.dart';

class ApiError extends Error implements Exception {}

abstract class ApiServiceException extends Error implements Exception {
  ApiServiceException({
    this.title,
    this.message,
    this.originalException,
    this.isTemporary = false,
    this.isSilent = false,
  })  : statusCode = originalException?.response?.statusCode ?? 0,
        originalError = originalException?.error,
        responseData = originalException?.response?.data ?? <String, dynamic>{},
        responseError = errorsParse(
          originalException?.response?.data ?? <String, dynamic>{},
        ),
        super();

  final int? statusCode;
  final dynamic originalError;
  final Map<String, dynamic>? responseData;
  final List<ActionTRAKApiError>? responseError;

  /// User-friendly title for the message
  final String? title;

  /// User-friendly message for the exception, should provide solution if possbile
  final String? message;

  /// It is temporary exception, simply retry might work
  final bool? isTemporary;

  /// Should not display the title/message to user via alerts/toast
  final bool? isSilent;

  ///
  final dynamic originalException;

  static List<ActionTRAKApiError> errorsParse(dynamic responseData) {
    final Map<String, dynamic> unknownError = <String, dynamic>{
      'code': ActionTRAKApiErrorCode.api000.rawValue,
      'message': 'Uknown error',
      'parameter': ''
    };
    List<Map<String, dynamic>> errors = <Map<String, dynamic>>[
      unknownError,
    ];
    final dynamic errorsData = responseData['errors'];
    if (errorsData is Map<String, dynamic>) {
      errors.clear();
      errors.add(errorsData);
    } else if ((errorsData is List<dynamic>) && errorsData.isNotEmpty) {
      errors = errorsData.map((dynamic data) {
        if (data is Map<String, dynamic>) {
          return data;
        } else {
          return unknownError;
        }
      }).toList();
    } else if ((errorsData is List<Map<String, dynamic>>) &&
        errorsData.isNotEmpty) {
      errors = errorsData;
    }

    return errors.map<ActionTRAKApiError>((dynamic json) {
      if (json['code'] == '') {
        return const ActionTRAKApiError.unknown();
      }

      return ActionTRAKApiError.fromJson(json);
    }).toList();
  }

  ActionTRAKApiError? get firstError {
    return responseError?.first;
  }

  ApiErrorDataDto? get errorData {
    return ApiErrorDataDto.fromJson(
        responseData?['data'] ?? <String, dynamic>{});
  }

  @override
  String toString() {
    return message ?? title ?? 'null';
  }
}

/// Request is taking too long
class ServerTimeoutException extends ApiServiceException {
  ServerTimeoutException({
    String? title,
    String? message,
    dynamic originalException,
  }) : super(
          title: title,
          originalException: originalException,
          message: message = 'Request timeout',
          isTemporary: true,
        );
}

class DioTimeoutException extends ApiServiceException {
  DioTimeoutException({
    String? title,
    String? message,
    dynamic originalException,
  }) : super(
          title: title,
          originalException: originalException,
          message: message = 'Request timeout',
          isTemporary: true,
        );
}

/// DNS error or server refuse connection (409, too many requests)
class ConnectionException extends ApiServiceException {
  ConnectionException({
    String? title,
    String message = 'Unable to connect',
    dynamic originalException,
  }) : super(
          title: title,
          message: message,
          isTemporary: true,
          originalException: originalException,
        );
}

/// Cannot connect to internet, etc
class NetworkException extends ApiServiceException {
  NetworkException({
    String? title,
    String? message,
    dynamic originalException,
  }) : super(
          title: title,
          message: message,
          isTemporary: true,
          originalException: originalException,
        );
}

/// 5xx error
class ServerException extends ApiServiceException {
  ServerException({
    String? title,
    String? message,
    dynamic originalException,
  }) : super(
          title: title,
          message: message,
          originalException: originalException,
        );
}

/// Token expired or need to login
class UnauthorizedException extends ApiServiceException {
  UnauthorizedException({
    dynamic originalException,
  }) : super(
          isSilent: true,
          originalException: originalException,
        );
}

/// 503 Service Unavailable server error response code indicates that the server is not ready to handle the request.
class ServiceUnavailableException extends ApiServiceException {
  ServiceUnavailableException({
    dynamic originalException,
  }) : super(
          isSilent: true,
          originalException: originalException,
        );
}

/// We don't have access to perform that request. This is 403.
class ForbiddenException extends ApiServiceException {
  ForbiddenException({
    String? title,
    String? message,
    dynamic originalException,
  }) : super(
          title: title,
          message: message,
          originalException: originalException,
        );
}

class DeprecationException extends ApiServiceException {
  DeprecationException({
    dynamic originalException,
  }) : super(
          isSilent: true,
          isTemporary: false,
          originalException: originalException,
        );
}

class RequiredUpdateException extends ApiServiceException {
  RequiredUpdateException({
    String? title,
    String? message,
    dynamic originalException,
  }) : super(
          title: title,
          message: message,
          originalException: originalException,
        );
}

/// Unable to find that resource.  This is a 404.
class NotfoundException extends ApiServiceException {
  NotfoundException({
    String? title,
    String? message,
    dynamic originalException,
  }) : super(
          title: title,
          message: message,
          originalException: originalException,
        );
}

/// Internet service error.  This is a 500.
class ServerError extends ApiServiceException {
  ServerError({
    String? title,
    String? message,
    dynamic originalException,
  }) : super(
          title: title,
          message: message,
          originalException: originalException,
        );
}

/// All other 4xx series errors.
class RejectedException extends ApiServiceException {
  RejectedException({
    String? title,
    String? message,
    dynamic originalException,
  }) : super(
          title: title,
          message: message,
          originalException: originalException,
        );
}

class UnimplementedException extends ApiServiceException {
  UnimplementedException({
    String? title,
    String? message,
    dynamic originalException,
  }) : super(
          title: title,
          message: message,
          originalException: originalException,
        );
}

/// Something truly unexpected happened. Most likely can try again. This is a catch all.
class UnknownException extends ApiServiceException {
  UnknownException({
    String? title,
    String? message,
    dynamic originalException,
    bool isTemporary = true,
    bool isSilent = false,
  }) : super(
          title: title,
          message: message,
          originalException: originalException,
          isTemporary: isTemporary,
          isSilent: isSilent,
        );
}

/// The data we received is not in the expected format, bad data
class ClientException extends ApiServiceException {
  ClientException({
    String? title,
    String? message,
    dynamic originalException,
  }) : super(
          title: title,
          message: message,
          originalException: originalException,
        );
}

/// The client cancel the request
class CancelException extends ApiServiceException {
  CancelException({
    String? title,
    String? message,
    dynamic originalException,
  }) : super(
          title: title,
          message: message,
          isSilent: true,
          originalException: originalException,
        );
}
