import 'dart:io';
import 'package:bloc_clean_arch/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  group('Failure.handleDioError', () {
    test('should return TimeoutError on connectionTimeout', () {
      final dioException = DioException(
        requestOptions: RequestOptions(path: ''),
        type: DioExceptionType.connectionTimeout,
      );
      final result = Failure.handleDioError(dioException);
      expect(result, isA<TimeoutError>());
    });

    test('should return NoInternetError on connectionError', () {
      final dioException = DioException(
        requestOptions: RequestOptions(path: ''),
        type: DioExceptionType.connectionError,
      );
      final result = Failure.handleDioError(dioException);
      expect(result, isA<NoInternetError>());
    });

    test('should return NoInternetError on unknown type with SocketException', () {
      final dioException = DioException(
        requestOptions: RequestOptions(path: ''),
        type: DioExceptionType.unknown,
        error: const SocketException(''),
      );
      final result = Failure.handleDioError(dioException);
      expect(result, isA<NoInternetError>());
    });

    test('should return UnauthorizedError on 401 status code', () {
      final dioException = DioException(
        requestOptions: RequestOptions(path: ''),
        type: DioExceptionType.badResponse,
        response: Response(
          requestOptions: RequestOptions(path: ''),
          statusCode: 401,
          data: {'message': 'Unauthorized'},
        ),
      );
      final result = Failure.handleDioError(dioException);
      expect(result, isA<UnauthorizedError>());
      expect(result.message, 'Unauthorized');
    });

    test('should return SessionExpiry on 401 with token expired message', () {
      final dioException = DioException(
        requestOptions: RequestOptions(path: ''),
        type: DioExceptionType.badResponse,
        response: Response(
          requestOptions: RequestOptions(path: ''),
          statusCode: 401,
          data: {'message': 'token expired'},
        ),
      );
      final result = Failure.handleDioError(dioException);
      expect(result, isA<SessionExpiry>());
    });
  });
}
