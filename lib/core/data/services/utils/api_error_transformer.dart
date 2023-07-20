import 'dart:io';

import 'package:mobile_warehouse/core/domain/models/errors/api_error.dart';

class ApiErrorTransformer {
  static ApiServiceException transform(dynamic exception) {
    // return `ApiServiceException` if type is abstract
    if (exception is ApiServiceException) return exception;

    const String defaultErrorMessage = 'Oops! Something went wrong!';

    /*if (exception is DioError) {
      switch (exception.type) {
        case DioErrorType.connectTimeout:
        case DioErrorType.receiveTimeout:
        case DioErrorType.sendTimeout:
          return DioTimeoutException(
            title: exception.error,
            message: exception.message,
            originalException: exception,
          );

        case DioErrorType.cancel:
          return CancelException();

        case DioErrorType.other:
          final dynamic error = exception.error;
          if (error != null && error is SocketException) {
            return ConnectionException(
              originalException: exception,
            );
          }
          break;

        default:
      }*/

    if (exception.error is HttpException) {
      return ConnectionException(
        originalException: exception,
      );
    }

    /*if (exception.type == DioErrorType.response) {
        final Map<String, dynamic> data =
            exception.response?.data is Map<String, dynamic>
                ? exception.response?.data
                : <String, dynamic>{};
        final String? title = data['title'] ?? data['errorTitle'];
        final String message = data['message'] ??
            data['errorMessage'] ??
            data['msg'] ??
            (title == null ? defaultErrorMessage : null);

        final String? dataTitle =
            (data['data'] != null) ? data['data']['title'] : null;
        final String? dataDescription =
            (data['data'] != null) ? data['data']['description'] : null;
        switch (exception.response?.statusCode) {
          case 400:
            final UnimplementedException unimplementedException =
                UnimplementedException(
              title: title,
              message: message,
              originalException: exception,
            );

            if (unimplementedException.firstError?.code ==
                ActionTRAKApiErrorCode.api000) {
              return unimplementedException;
            }

            final RejectedException transformedException = RejectedException(
              title: title,
              message: message,
              originalException: exception,
            );

            if (transformedException.firstError?.code !=
                ActionTRAKApiErrorCode.api101) {
              return transformedException;
            }

            return UnauthorizedException(
              originalException: exception,
            );
          case 401:
            return UnauthorizedException(
              originalException: exception,
            );
          case 403:
            return ForbiddenException(
              title: 'Forbidden messages',
              message: 'You do not have access resource for now',
              originalException: exception,
            );
          case 404:
            return NotfoundException(
              title: title,
              message: message,
              originalException: exception,
            );
          case 410:
            return DeprecationException(
              originalException: exception,
            );
          case 426:
            return RequiredUpdateException(
              title: title,
              message: message,
              originalException: exception,
            );
          case 500:
            return ServerError(
              title: title,
              message: message,
              originalException: exception,
            );
          case 503:
            if (dataTitle?.toLowerCase() == 'update required') {
              return RequiredUpdateException(
                title: dataTitle,
                message: dataDescription,
                originalException: exception,
              );
            } else {
              return ServiceUnavailableException(
                originalException: exception,
              );
            }
          case 504:
            return ServerTimeoutException(
              title: title,
              message: message,
              originalException: exception,
            );
          default:
            break;
        }
      }
    }*/

    return UnknownException(
      message: defaultErrorMessage,
      originalException: exception,
    );
  }
}
