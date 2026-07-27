import 'package:dart_either/dart_either.dart';

import '../errors/app_error.dart';
import '../repositories/app_repository.dart';

abstract class ClearAllUseCase {
  factory ClearAllUseCase(AppRepository repository) = _ClearAllUseCase;

  Future<Either<AppError, void>> call();
}

class _ClearAllUseCase implements ClearAllUseCase {
  final AppRepository _repository;

  _ClearAllUseCase(this._repository);

  @override
  Future<Either<AppError, void>> call() {
    return _repository.clearAll();
  }
}
