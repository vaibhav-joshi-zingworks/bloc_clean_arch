/// Base class for all domain-specific exceptions in the application.
/// 
/// It encapsulates an error [code] and a user-friendly [message].
class AppException implements Exception {
  final int code;
  final String message;

  AppException(this.code, this.message);

  /// Constructor for validation-related errors (usually code 0).
  AppException.validation(this.message, {this.code = 0});

  @override
  String toString() => 'AppException(code: $code, message: $message)';
}

// --- Connectivity Errors ---

/// Thrown when the device has no active internet connection.
class NoInternetError extends AppException {
  NoInternetError() : super(503, 'No internet connection');
}

/// Thrown when a network request exceeds the allocated time limit.
class TimeoutError extends AppException {
  TimeoutError() : super(504, 'The request timed out');
}

/// Thrown when SSL/TLS certificate validation fails.
class HandshakeError extends AppException {
  HandshakeError() : super(526, 'SSL Handshake failed');
}

// --- Authentication & Authorization ---

/// Thrown when the user's session token is no longer valid.
class SessionExpiry extends AppException {
  SessionExpiry() : super(401, 'Session has expired');
}

/// Thrown when the user does not have permission to access a resource.
class ForbiddenError extends AppException {
  ForbiddenError({int? statusCode, String? message}) : super(statusCode ?? 403, message ?? 'Forbidden');
}

/// Thrown when the user is not logged in or has invalid credentials.
class UnauthorizedError extends AppException {
  UnauthorizedError({int? statusCode, String? message}) : super(statusCode ?? 401, message ?? 'Session Timeout, Please login.');
}

// --- Server & API Errors ---

/// Fallback for errors that don't match any specific category.
class UnknownError extends AppException {
  UnknownError() : super(520, 'An unknown error occurred');
}

/// Thrown when the application fails to parse the API response.
class ParsingError extends AppException {
  ParsingError() : super(520, 'Error parsing response data');
}

/// Thrown for 404 Not Found responses.
class NotFoundError extends AppException {
  NotFoundError({int? statusCode, String? message}) : super(statusCode ?? 404, message ?? 'Resource not found');
}

/// Thrown for 500 Internal Server Error responses.
class ServerError extends AppException {
  ServerError({int? statusCode, String? message}) : super(statusCode ?? 500, message ?? 'Internal server error');
}

/// Thrown for 400 Bad Request responses.
class BadRequestError extends AppException {
  BadRequestError({int? statusCode, String? message}) : super(statusCode ?? 400, message ?? 'Bad request');
}

/// Thrown for 422 Unprocessable Entity (usually validation errors from server).
class UnprocessableEntityError extends AppException {
  UnprocessableEntityError({int? statusCode, String? message, required error})
    : super(statusCode ?? 422, message ?? 'Unprocessable entity');
}

/// Thrown for 409 Conflict responses.
class ConflictError extends AppException {
  ConflictError({int? statusCode, String? message}) : super(statusCode ?? 409, message ?? 'Conflict');
}

/// Thrown for 503 Service Unavailable responses.
class ServiceUnavailableError extends AppException {
  ServiceUnavailableError() : super(503, 'Service temporarily unavailable');
}

/// Thrown for 504 Gateway Timeout responses.
class GatewayTimeoutError extends AppException {
  GatewayTimeoutError() : super(504, 'Gateway timeout');
}

/// Thrown for 412 Precondition Failed responses.
class PreconditionFailedError extends AppException {
  PreconditionFailedError({int? statusCode, String? message}) : super(statusCode ?? 412, message ?? 'Precondition failed');
}

/// Specific error for duplicate user registration.
class UserExistsError extends AppException {
  UserExistsError({int? statusCode, String? message}) : super(statusCode ?? 422, message ?? 'User already exists');
}

/// General validation error for client-side checks.
class ValidationError extends AppException {
  ValidationError({int? statusCode, String? message}) : super(statusCode ?? 0, message ?? 'Something went wrong!');
}

/// Thrown for 405 Method Not Allowed responses.
class MethodNotAllowedError extends AppException {
  MethodNotAllowedError({int? statusCode, String? message})
    : super(statusCode ?? 405, message ?? 'Method Not Allowed: The HTTP method used is not supported for the requested resource.');
}

/// Thrown for 429 Too Many Requests (Rate limiting).
class TooManyRequestsError extends AppException {
  TooManyRequestsError({int? statusCode, String? message})
    : super(statusCode ?? 429, message ?? 'Too Many Requests: You have sent too many requests in a given amount of time.');
}

/// Thrown for custom 499 status codes related to app-level restrictions.
class AppRestrictionError extends AppException {
  AppRestrictionError({int? statusCode, String? message})
    : super(statusCode ?? 499, message ?? 'App restricted, Please try again after some time.');
}

/// Thrown for 502 Bad Gateway responses.
class BadGatewayError extends AppException {
  BadGatewayError({int? statusCode, String? message})
    : super(
        statusCode ?? 502,
        message ?? 'Bad Gateway: The server received an invalid response from an upstream server.',
      );
}

/// Thrown for 505 HTTP Version Not Supported responses.
class HTTPVersionNotSupportedError extends AppException {
  HTTPVersionNotSupportedError({int? statusCode, String? message})
    : super(
        statusCode ?? 505,
        message ?? 'HTTP Version Not Supported: The server does not support the HTTP protocol version used.',
      );
}

/// Represents errors occurring during payment processing.
class PaymentError extends AppException {
  PaymentError({int? statusCode, String? message, dynamic data}) : super(statusCode ?? 600, message ?? 'Payment Failed');
}
