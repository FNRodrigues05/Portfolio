import 'package:dart_either/dart_either.dart';

import '../errors/app_error.dart';
import '../repositories/app_repository.dart';

abstract class SaveCounterUseCase {
  factory SaveCounterUseCase(AppRepository repository) = _SaveCounterUseCase;

  Future<Either<AppError, void>> call(int value);
}

class _SaveCounterUseCase implements SaveCounterUseCase {
  final AppRepository _repository;

  _SaveCounterUseCase(this._repository);

  @override
  Future<Either<AppError, void>> call(int value) {
    return _repository.saveCounter(value);
  }
}
