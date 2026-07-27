import 'package:dart_either/dart_either.dart';

import '../errors/app_error.dart';
import '../repositories/app_repository.dart';

abstract class GetCounterUseCase {
  factory GetCounterUseCase(AppRepository repository) = _GetCounterUseCase;

  Future<Either<AppError, int?>> call();
}

class _GetCounterUseCase implements GetCounterUseCase {
  final AppRepository _repository;

  _GetCounterUseCase(this._repository);

  @override
  Future<Either<AppError, int?>> call() {
    return _repository.getCounter();
  }
}
