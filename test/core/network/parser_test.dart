import 'package:bloc_clean_arch/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockMapper extends Mock implements ResponseMapper<String> {}

void main() {
  late MockMapper mockMapper;

  setUp(() {
    mockMapper = MockMapper();
  });

  group('Parser.parseBaseResponse', () {
    test('should return Right(BaseResponse) when status is true', () async {
      // arrange
      final response = Response(
        requestOptions: RequestOptions(path: ''),
        data: {
          'status': true,
          'message': 'Success',
          'data': 'some data',
        },
      );
      when(() => mockMapper.fromJson(any())).thenReturn('parsed data');

      // act
      final result = await Parser.parseBaseResponse<String>(response, mockMapper);

      // assert
      expect(result.isRight(), true);
      result.fold(
        (l) => fail('Should be Right'),
        (r) {
          expect(r.status, true);
          expect(r.data, 'parsed data');
        },
      );
    });

    test('should return Left(ValidationError) when status is false', () async {
      // arrange
      final response = Response(
        requestOptions: RequestOptions(path: ''),
        data: {
          'status': false,
          'message': 'Error message',
        },
      );

      // act
      final result = await Parser.parseBaseResponse<String>(response, mockMapper);

      // assert
      expect(result.isLeft(), true);
      result.fold(
        (l) => expect(l, isA<ValidationError>()),
        (r) => fail('Should be Left'),
      );
    });

    test('should return Left(ParsingError) when an exception occurs', () async {
      // arrange
      final response = Response(
        requestOptions: RequestOptions(path: ''),
        data: 'not a map',
      );

      // act
      final result = await Parser.parseBaseResponse<String>(response, mockMapper);

      // assert
      expect(result.isLeft(), true);
      result.fold(
        (l) => expect(l, isA<ParsingError>()),
        (r) => fail('Should be Left'),
      );
    });
  });
}
