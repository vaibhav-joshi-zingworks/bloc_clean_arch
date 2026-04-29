import 'package:bloc_clean_arch/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockDio extends Mock implements Dio {}
class MockMapper extends Mock implements ResponseMapper<String> {}

void main() {
  late NetworkApiService service;
  late MockDio mockDio;
  late MockMapper mockMapper;

  setUp(() {
    mockDio = MockDio();
    mockMapper = MockMapper();
    service = NetworkApiService(mockDio);
  });

  final tResponseData = {
    'status': true,
    'message': 'success',
    'data': 'data'
  };

  group('NetworkApiService - BaseApiService Methods', () {
    test('get should return Right when successful', () async {
      when(() => mockDio.get(any(), options: any(named: 'options'), queryParameters: any(named: 'queryParameters'), cancelToken: any(named: 'cancelToken')))
          .thenAnswer((_) async => Response(
                requestOptions: RequestOptions(path: 'test'),
                data: tResponseData,
                statusCode: 200,
              ));
      when(() => mockMapper.fromJson(any())).thenReturn('parsed data');

      final result = await service.get<String>('test', mockMapper);

      expect(result.isRight(), true);
    });

    test('post should return Right when successful', () async {
      when(() => mockDio.post(any(), data: any(named: 'data'), options: any(named: 'options'), queryParameters: any(named: 'queryParameters'), cancelToken: any(named: 'cancelToken')))
          .thenAnswer((_) async => Response(
                requestOptions: RequestOptions(path: 'test'),
                data: tResponseData,
                statusCode: 200,
              ));
      when(() => mockMapper.fromJson(any())).thenReturn('parsed data');

      final result = await service.post<String>('test', mockMapper, body: {'key': 'val'});

      expect(result.isRight(), true);
    });

    test('put should return Right when successful', () async {
      when(() => mockDio.put(any(), data: any(named: 'data'), options: any(named: 'options'), queryParameters: any(named: 'queryParameters'), cancelToken: any(named: 'cancelToken')))
          .thenAnswer((_) async => Response(
                requestOptions: RequestOptions(path: 'test'),
                data: tResponseData,
                statusCode: 200,
              ));
      when(() => mockMapper.fromJson(any())).thenReturn('parsed data');

      final result = await service.put<String>('test', mockMapper, body: {'key': 'val'});

      expect(result.isRight(), true);
    });

    test('delete should return Right when successful', () async {
      when(() => mockDio.delete(any(), data: any(named: 'data'), options: any(named: 'options'), queryParameters: any(named: 'queryParameters'), cancelToken: any(named: 'cancelToken')))
          .thenAnswer((_) async => Response(
                requestOptions: RequestOptions(path: 'test'),
                data: tResponseData,
                statusCode: 200,
              ));
      when(() => mockMapper.fromJson(any())).thenReturn('parsed data');

      final result = await service.delete<String>('test', mockMapper);

      expect(result.isRight(), true);
    });

    test('patch should return Right when successful', () async {
      when(() => mockDio.patch(any(), data: any(named: 'data'), options: any(named: 'options'), queryParameters: any(named: 'queryParameters'), cancelToken: any(named: 'cancelToken')))
          .thenAnswer((_) async => Response(
                requestOptions: RequestOptions(path: 'test'),
                data: tResponseData,
                statusCode: 200,
              ));
      when(() => mockMapper.fromJson(any())).thenReturn('parsed data');

      final result = await service.patch<String>('test', mockMapper);

      expect(result.isRight(), true);
    });

    test('should return Left(NoInternetError) when connection fails', () async {
      when(() => mockDio.get(any(), options: any(named: 'options'), queryParameters: any(named: 'queryParameters'), cancelToken: any(named: 'cancelToken')))
          .thenThrow(DioException(requestOptions: RequestOptions(path: 'test'), type: DioExceptionType.connectionError));

      final result = await service.get<String>('test', mockMapper);

      expect(result.isLeft(), true);
      result.fold((l) => expect(l, isA<NoInternetError>()), (r) => fail('Should be Left'));
    });
  });
}
