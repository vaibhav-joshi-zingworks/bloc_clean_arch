import '../../core.dart';

/// ================= FUTURE EXTENSIONS =================

extension ApiFutureEitherX<T>
on Future<Either<AppException, BaseResponse<T>>> {

  Future<Either<AppException, R>> mapEntity<R>(
      R Function(T data) mapper,
      ) async {
    final either = await this;

    return either.fold(
          (failure) => Left(failure),
          (response) {
        final data = response.data;
        if (data == null) {
          return Left(UnknownError());
        }
        return Right(mapper(data));
      },
    );
  }

  Future<Either<AppException, ResultMessage>> mapMessage() async {
    final either = await this;

    return either.fold(
          (failure) => Left(failure),
          (response) => Right(
        ResultMessage(message: response.message),
      ),
    );
  }
}

extension ApiFutureEitherPaginatedX<T>
on Future<Either<AppException, BaseResponse<PaginatedResult<T>>>> {

  Future<Either<AppException, PaginatedResult<R>>> mapPaginated<R>(
      R Function(T data) mapper,
      ) async {
    final either = await this;

    return either.fold(
          (failure) => Left(failure),
          (response) {
        final paginated = response.data;

        if (paginated == null) {
          return Left(UnknownError());
        }

        final mappedItems = paginated.items.map(mapper).toList();

        return Right(
          PaginatedResult<R>(
            items: mappedItems,
            pagination: paginated.pagination,
            message: paginated.message,
          ),
        );
      },
    );
  }
}

extension ApiFutureEitherResultX<T>
on Future<Either<AppException, BaseResponse<T>>> {

  Future<Either<AppException, Result<R>>> mapResult<R>(
      R Function(T data) mapper,
      ) async {
    final either = await this;

    return either.fold(
          (failure) => Left(failure),
          (response) {
        final data = response.data;

        if (data != null) {
          return Right(
            Result<R>(
              data: mapper(data),
              message: response.message,
            ),
          );
        }

        return Right(
          Result<R>(
            data: null,
            message: response.message,
          ),
        );
      },
    );
  }
}

/// ================= EITHER EXTENSIONS =================

extension ApiEitherX<T> on Either<AppException, BaseResponse<T>> {
  Either<AppException, R> mapEntity<R>(
      R Function(T data) mapper,
      ) {
    return fold(
          (failure) => Left(failure),
          (response) {
        final data = response.data;

        if (data == null) {
          return Left(UnknownError());
        }

        return Right(mapper(data));
      },
    );
  }
}
extension ApiEitherPaginatedX<T>
on Either<AppException, BaseResponse<PaginatedResult<T>>> {

  Either<AppException, PaginatedResult<R>> mapPaginated<R>(
      R Function(T data) mapper,
      ) {
    return fold(
          (failure) => Left(failure),
          (response) {
        final paginated = response.data;

        if (paginated == null) {
          return Left(UnknownError());
        }

        final mappedItems = paginated.items.map(mapper).toList();

        return Right(
          PaginatedResult<R>(
            items: mappedItems,
            pagination: paginated.pagination,
            message: paginated.message,
          ),
        );
      },
    );
  }
}
