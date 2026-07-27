import 'package:dart_either/dart_either.dart';

import '../errors/app_error.dart';
import '../repositories/app_repository.dart';

abstract class GetNameUseCase {
  factory GetNameUseCase(AppRepository repository) = _GetNameUseCase;

  Future<Either<AppError, String?>> call();
}

class _GetNameUseCase implements GetNameUseCase {
  final AppRepository _repository;

  _GetNameUseCase(this._repository);

  @override
  Future<Either<AppError, String?>> call() {
    return _repository.getName();
  }
}
