

import '../../core.dart';

extension ApiFutureEitherX<T> on Future<Either<AppException, BaseResponse<T>>> {
  Future<Either<AppException, R>> mapEntity<R>(R Function(T data) mapper) {
    return then(
      (either) => either.fold(Left.new, (response) {
        final data = response.data;
        if (data == null) {
          return Left(UnknownError());
        }
        return Right(mapper(data));
      }),
    );
  }
}

extension ApiFutureEitherMessageX<T> on Future<Either<AppException, BaseResponse<T>>> {
  Future<Either<AppException, ResultMessage>> mapMessage() {
    return then((either) => either.fold(Left.new, (response) => Right(ResultMessage(message: response.message))));
  }
}

extension ApiFutureEitherPaginatedX<T> on Future<Either<AppException, BaseResponse<PaginatedResult<T>>>> {
  Future<Either<AppException, PaginatedResult<R>>> mapPaginated<R>(R Function(T data) mapper) {
    return then(
      (either) => either.fold(Left.new, (response) {
        if (response.data == null) {
          return Right(PaginatedResult<R>(items: [], pagination: response.pagination, message: response.message));
        }

        final mappedItems = response.data!.items.map(mapper).toList();

        return Right(PaginatedResult<R>(items: mappedItems, pagination: response.pagination, message: response.message));
      }),
    );
  }
}

extension ApiFutureEitherResultX<T> on Future<Either<AppException, BaseResponse<T>>> {
  Future<Either<AppException, Result<R>>> mapResult<R>(R Function(T data) mapper) {
    return then(
      (either) => either.fold((failure) => Left(failure), (response) {
        final data = response.data;

        if (data != null) {
          return Right(Result<R>(data: mapper(data), message: response.message));
        }

        if (response.message.isNotEmpty) {
          return Right(Result<R>(data: null, message: response.message));
        }

        return Right(Result<R>(data: null, message: null));
      }),
    );
  }
}
