import 'package:bloc_clean_arch/core.dart';
import 'package:bloc_clean_arch/core/response/base_response_extensions.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ApiFutureEitherX', () {
    test('mapEntity should return Right with mapped data when response has data', () async {
      final future = Future.value(Right(BaseResponse<int>(status: true, message: 'ok', data: 1)));
      final result = await future.mapEntity((data) => 'Value: $data');
      
      expect(result, const Right('Value: 1'));
    });

    test('mapEntity should return Left(UnknownError) when response data is null', () async {
      final future = Future.value(Right(BaseResponse<int>(status: true, message: 'ok', data: null)));
      final result = await future.mapEntity((data) => 'Value: $data');
      
      expect(result.isLeft(), true);
      result.fold((l) => expect(l, isA<UnknownError>()), (r) => fail('Should be Left'));
    });
  });

  group('ApiFutureEitherMessageX', () {
    test('mapMessage should return Right(ResultMessage) with response message', () async {
      final future = Future.value(Right(BaseResponse<int>(status: true, message: 'Success message', data: null)));
      final result = await future.mapMessage();
      
      expect(result, const Right(ResultMessage(message: 'Success message')));
    });
  });

  group('ApiFutureEitherPaginatedX', () {
    test('mapPaginated should map items correctly', () async {
      final paginatedResult = PaginatedResult<int>(
        items: [1, 2],
        pagination: const Pagination(total: 2, page: 1, limit: 10, totalPages: 1),
        message: 'ok',
      );
      final future = Future.value(Right(BaseResponse<PaginatedResult<int>>(
        status: true,
        message: 'ok',
        data: paginatedResult,
        pagination: paginatedResult.pagination,
      )));

      final result = await future.mapPaginated((data) => 'Value $data');

      expect(result.isRight(), true);
      result.fold((l) => fail('Should be Right'), (r) {
        expect(r.items, ['Value 1', 'Value 2']);
        expect(r.pagination?.total, 2);
      });
    });
  });

  group('ApiFutureEitherResultX', () {
    test('mapResult should return Right(Result) with mapped data', () async {
      final future = Future.value(Right(BaseResponse<int>(status: true, message: 'Success', data: 42)));
      final result = await future.mapResult((data) => data.toString());

      expect(result.isRight(), true);
      result.fold((l) => fail('Should be Right'), (r) {
        expect(r.data, '42');
        expect(r.message, 'Success');
      });
    });
  });
}
