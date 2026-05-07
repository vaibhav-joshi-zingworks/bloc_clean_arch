import 'package:bloc_clean_arch/core.dart';

/// Base interface for all business logic units (Use Cases).
/// 
/// Every Use Case should represent a single task or operation.
/// [Type] defines the return data type upon success.
/// [Params] defines the input data required to execute the task.
abstract class UseCase<Type,Params> {
  /// Executes the business logic and returns an [Either] of [AppException] or [Type].
  Future<Either<AppException,Type>> call(Params params);
}

/// Placeholder for Use Cases that do not require any input parameters.
class NoParams {}
