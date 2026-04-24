import 'package:http_certificate_pinning/http_certificate_pinning.dart';

import '../../../core.dart';

class Failure {
  /// Maps DioException → AppException (Domain-safe)
  static AppException handleDioError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return TimeoutError();

      case DioExceptionType.badCertificate:
        return HandshakeError();

      case DioExceptionType.connectionError:
        return NoInternetError();

      case DioExceptionType.cancel:
        return AppException(0, 'Request cancelled');

      case DioExceptionType.badResponse:
        return _handleBadResponse(e);

      case DioExceptionType.unknown:
        return _handleUnknownError(e);
    }
  }

  /// Handles non-2xx HTTP responses
  static AppException _handleBadResponse(DioException e) {
    final response = e.response;
    if (response == null) return UnknownError();

    final statusCode = response.statusCode ?? 0;
    final message = _extractMessage(response);

    switch (statusCode) {
      case 400:
        return BadRequestError(statusCode: statusCode, message: message);

      case 401:
        if (_isTokenExpired(response)) {
          return SessionExpiry();
        }
        return UnauthorizedError(statusCode: statusCode, message: message);

      case 403:
        return ForbiddenError(statusCode: statusCode, message: message);

      case 404:
        return NotFoundError(statusCode: statusCode, message: message);

      case 405:
        return MethodNotAllowedError(statusCode: statusCode, message: message);

      case 409:
        return ConflictError(statusCode: statusCode, message: message);

      case 422:
        return UnprocessableEntityError(statusCode: statusCode, message: message, error: response.data);

      case 429:
        return TooManyRequestsError(statusCode: statusCode, message: message);

      case 499:
        return AppRestrictionError(statusCode: statusCode, message: message);

      case 500:
        return ServerError(statusCode: statusCode, message: message);

      case 502:
        return BadGatewayError(statusCode: statusCode, message: message);

      case 503:
        return ServiceUnavailableError();

      case 504:
        return GatewayTimeoutError();

      case 505:
        return HTTPVersionNotSupportedError(statusCode: statusCode, message: message);

      default:
        return UnknownError();
    }
  }

  /// Handles DioExceptionType.unknown
  static AppException _handleUnknownError(DioException e) {
    final error = e.error;

    if (error is SocketException) {
      return NoInternetError();
    }

    if (error is HandshakeException ||
        error is CertificateException ||
        error is CertificateNotVerifiedException ||
        error is CertificateCouldNotBeVerifiedException) {
      return HandshakeError();
    }

    return UnknownError();
  }

  /// Safely extracts message from API response
  static String _extractMessage(Response response) {
    final data = response.data;

    if (data is Map<String, dynamic>) {
      return data['message']?.toString() ?? data['error']?.toString() ?? response.statusMessage ?? 'Something went wrong';
    }

    return response.statusMessage ?? 'Something went wrong';
  }

  /// Detects token expiry (fintech-critical)
  static bool _isTokenExpired(Response response) {
    final data = response.data;

    if (data is Map<String, dynamic>) {
      final message = data['message']?.toString().toLowerCase() ?? '';
      final code = data['code'];

      return code == 'TOKEN_EXPIRED' || message.contains('expired');
    }

    return false;
  }
}
