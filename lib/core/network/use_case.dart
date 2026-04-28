import 'package:bloc_clean_arch/core.dart';

abstract class UseCase<Type,Params> {
  Future<Either<AppException,Type>> call(Params params);
}

class NoParams {}