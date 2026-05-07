import '../../core.dart';

// --- Future Extensions ---
// These extensions simplify the transformation of Future API responses 
// directly into Domain Entities without manually uncurrying the Either types.

extension ApiFutureEitherX<T>
on Future<Either<AppException, BaseResponse<T>>> {

  /// Maps a [BaseResponse] data payload to a Domain Entity [R].
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

  /// Maps a [BaseResponse] to a simple [ResultMessage].
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

  /// Maps a list of DTOs within a [PaginatedResult] to a list of Domain Entities [R].
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

  /// Maps a [BaseResponse] to a [Result] object, allowing for null data with a success message.
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

// --- Sync Either Extensions ---

extension ApiEitherX<T> on Either<AppException, BaseResponse<T>> {
  
  /// Sync version of [mapEntity].
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

  /// Sync version of [mapPaginated].
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
