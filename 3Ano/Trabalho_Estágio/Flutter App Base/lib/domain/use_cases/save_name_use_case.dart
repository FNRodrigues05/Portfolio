import 'package:dart_either/dart_either.dart';

import '../errors/app_error.dart';
import '../repositories/app_repository.dart';

abstract class SaveNameUseCase {
  factory SaveNameUseCase(AppRepository repository) = _SaveNameUseCase;

  Future<Either<AppError, void>> call(String name);
}

class _SaveNameUseCase implements SaveNameUseCase {
  final AppRepository _repository;

  _SaveNameUseCase(this._repository);

  @override
  Future<Either<AppError, void>> call(String name) {
    return _repository.saveName(name);
  }
}
